<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Jan 2000 00:00:00 GMT">

<title>VASCORLL</title>


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Jan 2000 00:00:00 GMT">

<title>VASCORLL</title>

<!-- Bootstrap Core CSS -->
<link href="${baseURL}/css/vascorll/top/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="${baseURL}/css/vascorll/top/css/sb-admin.css"
	rel="stylesheet">

<!-- Morris Charts CSS -->
<link href="${baseURL}/css/vascorll/top/css/plugins/morris.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="${baseURL}/css/vascorll/top/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->



<!-- jQuery -->
<script src="${baseURL}/css/vascorll/top/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="${baseURL}/css/vascorll/top/js/bootstrap.min.js"></script>

<!-- Morris Charts JavaScript -->
<script
	src="${baseURL}/css/vascorll/top/js/plugins/morris/raphael.min.js"></script>
<script
	src="${baseURL}/css/vascorll/top/js/plugins/morris/morris.min.js"></script>
<script
	src="${baseURL}/css/vascorll/top/js/plugins/morris/morris-data.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="${baseURL}/js/highchart/spider/highcharts.js"></script>
<script src="${baseURL}/js/highchart/spider/highcharts-more.js"></script>
<script src="${baseURL}/js/highchart/spider/modules/exporting.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var place_lat = -1;
		var place_log = -1;
		navigator.geolocation.watchPosition(successCallback, errorCallback);

		function successCallback(position) {
			place_lat = position.coords.latitude;

			place_log = position.coords.longitude;
			var clickElem = document.getElementById('nextpage');
			clickElem.href = "<c:url value="/analysis/recommendation"/>" + "?lat=" + place_lat
					+ "&lng=" + place_log;

		}
		function errorCallback(error) {
			alert("位置情報取得できない");
		}

	});
</script>
</head>





<body>

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-ex1-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.html">VASCORLL</a>
			</div>
			<!-- Top Menu Items --><!--  
			<ul class="nav navbar-right top-nav">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="fa fa-envelope"></i> <b
						class="caret"></b></a>
					<ul class="dropdown-menu message-dropdown">

						<li class="message-preview"><a href="#">
								<div class="media">
									<span class="pull-left"> <img class="media-object"
										src="http://placehold.it/50x50" alt="">
									</span>
									<div class="media-body">
										<h5 class="media-heading">
											<strong>John Smith</strong>
										</h5>
										<p class="small text-muted">
											<i class="fa fa-clock-o"></i> Yesterday at 4:32 PM
										</p>
										<p>Lorem ipsum dolor sit amet, consectetur...</p>
									</div>
								</div>
						</a></li>
						<li class="message-preview"><a href="#">
								<div class="media">
									<span class="pull-left"> <img class="media-object"
										src="http://placehold.it/50x50" alt="">
									</span>
									<div class="media-body">
										<h5 class="media-heading">
											<strong>John Smith</strong>
										</h5>
										<p class="small text-muted">
											<i class="fa fa-clock-o"></i> Yesterday at 4:32 PM
										</p>
										<p>Lorem ipsum dolor sit amet, consectetur...</p>
									</div>
								</div>
						</a></li>
						<li class="message-preview"><a href="#">
								<div class="media">
									<span class="pull-left"> <img class="media-object"
										src="http://placehold.it/50x50" alt="">
									</span>
									<div class="media-body">
										<h5 class="media-heading">
											<strong>John Smith</strong>
										</h5>
										<p class="small text-muted">
											<i class="fa fa-clock-o"></i> Yesterday at 4:32 PM
										</p>
										<p>Lorem ipsum dolor sit amet, consectetur...</p>
									</div>
								</div>
						</a></li>
						<li class="message-footer"><a href="#">Read All New
								Messages</a></li>
					</ul></li>
				<!--  
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                    <ul class="dropdown-menu alert-dropdown">
                        <li>
                            <a href="#">Alert Name <span class="label label-default">Alert Badge</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-primary">Alert Badge</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-success">Alert Badge</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-info">Alert Badge</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-warning">Alert Badge</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-danger">Alert Badge</span></a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">View All</a>
                        </li>
                    </ul>
                </li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="fa fa-user"></i> John Smith <b
						class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>
						</li>
						<li><a href="#"><i class="fa fa-fw fa-envelope"></i>
								Inbox</a></li>
						<li><a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
						</li>
						<li class="divider"></li>
						<li><a href="#"><i class="fa fa-fw fa-power-off"></i> Log
								Out</a></li>
					</ul></li>
			</ul>
			<!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav side-nav">
						<li ><a href="<c:url value = "/analysis/home"/>"><i
							class="fa fa-fw fa-dashboard"></i>My goal</a></li>
					<li><a href="<c:url value = "/analysis/myjplists"/>"><i
							class="fa fa-fw fa-bar-chart-o"></i>My JP lists</a></li>
							<li><a href="<c:url value = "/analysis/recommendation"/>" id="nextpage"><i
							class="fa fa-fw fa-desktop"></i>Recommendation</a></li>
							<li><a href="blank-page.html"><i class="fa fa-fw fa-file"></i>
							Reflection</a></li>
					<li ><a href="<c:url value = "/analysis/mysetting"/>"><i
							class="fa fa-fw fa-table"></i> My goal setting</a></li>
					<li class="active"><a href="<c:url value = "/analysis/myprofile"/>"><i
							class="fa fa-fw fa-wrench"></i>My profile setting</a></li>
					
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</nav>

		<div id="page-wrapper">

			<div class="container-fluid">

				<!-- Page Heading -->
				<div class="row" >
					<div class="col-lg-12">
						<h1 class="page-header">
							My profile Setting <small>Please decide your profile</small>
						</h1>

					</div>
				</div>


				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
									 <a class="addlink"
										href="<c:url value="/profile"/>" ><FONT
										color="red">Your profile setting</FONT></a>
								</h3>
							</div>
							<div class="panel-body">
								<c:url value="/analysis/myprofile" var="profileEditFormUrl" />
							<form:form modelAttribute="setting" action="${profileEditFormUrl}"
								method="post">
								
								<div class="bs-callout bs-callout-primary">
									<h4>PC E-mail</h4>
									<ul>
										<li>${user.pcEmail}</li>
									</ul>
								
									<h4>Nickname</h4>
									<ul>
										<li>${user.nickname}
										</li>
									</ul>
									
									<h4>First name</h4>
									<ul>
										<li>${user.firstName}</li>
									</ul>
									
									<h4>Last name</h4>
									<ul>
										<li>${user.lastName}</li>
									</ul>
					
									<h4>Native Language</h4>
									<ul>
										<li>${ability.nationality}</li>
									</ul>
									<h4>Gender</h4>
									<ul>
										<li>${ability.gender}</li>
									</ul>
									<h4>Age</h4>
									<ul>
										<li>${ability.age}</li>
									</ul>
									<h4>Stay</h4>
									<ul>
										<li>${ability.stay}</li>
									</ul>
									<h4>Japanese Level</h4>
									<ul>
										<li>${ability.j_level}</li>
									</ul>
								
									
								</div>
								

							</form:form>
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
							
								
								
							</div>
						</div>
					</div>
				</div>
				<!-- /.row -->


				<!-- /.row -->

			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- /#page-wrapper -->

	</div>

	
</body>

</html>
