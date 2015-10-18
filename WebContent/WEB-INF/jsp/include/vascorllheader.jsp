<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<head>

</head>

	<ul class="nav navbar-right top-nav">
		<li class=""><a href="<c:url value = "/usermessage"/>"><i class="fa fa-envelope">&nbsp;Mail</i> </a>

			</li>
				<li class=""><a id="additem" href="<c:url value = "/item/add"/>"><i class="glyphicon glyphicon-pencil">&nbsp;Add&nbsp;ULL</i> </a>

			</li>
<!--
		<li class="dropdown"><a href="#" class="dropdown-toggle"
			data-toggle="dropdown"><i class="fa fa-bell"></i> <b
				class="caret"></b></a>
			<ul class="dropdown-menu alert-dropdown">
				<li><a href="#">Alert Name <span
						class="label label-default">Alert Badge</span></a></li>
				<li><a href="#">Alert Name <span
						class="label label-primary">Alert Badge</span></a></li>
				<li><a href="#">Alert Name <span
						class="label label-success">Alert Badge</span></a></li>
				<li><a href="#">Alert Name <span class="label label-info">Alert
							Badge</span></a></li>
				<li><a href="#">Alert Name <span
						class="label label-warning">Alert Badge</span></a></li>
				<li><a href="#">Alert Name <span class="label label-danger">Alert
							Badge</span></a></li>
				<li class="divider"></li>
				<li><a href="#">View All</a></li>
			</ul></li>-->
		<li class="dropdown"><a href="#" class="dropdown-toggle"
			data-toggle="dropdown"><i class="fa fa-user">&nbsp;User</i>  <b
				class="caret"></b></a>
			<ul class="dropdown-menu">
				<li id="setting"><a href="<c:url value = "/profile"/>"><i class="fa fa-fw fa-user"></i> Profile&Setting</a></li>
				<li><a href="<c:url value = "/usermessage"/>"><i class="fa fa-fw fa-envelope"></i>mail box</a></li>
				<!--<li><a href="<c:url value = "/analysis/myprofile"/>"><i class="fa fa-fw fa-gear"></i>Settings</a></li>-->
				<li class="divider"></li>
				<li><a href="<c:url value = "/logout"/>"><i class="fa fa-fw fa-power-off"></i> Log
						Out</a></li>
			</ul></li>
	</ul>

<div class="collapse navbar-collapse navbar-ex1-collapse">
	<ul class="nav navbar-nav side-nav">
	<li id="home"><a href="<c:url value = "/index"/>"><i
				class="glyphicon glyphicon-home"></i>&nbsp;Home</a></li>
				<li id="addull"><a id="additem2" href="<c:url value = "/item/add"/>"><i class="glyphicon glyphicon-pencil">Add ULL</i> </a>

			</li>

		<li id="mylogs"><a href="<c:url value = "/member"/>"><i
				class="glyphicon glyphicon-folder-open"></i>&nbsp;My Logs</a></li>
		<li id="eBook"><a href="<c:url value = "/ebook"/>"><i
				class="glyphicon glyphicon-book"></i>&nbsp;eBooks</a></li>
		<li id="mygoal"><a href="<c:url value = "/analysis/home"/>"><i
				class="glyphicon glyphicon-fire"></i>&nbsp;My goal</a></li>
		<li id="myjplist"><a
			href="<c:url value = "/analysis/myjplists"/>"><i
				class="fa fa-fw fa-bar-chart-o"></i>&nbsp;My JP lists</a></li>
		<li id="mygoalsetting"><a href="<c:url value = "/analysis/mysetting"/>"><i
				class="glyphicon glyphicon-wrench"></i>&nbsp;My goal Setting</a></li>
		<li id="alllog"><a href="<c:url value = "/item/"/>"><i
				class="glyphicon glyphicon-list-alt"></i>&nbsp;ALL Logs </a>
		<li id="quiz"><a href="<c:url value = "/quiz/menu"/>"><i
				class="glyphicon glyphicon-check"></i>&nbsp;Quiz</a></li>

		<li id="recommendation"><a
			href="<c:url value = "/analysis/recommendation"/>" id="vascorll"><i
				class="glyphicon glyphicon-gift"></i>&nbsp;Recommendation</a></li>

				<li id="associate"><a
			href="<c:url value = "/analysis/association"/>" id="association"><i
				class="glyphicon glyphicon-gift"></i>&nbsp;Prediction</a></li>

		<li id="setting"><a href="<c:url value = "/profile"/>"><i class="fa fa-fw fa-user"></i> Profile&Admin</a></li>
				<li><a href="<c:url value = "/logout"/>"><i class="fa fa-fw fa-power-off"></i> Log
						Out</a></li>

		<!--<li id="refelection"><a href="blank-page.html"><i
				class="fa fa-fw fa-file"></i> Reflection</a></li>-->
				<!--
		<li id="mygoalset"><a
			href="<c:url value = "/analysis/mysetting"/>"><i
				class="fa fa-fw fa-table"></i> My goal setting</a></li>
		<li id="myprofile"><a
			href="<c:url value = "/analysis/myprofile"/>"><i
				class="fa fa-fw fa-wrench"></i>My profile setting</a></li>
-->



		<!--
								<li><a href="<c:url value = "/analysis/visualization"/>"><i
							class="fa fa-fw fa-bar-chart-o"></i>Visualization</a></li>
					<li><a href="forms.html"><i class="fa fa-fw fa-edit"></i>
							Forms</a></li>
					<li><a href="bootstrap-elements.html"><i
							class="fa fa-fw fa-desktop"></i> Bootstrap Elements</a></li>
					<li><a href="bootstrap-grid.html"><i
							class="fa fa-fw fa-wrench"></i> Bootstrap Grid</a></li>
					<li><a href="javascript:;" data-toggle="collapse"
						data-target="#demo"><i class="fa fa-fw fa-arrows-v"></i>
							Dropdown <i class="fa fa-fw fa-caret-down"></i></a>
						<ul id="demo" class="collapse">
							<li><a href="#">Dropdown Item</a></li>
							<li><a href="#">Dropdown Item</a></li>
						</ul></li>
					<li><a href="blank-page.html"><i class="fa fa-fw fa-file"></i>
							Blank Page</a></li>
					<li><a href="index-rtl.html"><i
							class="fa fa-fw fa-dashboard"></i> RTL Dashboard</a></li>-->
	</ul>

</div>



<style>
div.ditem {
	padding: -10px -10px;
}

.searchResultList .ditem {
	margin: 10px 0;
}

div.partsInfo {
	padding: 5px 20px;
}

div.partsInfo div.body {
	margin: 10px 0;
}

div.parts,div.dparts {
	margin: 0 auto 10px;
	clear: both;
}

div.dparts div.parts {
	margin: 0;
}

.form .block {
	text-align: center;
	padding: 10px 1em;
}

.searchResultList .partsInfo {
	background: #EEEEEE;
}

div.pagerRelative {
	padding: 4px;
	text-align: right;
}

.searchResultList .item_block {
	background: #FFF;
	margin: 0px 1px 2px 0px;
	height: 120px;
	float: left;
	position: relative;
	top: 0;
	left: 0;
	border: 1px solid #CCC;
}

.searchResultList .item_block:hover {
	background: #FFD;
	border-color: #888;
}

.searchResultList .item_block hr {
	border: solid #000;
	border-width: 1px 0 0 0;
	margin: 2px 0;
}

.searchResultList .item_block .item_image {
	text-align: center;
	height: 70px;
	overflow: hidden;
}

.searchResultList .item_block .item_info {
	padding: 1px;
	border-top: 1px solid #CCC;
	height: 50px;
	overflow: hidden;
}

.searchResultList .item_block:hover .item_info {
	height: auto;
	border: 0;
	font-weight: bold;
	background: #FFD;
	position: absolute;
	top: 70px;
	left: 0;
	z-index: 100;
	box-shadow: 1px 1px 5px #000;
}

.searchResultList .item_block .item_hide {
	display: none;
}

.searchResultList .item_block:hover .item_hide {
	display: inline;
	font-weight: normal;
}

.item :link,.item :visited {
	color: black;
}

.item :hover {
	background: #F5F5F5;
	color: #000;
}

div.pagerRelative {
	padding: 4px;
	text-align: right;
}

div.pagerRelativeMulti {
	padding: 4px;
}

div.pagerRelative p,div.pagerRelativeMulti div.pager p {
	display: inline;
	margin-left: 10px;
}

div.pagerRelative p:first-child,div.pagerRelativeMulti div.pager p:first-child,div.pagerRelative p.first-child,div.pagerRelativeMulti div.pager p.first-child
	{
	margin-left: 0;
}

div.pagerRelativeMulti div.text {
	float: left;
}

div.pagerRelativeMulti div.pager {
	float: right;
	margin-top: 0.5em;
	text-align: right;
}

.pagerRelative {
	line-height: 20px;
	height: 20px
}

.pagerRelative a,.pagerRelative .now-page {
	padding: 1px 3px 2px 3px;
	margin: 0;
	text-align: center;
	font: normal normal normal 12px/1.6em Verdana, Helvetica, Arial,
		sans-serif;
	border: 1px solid #ccc;
	text-decoration: none
}

.pagerRelative .now-page {
	background-color: #09C;
	border-color: #09C;
	color: white;
	font-weight: 700;
}

.pagerRelative a:hover {
	border: 1px solid #c00;
	text-decoration: none
}

div.parts table {
	width: 100%;
	border-width: 0;
	border-style: solid;
	border-color: #CCCCCC;
	width: 100%;
}

div.parts th,div.parts td {
	float: left;
	border-width: 0 0px 0px 0;
	border-style: solid;
	border-color: #CCCCCC;
}

div.parts th {
	white-space: nowrap;
	font-weight: bold;
}

div.parts,div.dparts {
	margin: 0 auto 10px;
	clear: both;
}

div.dparts div.parts {
	margin: 0;
}

div.ditem {
	padding: -10px -10px;
}

div.parts table.mceToolbar {
	width: auto;
}

.searchResultList .partsInfo {
	background: #EEEEEE;
}

.searchResultList .ditem {
	margin: 8px 0;
}

.searchResultList td.photo {
	padding: 5px;
}

.searchResultList th,.searchResultList td {
	padding: 5px;
}

.searchResultList th {
	width: 90px;
}

.searchResultList tr.operation th {
	padding-top: 0;
	padding-bottom: 0;
}

.searchResultList tr.operation td {
	padding: 0;
}

.searchResultList tr.operation span.text {
	float: left;
	display: block;
	width: 180px;
	padding: 5px;
	border-right: 1px solid #CCCCCC;
}

.searchResultList tr.operation span.moreInfo {
	zoom: 1;
	display: block;
	margin-left: 121px;
	padding: 4px 0 3px;
	text-align: center;
}

.searchResultList div.operation {
	text-align: center;
}

.searchResultList tr.operation span.moreInfo img,.searchResultList div.operation form,.searchResultList div.operation fieldset
	{
	display: inline;
	vertical-align: top;
}

.searchResultList .item_block {
	background: #FFF;
	margin: 0px 1px 2px 0px;
	width: 105px;
	height: 120px;
	float: left;
	position: relative;
	top: 0;
	left: 0;
	border: 1px solid #CCC;
}

.searchResultList .item_block:hover {
	background: #FFD;
	border-color: #888;
}

.searchResultList .item_block hr {
	border: solid #000;
	border-width: 1px 0 0 0;
	margin: 2px 0;
}

.searchResultList .item_block .item_image {
	text-align: center;
	height: 70px;
	overflow: hidden;
}

.searchResultList .item_block .item_info {
	padding: 1px;
	border-top: 1px solid #CCC;
	height: 50px;
	overflow: hidden;
}

.searchResultList .item_block:hover .item_info {
	height: auto;
	border: 0;
	font-weight: bold;
	background: #FFD;
	width: 250px;
	position: absolute;
	top: 70px;
	left: 0;
	z-index: 100;
	box-shadow: 1px 1px 5px #000;
}

.searchResultList .item_block .item_hide {
	display: none;
}

.searchResultList .item_block:hover .item_hide {
	display: inline;
	font-weight: normal;
}

.memberImageBox * {
	text-align: center;
}

.memberImageBox {
	padding: 7px;
	border: 1px solid #CCCCCC;
	background: transparent url(../images/bg_parts_photo_box.gif) repeat-x 0
		0;
}

.memberImageBox p.photo {
	padding: 7px;
	border: 1px solid #CCCCCC;
	background-color: #FFFFFF;
}

.memberImageBox p.friendLink {
	margin-bottom: 3px;
}

.memberImageBox ul.moreInfo {
	margin: 2px 0 -5px;
}

.memberImageBox ul.moreInfo li {
	padding: 1px 0;
	background: none;
}

.memberImageBox ul.moreInfo li img {
	vertical-align: bottom;
}

.memberImageBox p.rank {
	margin-top: 6px;
}

.memberImageBox p.point {
	margin-top: 2px;
}

.memberImageBox p.text {
	margin-top: 4px;
}

.memberImageBox p.loginTime {
	margin-top: 0px;
}

/*==============================================================================
 * memberImages
 *----------------------------------------------------------------------------*/
.memberImagesBox table {
	border-top: 1px solid #CCCCCC;
}

#Body .memberImagesBox td {
	padding: 8px 0;
	background-color: #FFFFFF;
	text-align: center;
}

.memberImagesBox form {
	float: left;
	width: 230px;
}

.memberImagesBox form p {
	margin: 8px 0;
	text-align: center;
}

.memberImagesBox ul {
	zoom: 1;
	margin: 8px 0 8px 230px;
}

.memberImagesBox li {
	padding-left: 12px;
	background: url(./skin/default/img/marker.gif) no-repeat 3px 3px;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		var place_lat = -1;
		var place_log = -1;
		navigator.geolocation.watchPosition(successCallback, errorCallback);

		function successCallback(position) {
			place_lat = position.coords.latitude;

			place_log = position.coords.longitude;
			var ass = document.getElementById('association');
			ass.href = "<c:url value="/analysis/association"/>" + "?lat=" + place_lat
					+ "&lng=" + place_log;


			var vas = document.getElementById('vascorll');
			vas.href = "<c:url value="/analysis/recommendation"/>" + "?lat=" + place_lat
					+ "&lng=" + place_log;


			var additem = document.getElementById('additem');
			additem.href = "<c:url value="/item/add"/>" + "?lat=" + place_lat
					+ "&lng=" + place_log;

			var additem2 = document.getElementById('additem2');
			additem2.href = "<c:url value="/item/add"/>" + "?lat=" + place_lat
					+ "&lng=" + place_log;



		}
		function errorCallback(error) {
			alert("位置情報取得できない");
		}


		function myEnter(){
		     myPassWord=prompt("パスワードを入力してください","");
		     if ( myPassWord == "pass1" ){
		    	 var vas = document.getElementById('adminpage');
					vas.href = "<c:url value="/analysis/recommendation"/>" + "?lat=" + place_lat
							+ "&lng=" + place_log;
		    	 window.location.href = "../index.html";
		         location.href="http://www.red.oit-net.jp/tatsuya/java/prompt.htm";
		     }else{
		         alert( "パスワードが違います!" );
		     }
		}

	});


</script>


