<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>ePubReader</title>
<meta name="description" content="">
<meta name="viewport"
	content="initial-scale=0.3, minimum-scale=0.3, maximum-scale=1.0, user-scalable=yes">
<meta name="apple-mobile-web-app-capable" content="yes">

<script src="${baseURL}/js/ebook/build/epub.min.js"></script>
<script src="${baseURL}/js/ebook/build/libs/zip.min.js"></script>
<script src="${baseURL}/js/ebook/epubhelp.js"></script>
<script src="${baseURL}/js/ebook/jquery-2.1.0.min.js"></script>

<!-- Render -->
<script src="${baseURL}/js/ebook/epub.min.js"></script>

<!-- Hooks -->
<script src="${baseURL}/js/ebook/hooks.min.js"></script>

<!-- Reader -->
<script src="${baseURL}/js/ebook/reader.min.js"></script>

<!-- Plugins -->
<script src="${baseURL}/js/ebook/plugins/search.js"></script>

<!-- Highlights -->
<script src="${baseURL}/js/ebook/jquery.highlight.js"></script>
<script src="${baseURL}/js/ebook/extensions/highlight.js"></script>

<!-- Full Screen -->
<!-- <script src="js/libs/screenfull.min.js"></script> -->

<!-- sidebar -->
<script src="${baseURL}/js/ebook/simpler-sidebar/dist/jquery-ui.min.js"></script>
<script src="${baseURL}/js/ebook/simpler-sidebar/dist/jquery.simple-sidebar.min.js"></script>

<!-- CSS -->
<!-- <link rel="stylesheet" href="basic.css"> -->
<link rel="stylesheet" href="${baseURL}/css/ebook/main.css">
<link rel="stylesheet" href="${baseURL}/css/ebook/normalize.css">
<link rel="stylesheet" type="text/css" href="${baseURL}/css/ebook/sidebar-style.css">
<style type="text/css">
@font-face {
  font-family: 'fontello';
  src: url('${baseURL}/font/fontello.eot?60518104');
  src: url('${baseURL}/font/fontello.eot?60518104#iefix') format('embedded-opentype'),
       url('${baseURL}/font/fontello.woff?60518104') format('woff'),
       url('${baseURL}/font/fontello.ttf?60518104') format('truetype'),
       url('${baseURL}/font/fontello.svg?60518104#fontello') format('svg');
  font-weight: normal;
  font-style: normal;
}
</style>

<script>
	"use strict";
	var userid = "testUser"; // ユーザID
	var booktitle = "${selected}";
	//ePubファイルのパス(unzipしたファイルのルートパスで、必ず/で終わる)
	var ePubFilePath = "${baseURL}/eBook/unzipped/"+booktitle+"/";
	//どこから移動したかを記録する
	var oldChapter = 0, oldPage = 1;
	// BookmarkedPages["chapter-pages"]=true(bookmarked) or false(not bookmarked)
	// ex. BookmarkedPages[1-2]=true means "chapter 1 page 2 is bookmarked"
	var BookmarkedPages = new Object();
	// HighlightedStrings
	var HighlightedStrings = new Object();
	//memo
	var memorandum = new Object();
	//利用端末
	var deviceCode = "testDevice";
	//授業コード
	var classCode = "testClass";
	//ブラウザコード
	var browserName = "testBrowser";

	var query = window.location.search.substring(1);
	var element = query.split('=');
	//var paramName = decodeURIComponent( element[ 0 ] );
	var paramValue = decodeURIComponent(element[1]);
	//メディアファイルが入るフォルダ名は任意に設定可能(OPSやOEBPSが多いが...)なので、その名前を特定する
	var mediaFilesName = mediaLocationCheck(ePubFilePath);

	//ウィンドウサイズ
	var windowWidth = window.innerWidth;
	var windowHeight = window.innerHeight;

	//ビューモード(0:スライドビュー、1:テキストビュー)
	var viewmode = 0;



	//描画時の幅と高さと開くファイルを指定
	var Book = ePub(ePubFilePath, {
		width : 768,
		height : 1024,
		spreads : false
	});

	$(function() {
		$('#close').click(function() { //CLOSEボタンの処理
			document.location = "${baseURL}/ebook";
		});
		$('#bookmark').click(function() { //bookmarkボタンの処理(詳細はepubhelp.js内のBookmarkPage関数で定義)
			BookmarkPage();
			onBookmarked();
		});
		$('#memo').click(function() { //memoボタンの処理(詳細はepubhelp.js内のmemoFunc関数で定義)
			memoFunc();
		});
		$('#saveBtn').click(function() { //memo保存用ボタンの処理(詳細はepubhelp.js内のsaveMemo関数で定義)
			saveMemo();
		});
		$('#searchBtn').click(function() { //検索ボタンの処理(詳細はepubhelp.js内のsaveMemo関数で定義)
			searchFunc();
		});
		$('#viewmodechange').click(function() { //ビューモード切替
			viewmodeChangeFunc();
		});
		$("#highlighting").click(function(){
			HighlightString();
		});
		$("#showBookmarkList").click(function(){
			showBookmarkListFunc();
		});
		$("#memorandum").each(function(){ //メモの内容が変わった際に呼び出される処理
			$(this).bind('keyup', memoChanged(this));
		});
		$('body').keyup(function(e){
			switch(e.which){
				case 37: // 「←」を押したとき
					Book.prevPage();
					break;

				case 38: // 「↑」を押したとき
					break;

				case 39: // 「→」を押したとき
					Book.nextPage();
					break;

				case 40: //「↓」を押したとき
					break;

			}
		});
		window.onresize=function(){ //ウィンドウサイズ変化時
			windowSizeChanged();
		};

		function logmake(ac, tg){ //acはアクションコード, tgはターゲットでいずれもString。これらを受け、ログのjsonオブジェクトにして返す。
			var now = new Date();
			var day = now.getFullYear() + "/" + now.getMonth() + "/" + now.getDate();
			var time = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();
			//userid, booktitleは既知
			var ActionCode = ac;
			var ChapterNum = Book.getChapter();
			var PageNum = Book.getPage();
			//deviceCodeは既知
			var Target = tg;
			//classCode, WindowHeight, WindowHeight, browserNameは既知
			var JSONdata = {
					"DATE" : day,
					"TIME" : time,
					"USER_ID" : userid,
					"BOOK_TITLE" : booktitle,
					"ACTION_CODE" : ActionCode,
					"CHAPTER_NUMBER" : ChapterNum,
					"PAGE_NUMBER" : PageNum,
					"DEVICE" : deviceCode,
					"TARGET" : Target,
					"CLASS_CODE" : classCode,
					"WINDOW_WIDTH" : windowWidth,
					"WINDOW_HEIGHT" : windowHeight,
					"BROWSER_NAME" : browserName
			};
			return JSONdata;
		}

		function onBookmarked(){
			<c:url value="/ebook/ebooklog.json" var="ebooklogUrl" />
			var jsonData = JSON.stringify(logmake("BOOKMARK", ""));
			$.ajax({
				type: "POST",
				url: "${ebooklogUrl}",
				data: jsonData,
				dataType: "json",
				success: function(jsonData){
					alert("s");
				},
				error: function(jsonData){
					alert("f");
				}
			});
		}


	});

	Book.getMetadata().then(function(meta){
		document.title = meta.bookTitle+" – "+meta.creator;
	});
	Book.getToc().then(function(toc){
		var $select = document.getElementById("toc"),
		docfrag = document.createDocumentFragment();
		toc.forEach(function(chapter) {
		var option = document.createElement("option");
		option.textContent = chapter.label;
		option.ref = chapter.href;
		docfrag.appendChild(option);
	});
	$select.appendChild(docfrag);
	$select.onchange = function(){
		var index = $select.selectedIndex,
		url = $select.options[index].ref;
		Book.goto(url);
		return false;
	}
	});
	Book.ready.all.then(function(){
	document.getElementById("loader").style.display = "none";
	});
</script>
</head>



<body>
	<div id="main" class="main-content">
		<!-- 最上部のステータスバー -->
		<div id="status-bar" style="width:100%;">
			<div id="pageNumberText">TITLE PAGE</div>
			<!-- ブックマークイメージ描画位置 -->
				<div>
					<div id="bookmarker" title="This page is book marked.">
						<img src="${baseURL}/images/ebook/bookmarker.png" />
					</div>
				</div>
		</div>


		<!-- サイドバー -->
		<div id="main-sidebar" class="main-sidebar main-sidebar-left">
			<div class="section" style="background-color: #444;">
				<!-- サイドバー上部 -->
				<div id="jumparea">
					PAGE JUMP : <select id="toc" style="cursor:pointer; height:50px; font-size:16px;"></select><br><br>
					<input type="search" id="searchTextBox" style="height:40px;"/>
					<a id="searchBtn" class="show_view icon-search"></a>
					<a id="showBookmarkList" class="icon-bookmark"></a><br>
				</div>
			</div>
			<!-- サイドバー下部 -->
			<nav>
				<ul id="itemList"></ul>
			</nav>
		</div>

		<!-- タイトルバー -->
		<div id="titlebar">
			<!-- 左上メニュー -->
			<div id="leftmenu" class="main-navbar-content">
				<div id="toggle-sidebar" class="icon left">
					<a id="sidebar-opener" class="icon-menu" title="Sidebar">Menu</a>
				</div>
			</div>

			<!-- 中央メモエリア -->
			<div id="memoarea">
				<textarea id="memorandum" cols="5" rows="5" style="height: 80%; max-height: 300%; width:-webkit-calc(95% - 100px); max-width:-webkit-calc(95% - 100px); visibility: hidden;"
				placeholder="Please feel free to write anything here and click 'SAVE' to confirm.&#13;&#10;This area can be extended by dragging the lower right."></textarea>
				<input type="button" id="saveBtn" value="SAVE" style="visibility: hidden; width:60px;" />
			</div>


			<!-- 右上メニュー -->
			<div id="title-controls">
				<!-- EPUBJS.reader.ControlsController (reader.min.jsの中)にこの項目の動作の一部が書かれている -->
				<a id="bookmark" class="icon-bookmark-empty" title="Bookmark">Mark</a>
				<a id="highlighting" title="Highlight"> <font size="2"> <span style="background-color: yellow">abc</span></font> Check</a>
				<a id="memo" class="icon-edit" title="show/take a memo">Memo</a>
				<a id="viewmodechange" title='switch to "Text Viewer Mode"' class="icon-link">View</a>
				<font color="red"><a id="close" class="icon-cancel-circled" title="Close" >Close</a></font>
			</div>
		</div>

		<!-- 戻るボタン -->
		<div id="prev" onclick="Book.prevPage();" class="arrow"><</div>
		<!-- EPUB描画位置 -->
		<div id="wrapper">
			<div id="area"></div>
		</div>
		<!-- 進むボタン -->
		<div id="next" onclick=" Book.nextPage();" class="arrow">></div>
	</div>

	<!-- 読み込み時のローダー -->
	<div id="loader">
		<img src="${baseURL}/images/ebook/loader.gif">
	</div>

	<script>
	$(document).ready(function() {
		$('#main-sidebar').simpleSidebar({
			opener: '#toggle-sidebar',
			wrapper: '#main',
			animation: {
				easing: "easeOutQuint"
			},
			sidebar: {
				align: 'left',
				closingLinks: '.close-sb',
			},
			sbWrapper: {
				display: true
			}
		});
	});
		Book.renderTo("area").then(function() {

		});
	</script>

</body>
</html>