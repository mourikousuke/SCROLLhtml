<%@page contentType="text/html" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!doctype html>
<html>
<c:import url="../include/vsjscss.jsp">
</c:import>
<c:import url="../include/head.jsp">
	<c:param name="title" value="My Logs" />
	<c:param name="javascript">
		<script type="text/javascript">
			$(function() {
				$("#jumpTimemap").click(function() {
					window.open("${baseURL}/timemap/mylogs");
				});
				$("#jumpLogstate").click(function() {
					window.open("${baseURL}/logstate");
				});

			});
		</script>
	</c:param>
</c:import>

<script src="${baseURL}/js/highchart/spider/highcharts.js"></script>
<script src="${baseURL}/js/highchart/spider/highcharts-more.js"></script>
<script src="${baseURL}/js/highchart/spider/modules/exporting.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("mylogs").className = "active";
		//document.getElementById("mygoal").style.display = "none";
	});



</script>

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
		<c:import url="../include/vascorllheader.jsp">
		</c:import>

		<!-- /.navbar-collapse -->
	</nav>

	<div id="page-wrapper">

		<div class="container-fluid">

			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">My Logs</h1>

				</div>
			</div>



			<div class="row">

				<div class="col-lg-3">
					<div class="panel panel-primary">
						<div class="panel-heading">
							Profile <a class="addlink" href="<c:url value="/item/add"/>"
								id="mypage"><FONT color="red"><i
									class="glyphicon glyphicon-pencil" style="margin-left: 10px"></i>Add
									new object</FONT></a>
						</div>
						<div class="panel-body">
							<div id="memberImageBox_22" class="parts memberImageBox">
								<p class="photo">
									<c:choose>
										<c:when test="${empty user.avatar}">
											<img alt="LearningUser"
												src="<c:url value="/images/no_image.gif" />" height="180" />
										</c:when>
										<c:otherwise>
											<img alt="LearningUser"
												src="<c:url value="${staticserverUrl}/${projectName}/${user.avatar.id}_320x240.png" />"
												style="width: 100%" />
										</c:otherwise>
									</c:choose>
								</p>
								<p class="text">
									<shiro:principal property="nickname" />
								</p>
								<p class="text">Level : ${user.userLevel}</p>
								<p class="text">EXP : ${nowExperiencePoint} / Next :
									${nextExperiencePoint}</p>

								<div class="moreInfo">
									<ul class="moreInfo">
										<li><a href=" <c:url value="/profile/avataredit"/>">Edit
												Photo</a></li>
										<li><a href="<c:url value="/profile"/>">My Profile</a></li>
									</ul>
								</div>
							</div>
							<!-- parts -->
							<div id="timemapBox" class="parts memberImageBox"
								style="text-align: center">
								<button id="jumpTimemap" class="btn btn-block btn-primary">Go
									to TimeMap</button>
							</div>
							<div id="timemapBox" class="parts memberImageBox"
								style="text-align: center">
								<button id="jumpLogstate" class="btn btn-block btn-info">My
									Learning Log States</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-5">
					<div class="panel panel-primary">
						<div class="panel-heading">
							My Logs <a class="addlink" href="<c:url value="/item/add"/>"
								id="mypage2"><FONT color="red"><i
									class="glyphicon glyphicon-pencil" style="margin-left: 10px"></i>Add
									new object</FONT></a>
						</div>
						<div class="panel-body">

							<div class="block">
								<ul class="articleList">
									<c:forEach items="${myitems.result}" var="myitem">
										<li><span class="date"><fmt:formatDate
													value="${myitem.createTime}" type="date"
													pattern="yyyy/MM/dd" /></span><a
											href="<c:url value = "/item/${myitem.id}"/>">${myitem.defaultTitle}</a>
										</li>
									</c:forEach>
								</ul>
								<c:if test="${myitems.hasNext}">
									<div class="moreInfo">
										<ul class="moreInfo">
											<li><a
												href="<c:url value="/item"><c:param name="username" value="${user.nickname}" /></c:url>">More</a></li>
										</ul>
									</div>
								</c:if>
							</div>

						</div>
					</div>
					<div class="panel panel-primary">
						<div class="panel-heading">Answered by Me</div>
						<div class="panel-body">
							<div class="partsInfo" style="color: navy">
								<div class="block">
									<ul class="articleList">
										<c:forEach items="${answeritems.result}" var="answeritem">
											<li><span class="date"><fmt:formatDate
														value="${answeritem.createTime}" type="date"
														pattern="yyyy/MM/dd" /></span> &nbsp;<a
												href="<c:url value = "/item/${answeritem.id}"/>">${answeritem.defaultTitle}(${fn:length(answeritem.question.answerSet)})</a>(${answeritem.author.nickname})
											</li>
										</c:forEach>
									</ul>
									<c:if test="${answeritems.hasNext}">
										<div class="moreInfo">
											<ul class="moreInfo">
												<li><a
													href="<c:url value="/item"><c:param name="answeruserId" value="${user.id}" /></c:url>">More</a></li>
											</ul>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4">
				<div class="panel panel-primary">
						<div class="panel-heading">Very important logs in my group</div>
						<div class="panel-body">
							<div class="partsInfo" style="color: navy">
								<div class="block">
									<ul class="articleList">
										<c:forEach items="${importance}" var="answeritem">
											<li><span class="date"><fmt:formatDate
														value="${answeritem.create_time}" type="date"
														pattern="yyyy/MM/dd" /></span> &nbsp;<a
												href="<c:url value = "/item/${answeritem.id}"/>">${answeritem.content}</a> by (${answeritem.nickname})
											</li>
										</c:forEach>
									</ul>
									<c:if test="${answeritems.hasNext}">
										<div class="moreInfo">
											<ul class="moreInfo">
												<li><a
													href="<c:url value="/item"><c:param name="answeruserId" value="${user.id}" /></c:url>">More</a></li>
											</ul>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>




			<!-- /.row -->
			<!-- 
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-bar-chart-o fa-fw"></i> Area Chart
								</h3>
							</div>
							<div class="panel-body">
								<div id="morris-area-chart"></div>
							</div>
						</div>
					</div>
				</div> -->
			<!-- /.row -->


			<!-- /.row -->

		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->

</body>

</html>
