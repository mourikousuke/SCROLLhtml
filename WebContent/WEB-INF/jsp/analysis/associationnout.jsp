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
<c:import url="../include/vsjscss.jsp">
</c:import>
<script type="text/javascript">
	$(document).ready(function() {
		document.getElementById("associate").className = "active";
		navigator.geolocation.watchPosition(successCallback, errorCallback);
		var place_lat = -1;
		var place_log = -1;
		function successCallback(position) {
			place_lat = position.coords.latitude;

			place_log = position.coords.longitude;
			//	var clickElem = document.getElementById('nextpage');
			//    		clickElem.href = "<c:url value="/analysis/recommendation"/>" + "?lat=" + place_lat
			//    				+ "&lng=" + place_log;

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
			<!-- Top Menu Items -->
			<!-- <ul class="nav navbar-right top-nav">
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
						<li><a href="#">Alert Name <span
								class="label label-danger">Alert Badge</span></a></li>
						<li class="divider"></li>
						<li><a href="#">View All</a></li>
					</ul></li>
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
			<c:import url="../include/vascorllheader.jsp">
			</c:import>

			<!-- /.navbar-collapse -->
		</nav>

		<div id="page-wrapper">

			<div class="container-fluid">

				<!-- Page Heading -->
				<div class="row">
					<div class="col-lg-12">
						<h1 class="page-header"></h1>

					</div>

				</div>


				<div class="row">
					<div class="col-lg-8">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">Associated Recommendation</div>


								</div>
							</div>

							<div class="panel-footer" style="width: 100%">
								<div class="table-responsive" style="width: 100%">

									<c:forEach items="${recommenditem}" var="item" begin="0"
										end="0">

										<c:choose>
											<c:when test="${not empty item.image}">
												<center>
													<img alt=""
														src="${staticserverUrl}/${projectName}/${item.image}_320x240.png"
														style="width: 200; height: 200px;" />&nbsp;
												</center>
											</c:when>
											<c:otherwise>
												<center>
													<img style="width: 200; height: 200px;" alt=""
														src="<c:url value="/images/no_image.gif" />" /> &nbsp;
												</center>
											</c:otherwise>
										</c:choose>



									</c:forEach>

									<br>
									<c:forEach items="${recommendui}" var="ui" begin="0" end="0">
										<font size="5">Learning Place is <b>${ui.place}</b> and
											learning time is <b>${ui.time}</b> ==> <a
											href="<c:url value="/item/${recommenditem[0].item}"/>"><i
												class="fa fa-arrow-circle-right"></i>${ui.content}</a> by
											${recommenditem[0].nickname}
										</font>
									</c:forEach>
									<c:forEach items="${recommenditem}" var="ui" begin="1" varStatus="status">
									<br>
										<font size="5"> ==> <a
											href="<c:url value="/item/${ui.item}"/>"><i
												class="fa fa-arrow-circle-right"></i>${ui.content}</a> by
											${ui.nickname}
										</font>
									</c:forEach>

								</div>

						

							</div>

						</div>
					</div>

				</div>

				<div class="row">
					<div class="col-lg-8">
						<div class="panel panel-danger">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">Evaluation of recommendation</div>


								</div>
							</div>

							<c:url value="/analysis/associationout?&nl=${nl}&place=${place}&associationid=${associationid}" var="itemUrl" />
							<form:form commandName="setting" action="${itemUrl}" method="post"
								enctype="multipart/form-data">
								<div
									style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-left: 10px; margin-top: 10px">
									<img src="<c:url value='/images/system-help.png' />" alt="●" />Is
									this recommendation useful for learning ?
								</div>
								<div id="answer1" style="margin-left: 150px">
									<form:radiobutton name="n1" path="n1" value="1" id="jpradio"
										style="margin-top:-5px" />
									<label>&nbsp;1</label>
									<form:radiobutton name="n1" path="n1" value="2" id="jpradio"
										style="margin-top:-5px" />
									<label>&nbsp;2</label>
									<form:radiobutton name="n1" path="n1" value="3" id="jpradio"
										style="margin-top:-5px" />
									<label>&nbsp;3</label>
									<form:radiobutton name="n1" path="n1" value="4" id="jpradio"
										style="margin-top:-5px" />
									<label>&nbsp;4</label>
									<form:radiobutton name="n1" path="n1" value="5" id="jpradio"
										style="margin-top:-5px" />
									<label>&nbsp;5</label>
								</div>
								<br>
								<div
									style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-left: 10px;">
									<img src="<c:url value='/images/system-help.png' />" alt="●" />Is
									this recommendation appropriate level ?
								</div>
								<div id="answer1" style="margin-left: 150px">
									<form:radiobutton name="n2" path="n2" value="1" id="jpradio2"
										style="margin-top:-5px" />
									<label>&nbsp;1</label>
									<form:radiobutton name="n2" path="n2" value="2" id="jpradio2"
										style="margin-top:-5px" />
									<label>&nbsp;2</label>
									<form:radiobutton name="n2" path="n2" value="3" id="jpradio2"
										style="margin-top:-5px" />
									<label>&nbsp;3</label>
									<form:radiobutton name="n2" path="n2" value="4" id="jpradio2"
										style="margin-top:-5px" />
									<label>&nbsp;4</label>
									<form:radiobutton name="n2" path="n2" value="5" id="jpradio2"
										style="margin-top:-5px" />
									<label>&nbsp;5</label>
								</div>
								<br>
								<div
									style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-left: 10px;">
									<img src="<c:url value='/images/system-help.png' />" alt="●" />Are
									you feel that this log is interesting or impressing?
								</div>
								<div id="answer1" style="margin-left: 150px">
									<form:radiobutton name="n3" path="n3" value="1" id="jpradio3"
										style="margin-top:-5px" />
									<label>&nbsp;1</label>
									<form:radiobutton name="n3" path="n3" value="2" id="jpradio3"
										style="margin-top:-5px" />
									<label>&nbsp;2</label>
									<form:radiobutton name="n3" path="n3" value="3" id="jpradio3"
										style="margin-top:-5px" />
									<label>&nbsp;3</label>
									<form:radiobutton name="n3" path="n3" value="4" id="jpradio3"
										style="margin-top:-5px" />
									<label>&nbsp;4</label>
									<form:radiobutton name="n3" path="n3" value="5" id="jpradio3"
										style="margin-top:-5px" />
									<label>&nbsp;5</label>
								</div>

								<br>
								<center>
									<div id="quizselect">
										<br /> <input type="button" class="btn btn-primary"
											value="Return" onClick="onClick="history.go(-1);" /> <input
											type="submit" class="btn btn-success"
											value="Next Recommendation" />
								</center>
								<br>
						</div>
						<br> <br>

						</form:form>
					</div>
				</div>
			</div>

		</div>





	</div>
	<!-- /.container-fluid -->

	</div>
	<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->


</body>

</html>
