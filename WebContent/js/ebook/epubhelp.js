//get year/month/day/hours/minutes/seconds
function getTime(){
	var DD = new Date();
	var Year = 1900 + DD.getYear();
	var Month = DD.getMonth() + 1;
	var Day = DD.getDate();
	var Hours = DD.getHours();
	var Minutes = DD.getMinutes();
	var Seconds = DD.getSeconds();
	alert(Month+"/"+Day+"("+Year+")---"+Hours+"H"+Minutes+"M"+Seconds+"S");
}

//Hightlight strings in iframe. To use this method, you need to name iframe "ePubViewerFrame" (in js/epub.min.js)
function HighlightString() {
	try{
		var chapter, page;
		chapter=Book.getChapter();
		page=Book.getPage();
		var iframe = document.getElementsByName("ePubViewerFrame");
		var id = iframe[0].id;
		iframe = document.getElementById(id);
		var idoc = iframe.contentDocument || iframe.contentWindow.document;
		var SelectedText = idoc.getSelection().toString();

		try{ //make array
			HighlightedStrings[chapter+"-"+page][0];
		}catch(e){
			HighlightedStrings[chapter+"-"+page] = new Array();
		}


		var userSelection = idoc.getSelection().getRangeAt(0);
		//from dangerous range to safe range(dangerous: include HTML tags, safe: smaller range that doesn't include HTML tags)
		var safeRanges = getSafeRanges(userSelection);

		for(var i = 0; i < safeRanges.length; i++){
			if(safeRanges[i].toString()){
				//alert(safeRanges[i].toString());
				HighlightedStrings[chapter+"-"+page].push(safeRanges[i].toString());
			}
			highlightRange(safeRanges[i]);
		}

		//highlight same strings in the page
		$('iframe').contents().find("body").highlight(SelectedText);

		//alert("You highlighted : "+ SelectedText);
		//alert("chapterNumber = "+Book.getChapter()+",Page Number ="+Book.getPage());

	}catch(e){
		alert("error : No text is selected or the range is too large.");
	}
}

function BookmarkPage(){
	var chapter, page;
	chapter=Book.getChapter();
	page=Book.getPage();

	if(BookmarkedPages[chapter+'-'+page] == true){ // Bookmarkが外された
		BookmarkedPages[chapter+'-'+page]=false;
		$('#main').css({
			"background":"#eee"
		});
	}else{ //Bookmarkされた
		BookmarkedPages[chapter+'-'+page] = true;
		$('#main').css({
			"background":"#edc"
		});
	}

	if(BookmarkedPages[chapter+"-"+page] == true)
		document.getElementById("bookmarker").style.visibility="visible";
	else
		document.getElementById("bookmarker").style.visibility="hidden";
}

//this function is called when page is changed
function pageChangedFunc(){
	scrollReset(); //スクロール位置リセット
	var chapter, page;
	chapter=Book.getChapter();
	page=Book.getPage()
	var iframe = document.getElementsByName("ePubViewerFrame");
	var id = iframe[0].id;
	iframe = document.getElementById(id);
	var idoc = iframe.contentDocument || iframe.contentWindow.document;


	//bookmark
	if(BookmarkedPages[chapter+"-"+page] == undefined)
		BookmarkedPages[chapter+"-"+page]=false;

	if(BookmarkedPages[chapter+"-"+page] == true){ //bookmarked
		document.getElementById("bookmarker").style.visibility="visible";
		$('#main').css({
			"background":"#edc"
		});
	}else{
		document.getElementById("bookmarker").style.visibility="hidden";
		$('#main').css({
			"background":"#eee"
		});
	}


	// highlight
	for(i=0; 1; i++){
		try{
			var str = HighlightedStrings[chapter+"-"+page][i];
			if (str == undefined) break;
		}
		catch(e){break;}
		$('iframe').contents().find("body").highlight(str);
	}


	//memo
	if(memorandum[chapter+"-"+page] != undefined)
		document.getElementById("memorandum").value=memorandum[chapter+"-"+page];
	else
		document.getElementById("memorandum").value="";


	//page number
	setPageNumber();
}

function setPageNumber(){
	var sel = Book.getChapter();
	var toc = getTOCList();
	var total = toc.length - 1;
	if(sel!=0)
		$("#pageNumberText").text("Chapter : "+sel+" / "+total);
	else
		$("#pageNumberText").text("TITLE PAGE");
}

//ウィンドウの大きさが変更された時
function windowSizeChanged(){
	windowWidth = window.innerWidth;
	windowHeight = window.innerHeight;
}

function viewmodeChangeFunc(){
	scrollReset(); //スクロール位置リセット
	if(viewmode == 0){ //スライドビューの場合テキストビューに変更
		$('#wrapper').css({
			"max-height":"1100px",
			"overflow-y":"scroll"
		});
		document.getElementById("viewmodechange").title='switch to "Slide Viewer Mode"';
		viewmode = 1;
	}else{
		//テキストビューの場合やビューモード値が得られない場合はスライドビューに変更
		$('#wrapper').css({
			"max-height":"600px",
			"overflow-y":"hidden"
		});
		document.getElementById("viewmodechange").title='switch to "Text Viewer Mode"';
		viewmode = 0;
	}
}


//to make safe range( that smaller ranges and they dosen't include any HTML tags in it)
function getSafeRanges(dangerous) {
	var a = dangerous.commonAncestorContainer;
	// Starts -- Work inward from the start, selecting the largest safe range
	var s = new Array(0), rs = new Array(0);
	if (dangerous.startContainer != a)
		for(var i = dangerous.startContainer; i != a; i = i.parentNode)
			s.push(i)
			;
	if (0 < s.length) for(var i = 0; i < s.length; i++) {
		var xs = document.createRange();
		if (i) {
			xs.setStartAfter(s[i-1]);
			xs.setEndAfter(s[i].lastChild);
		}
		else {
			xs.setStart(s[i], dangerous.startOffset);
			xs.setEndAfter(
					(s[i].nodeType == Node.TEXT_NODE)
					? s[i] : s[i].lastChild
			);
		}
		rs.push(xs);
	}

	// Ends -- basically the same code reversed
	var e = new Array(0), re = new Array(0);
	if (dangerous.endContainer != a)
		for(var i = dangerous.endContainer; i != a; i = i.parentNode)
			e.push(i)
			;
	if (0 < e.length) for(var i = 0; i < e.length; i++) {
		var xe = document.createRange();
		if (i) {
			xe.setStartBefore(e[i].firstChild);
			xe.setEndBefore(e[i-1]);
		}
		else {
			xe.setStartBefore(
					(e[i].nodeType == Node.TEXT_NODE)
					? e[i] : e[i].firstChild
			);
			xe.setEnd(e[i], dangerous.endOffset);
		}
		re.unshift(xe);
	}

	// Middle -- the uncaptured middle
	if ((0 < s.length) && (0 < e.length)) {
		var xm = document.createRange();
		xm.setStartAfter(s[s.length - 1]);
		xm.setEndBefore(e[e.length - 1]);
	}
	else {
		return [dangerous];
	}

	// Concat
	rs.push(xm);
	response = rs.concat(re);

	// Send to Console
	return response;
}

//to highlight
function highlightRange(range) {
	var newNode = document.createElement("span");
	newNode.setAttribute("class","highlight;");
	range.surroundContents(newNode);
}

function object2json(object){
	try{
		var jsonstring=JSON.stringify(object);
		alert(jsonstring);
		return jsonstring;
	}catch(e){
		// エラーを出力
		alert(e);
	}
}

function memoFunc(){
	var chapter, page;
	chapter=Book.getChapter();
	page=Book.getPage();
	if(document.getElementById("memorandum").style.visibility=="visible"){
		document.getElementById("memo").title="show/take a memo";
		document.getElementById("memorandum").style.visibility="hidden";
		document.getElementById("saveBtn").style.visibility="hidden";
		if(memorandum[chapter+"-"+page] != undefined)
			document.getElementById("memorandum").value=memorandum[chapter+"-"+page];
		else
			document.getElementById("memorandum").value="";
	}else{
		document.getElementById("memo").title="hide memo";
		document.getElementById("memorandum").style.visibility="visible"
			//document.getElementById("saveBtn").style.visibility="visible";
	}
};

function saveMemo(){
	var chapter, page;
	chapter=Book.getChapter();
	page=Book.getPage();

	memorandum[chapter+"-"+page]=document.getElementById("memorandum").value;
	//document.getElementById("memoarea").style.visibility="hidden";
	document.getElementById("saveBtn").style.visibility="hidden";


}

function memoChanged(elm){
	var v, old = elm.value;
	return function(){
		if(old != (v=elm.value)){
			//メモが変化した際の処理
			old = v;
			$('#memorandum').attr("placeholder", "");
			document.getElementById("saveBtn").style.visibility="visible";
		}
	}
}

function showBookmarkListFunc(){
	$('#itemList').empty();
	$('#itemList').append("---------------------------------<br>");
	$('#itemList').append(" Bookmarks<br>");
	$('#itemList').append("---------------------------------<br>");
	var chapter;
	var page;
	var sp;
	var memo;
	var tocfilelist = getTOCList();
	for(key in BookmarkedPages){
		sp=key.split("-");
		chapter=sp[0];
		page=sp[1];
		if(page==1 && BookmarkedPages[key]==true){ //pageが1以外なら同じ章でジャンプ先自体は同じになるので処理しない
			memo=memorandum[key];
			if(memo!=undefined)
				$('#itemList').append("<li><a href=\"javascript:Book.gotoHref('"+tocfilelist[chapter]+"','h');\">・CHAPTER : "+ chapter +",　MEMO : "+memorandum[key]+"</a></li>");
			else
				$('#itemList').append("<li><a href=\"javascript:Book.gotoHref('"+tocfilelist[chapter]+"','h');\">・CHAPTER : "+ chapter +"</a></li>");
		}
	}
}

//検索機能(ファイルパスを受けて、その中から検索)
function searchFunc(){
	var target = document.getElementById("searchTextBox").value;
	$('#itemList').empty();
	if(target!=""){
		var foundList = $('iframe').contents().find("span:contains('"+target+"')");
		var foundTarget = new Array();

		if(foundList.length != 0){
			for(i = 0; i < foundList.length; i++){
				foundTarget[i] = foundList[i].innerHTML;
			}
		}else{
			foundList = $('iframe').contents().find("p:contains('"+target+"')");
			for(i = 0; i < foundList.length; i++){
				foundTarget[i] = foundList[i].innerHTML;
			}
		}
		//目次取得
		var tocfilelist = getTOCList();
		//目次に載っていた全ページのコンテンツから対応する文字を取得
		var resultList = new Array();
		var path = ePubFilePath + mediaFilesName + "/";
		var items = 0;
		for(i = 0; i < tocfilelist.length; i++){
			var url = path + tocfilelist[i]
			var loaded = getTextData(url);
			loaded = loaded.replace(/<("[^"]*"|'[^']*'|[^'">])*>/g, '<delimiter>');
			var list = loaded.split('<delimiter>',-1);
			var j;
			resultList[i] = new Array();
			var counter = 0;
			for(j = 0; j < list.length; j++){
				if(list[j].indexOf(target) != -1){
					resultList[i][counter]=list[j];
					counter++;
					items++;
				}
			}
		}
		//リストに表示
		var display = document.getElementById('itemList');
		$('#itemList').append("---------------------------------");
		$('#itemList').append("<Li>Single click for open the page.</Li>");
		$('#itemList').append("<Li>Double click for highlight the keyword.</LI>");
		$('#itemList').append("---Found "+ items +" items.----------------");
		for(i = 0; i < resultList.length; i++){
			for(j = 0; j < resultList[i].length; j++){
				var k = i+1;
				var linkFile = tocfilelist[i];
				$('#itemList').append("<li><a href=\"javascript:searchResultClicked('"+linkFile+"','"+target+"');\">・PAGE : "+ k +" ' "+resultList[i][j]+" '</a></li>");
			}
		}
	}else{
		//検索キーワードがない時
		$('#itemList').append("Please input any keyword.");
	}

}

//検索結果がクリックされた際の処理
function searchResultClicked(fname, keyword){
	Book.gotoHref(fname);
	$('iframe').contents().find("body").highlight(keyword);
}

//ePubファイルの場所filepathを受け、その中のメディアファイルが置かれているフォルダ名(現在はOEBPSやOPSが多いが任意に設定可能なので一応)を探す
function mediaLocationCheck(filepath){
	var container = getTextData(filepath + "META-INF/container.xml");
	var path = container.split("full-path");
	path = path[1].split("/");
	path = path[0].split("\"");
	return path[1];
}

//サーバ内ファイルを取得する(非同期の方法もあるが簡単にこの方法を使っている)
function getTextData(fname){
	var text = file_get_contents(fname);
	return text;
}


//TOCリストをファイル名で取得して返す
function getTOCList() {
	var list = new Array();
	for(i=0;i<Book.toc.length;i++){
		list[i]=Book.toc[i].href;
	}
	return list;
}

function file_get_contents(url, flags, context, offset, maxLen) {
	  //  discuss at: http://phpjs.org/functions/file_get_contents/
	  // original by: Legaev Andrey
	  //    input by: Jani Hartikainen
	  //    input by: Raphael (Ao) RUDLER
	  // improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	  // improved by: Brett Zamir (http://brett-zamir.me)
	  // bugfixed by: Brett Zamir (http://brett-zamir.me)
	  //        note: This function uses XmlHttpRequest and cannot retrieve resource from different domain without modifications.
	  //        note: Synchronous by default (as in PHP) so may lock up browser. Can
	  //        note: get async by setting a custom "phpjs.async" property to true and "notification" for an
	  //        note: optional callback (both as context params, with responseText, and other JS-specific
	  //        note: request properties available via 'this'). Note that file_get_contents() will not return the text
	  //        note: in such a case (use this.responseText within the callback). Or, consider using
	  //        note: jQuery's: $('#divId').load('http://url') instead.
	  //        note: The context argument is only implemented for http, and only partially (see below for
	  //        note: "Presently unimplemented HTTP context options"); also the arguments passed to
	  //        note: notification are incomplete
	  //        test: skip
	  //   example 1: var buf file_get_contents('http://google.com');
	  //   example 1: buf.indexOf('Google') !== -1
	  //   returns 1: true

	  var tmp, headers = [],
	    newTmp = [],
	    k = 0,
	    i = 0,
	    href = '',
	    pathPos = -1,
	    flagNames = 0,
	    content = null,
	    http_stream = false;
	  var func = function(value) {
	    return value.substring(1) !== '';
	  };

	  // BEGIN REDUNDANT
	  this.php_js = this.php_js || {};
	  this.php_js.ini = this.php_js.ini || {};
	  // END REDUNDANT
	  var ini = this.php_js.ini;
	  context = context || this.php_js.default_streams_context || null;

	  if (!flags) {
	    flags = 0;
	  }
	  var OPTS = {
	    FILE_USE_INCLUDE_PATH: 1,
	    FILE_TEXT: 32,
	    FILE_BINARY: 64
	  };
	  if (typeof flags === 'number') { // Allow for a single string or an array of string flags
	    flagNames = flags;
	  } else {
	    flags = [].concat(flags);
	    for (i = 0; i < flags.length; i++) {
	      if (OPTS[flags[i]]) {
	        flagNames = flagNames | OPTS[flags[i]];
	      }
	    }
	  }

	  if (flagNames & OPTS.FILE_BINARY && (flagNames & OPTS.FILE_TEXT)) { // These flags shouldn't be together
	    throw 'You cannot pass both FILE_BINARY and FILE_TEXT to file_get_contents()';
	  }

	  if ((flagNames & OPTS.FILE_USE_INCLUDE_PATH) && ini.include_path && ini.include_path.local_value) {
	    var slash = ini.include_path.local_value.indexOf('/') !== -1 ? '/' : '\\';
	    url = ini.include_path.local_value + slash + url;
	  } else if (!/^(https?|file):/.test(url)) { // Allow references within or below the same directory (should fix to allow other relative references or root reference; could make dependent on parse_url())
	    href = this.window.location.href;
	    pathPos = url.indexOf('/') === 0 ? href.indexOf('/', 8) - 1 : href.lastIndexOf('/');
	    url = href.slice(0, pathPos + 1) + url;
	  }

	  var http_options;
	  if (context) {
	    http_options = context.stream_options && context.stream_options.http;
	    http_stream = !! http_options;
	  }

	  if (!context || http_stream) {
	    var req = this.window.ActiveXObject ? new ActiveXObject('Microsoft.XMLHTTP') : new XMLHttpRequest();
	    if (!req) {
	      throw new Error('XMLHttpRequest not supported');
	    }

	    var method = http_stream ? http_options.method : 'GET';
	    var async = !! (context && context.stream_params && context.stream_params['phpjs.async']);

	    if (ini['phpjs.ajaxBypassCache'] && ini['phpjs.ajaxBypassCache'].local_value) {
	      url += (url.match(/\?/) == null ? '?' : '&') + (new Date())
	        .getTime(); // Give optional means of forcing bypass of cache
	    }

	    req.open(method, url, async);
	    if (async) {
	      var notification = context.stream_params.notification;
	      if (typeof notification === 'function') {
	        // Fix: make work with req.addEventListener if available: https://developer.mozilla.org/En/Using_XMLHttpRequest
	        if (0 && req.addEventListener) { // Unimplemented so don't allow to get here
	          /*
	          req.addEventListener('progress', updateProgress, false);
	          req.addEventListener('load', transferComplete, false);
	          req.addEventListener('error', transferFailed, false);
	          req.addEventListener('abort', transferCanceled, false);
	          */
	        } else {
	          req.onreadystatechange = function(aEvt) { // aEvt has stopPropagation(), preventDefault(); see https://developer.mozilla.org/en/NsIDOMEvent
	            // Other XMLHttpRequest properties: multipart, responseXML, status, statusText, upload, withCredentials
	            /*
	  PHP Constants:
	  STREAM_NOTIFY_RESOLVE   1       A remote address required for this stream has been resolved, or the resolution failed. See severity  for an indication of which happened.
	  STREAM_NOTIFY_CONNECT   2     A connection with an external resource has been established.
	  STREAM_NOTIFY_AUTH_REQUIRED 3     Additional authorization is required to access the specified resource. Typical issued with severity level of STREAM_NOTIFY_SEVERITY_ERR.
	  STREAM_NOTIFY_MIME_TYPE_IS  4     The mime-type of resource has been identified, refer to message for a description of the discovered type.
	  STREAM_NOTIFY_FILE_SIZE_IS  5     The size of the resource has been discovered.
	  STREAM_NOTIFY_REDIRECTED    6     The external resource has redirected the stream to an alternate location. Refer to message .
	  STREAM_NOTIFY_PROGRESS  7     Indicates current progress of the stream transfer in bytes_transferred and possibly bytes_max as well.
	  STREAM_NOTIFY_COMPLETED 8     There is no more data available on the stream.
	  STREAM_NOTIFY_FAILURE   9     A generic error occurred on the stream, consult message and message_code for details.
	  STREAM_NOTIFY_AUTH_RESULT   10     Authorization has been completed (with or without success).

	  STREAM_NOTIFY_SEVERITY_INFO 0     Normal, non-error related, notification.
	  STREAM_NOTIFY_SEVERITY_WARN 1     Non critical error condition. Processing may continue.
	  STREAM_NOTIFY_SEVERITY_ERR  2     A critical error occurred. Processing cannot continue.
	  */
	            var objContext = {
	              responseText: req.responseText,
	              responseXML: req.responseXML,
	              status: req.status,
	              statusText: req.statusText,
	              readyState: req.readyState,
	              evt: aEvt
	            }; // properties are not available in PHP, but offered on notification via 'this' for convenience
	            // notification args: notification_code, severity, message, message_code, bytes_transferred, bytes_max (all int's except string 'message')
	            // Need to add message, etc.
	            var bytes_transferred;
	            switch (req.readyState) {
	              case 0:
	                //     UNINITIALIZED     open() has not been called yet.
	                notification.call(objContext, 0, 0, '', 0, 0, 0);
	                break;
	              case 1:
	                //     LOADING     send() has not been called yet.
	                notification.call(objContext, 0, 0, '', 0, 0, 0);
	                break;
	              case 2:
	                //     LOADED     send() has been called, and headers and status are available.
	                notification.call(objContext, 0, 0, '', 0, 0, 0);
	                break;
	              case 3:
	                //     INTERACTIVE     Downloading; responseText holds partial data.
	                bytes_transferred = req.responseText.length * 2; // One character is two bytes
	                notification.call(objContext, 7, 0, '', 0, bytes_transferred, 0);
	                break;
	              case 4:
	                //     COMPLETED     The operation is complete.
	                if (req.status >= 200 && req.status < 400) {
	                  bytes_transferred = req.responseText.length * 2; // One character is two bytes
	                  notification.call(objContext, 8, 0, '', req.status, bytes_transferred, 0);
	                } else if (req.status === 403) { // Fix: These two are finished except for message
	                  notification.call(objContext, 10, 2, '', req.status, 0, 0);
	                } else { // Errors
	                  notification.call(objContext, 9, 2, '', req.status, 0, 0);
	                }
	                break;
	              default:
	                throw 'Unrecognized ready state for file_get_contents()';
	            }
	          };
	        }
	      }
	    }

	    if (http_stream) {
	      var sendHeaders = http_options.header && http_options.header.split(/\r?\n/);
	      var userAgentSent = false;
	      for (i = 0; i < sendHeaders.length; i++) {
	        var sendHeader = sendHeaders[i];
	        var breakPos = sendHeader.search(/:\s*/);
	        var sendHeaderName = sendHeader.substring(0, breakPos);
	        req.setRequestHeader(sendHeaderName, sendHeader.substring(breakPos + 1));
	        if (sendHeaderName === 'User-Agent') {
	          userAgentSent = true;
	        }
	      }
	      if (!userAgentSent) {
	        var user_agent = http_options.user_agent || (ini.user_agent && ini.user_agent.local_value);
	        if (user_agent) {
	          req.setRequestHeader('User-Agent', user_agent);
	        }
	      }
	      content = http_options.content || null;
	      /*
	      // Presently unimplemented HTTP context options
	      var request_fulluri = http_options.request_fulluri || false; // When set to TRUE, the entire URI will be used when constructing the request. (i.e. GET http://www.example.com/path/to/file.html HTTP/1.0). While this is a non-standard request format, some proxy servers require it.
	      var max_redirects = http_options.max_redirects || 20; // The max number of redirects to follow. Value 1 or less means that no redirects are followed.
	      var protocol_version = http_options.protocol_version || 1.0; // HTTP protocol version
	      var timeout = http_options.timeout || (ini.default_socket_timeout && ini.default_socket_timeout.local_value); // Read timeout in seconds, specified by a float
	      var ignore_errors = http_options.ignore_errors || false; // Fetch the content even on failure status codes.
	      */
	    }

	    if (flagNames & OPTS.FILE_TEXT) { // Overrides how encoding is treated (regardless of what is returned from the server)
	      var content_type = 'text/html';
	      if (http_options && http_options['phpjs.override']) { // Fix: Could allow for non-HTTP as well
	        content_type = http_options['phpjs.override']; // We use this, e.g., in gettext-related functions if character set
	        //   overridden earlier by bind_textdomain_codeset()
	      } else {
	        var encoding = (ini['unicode.stream_encoding'] && ini['unicode.stream_encoding'].local_value) ||
	          'UTF-8';
	        if (http_options && http_options.header && (/^content-type:/im)
	          .test(http_options.header)) { // We'll assume a content-type expects its own specified encoding if present
	          content_type = http_options.header.match(/^content-type:\s*(.*)$/im)[1]; // We let any header encoding stand
	        }
	        if (!(/;\s*charset=/)
	          .test(content_type)) { // If no encoding
	          content_type += '; charset=' + encoding;
	        }
	      }
	      req.overrideMimeType(content_type);
	    }
	    // Default is FILE_BINARY, but for binary, we apparently deviate from PHP in requiring the flag, since many if not
	    //     most people will also want a way to have it be auto-converted into native JavaScript text instead
	    else if (flagNames & OPTS.FILE_BINARY) { // Trick at https://developer.mozilla.org/En/Using_XMLHttpRequest to get binary
	      req.overrideMimeType('text/plain; charset=x-user-defined');
	      // Getting an individual byte then requires:
	      // responseText.charCodeAt(x) & 0xFF; // throw away high-order byte (f7) where x is 0 to responseText.length-1 (see notes in our substr())
	    }

	    try {
	      if (http_options && http_options['phpjs.sendAsBinary']) { // For content sent in a POST or PUT request (use with file_put_contents()?)
	        req.sendAsBinary(content); // In Firefox, only available FF3+
	      } else {
	        req.send(content);
	      }
	    } catch (e) {
	      // catches exception reported in issue #66
	      return false;
	    }

	    tmp = req.getAllResponseHeaders();
	    if (tmp) {
	      tmp = tmp.split('\n');
	      for (k = 0; k < tmp.length; k++) {
	        if (func(tmp[k])) {
	          newTmp.push(tmp[k]);
	        }
	      }
	      tmp = newTmp;
	      for (i = 0; i < tmp.length; i++) {
	        headers[i] = tmp[i];
	      }
	      this.$http_response_header = headers; // see http://php.net/manual/en/reserved.variables.httpresponseheader.php
	    }

	    if (offset || maxLen) {
	      if (maxLen) {
	        return req.responseText.substr(offset || 0, maxLen);
	      }
	      return req.responseText.substr(offset);
	    }
	    return req.responseText;
	  }
	  return false;
	}
//スクロールを最上部までリセット
function scrollReset(){
	$("#wrapper").scrollTop(0);
}

function ajaxPostFunc(param1, param2){
    $.post("post.php", {input1:param1, input2:param2}, function(json){alert("パラメータを2つPOSTしました");});
}

