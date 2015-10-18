<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>

<html>
<c:import url="../include/vsjscss.jsp">
</c:import>
<c:import url="../include/head.jsp">
</c:import>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("quiz").className = "active";
		
		navigator.geolocation.watchPosition(successCallback, errorCallback);
    	var place_lat = -1;
    	var place_log = -1;
    	function successCallback(position) {
    		place_lat = position.coords.latitude;

    		place_log = position.coords.longitude;
    		var clickElem = document.getElementById('locset');
    		clickElem.href = "<c:url value="/quiz/locset"/>" + "?lat=" + place_lat
    				+ "&lng=" + place_log;

    	}
    	function errorCallback(error) {
    		alert("位置情報取得できない");
    	}
    	
		

	});
</script>
</head>

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
					<h1 class="page-header">Quiz menu</h1>

				</div>
			</div>



			<div class="row">
				<div class="col-lg-4">
					<div class="panel panel-primary">
						<div class="panel-heading">Quiz options</div>
						<div class="panel-body">
							<ul class="nav nav-list">
								<!-- <li style="font-size: 20px"><a
									href="<c:url value="/quiz" />"><img alt=""
										src="<c:url value='/images/quizicon/Focus.png'/>" width="35px"
										height="35px" />Daily Quiz</a></li>-->
								<li style="font-size: 20px"><a id="locset"
									href="<c:url value="/quiz/locset" />"><img alt=""
										src="<c:url value='/images/quizicon/ColorStroke.png'/>"
										width="35px" height="35px" />Quiz</a></li>
											 <li style="font-size: 20px"><a
									href="<c:url value="/analysis/mysetting" />"><img alt=""
										src="<c:url value='/images/quizicon/Focus.png'/>" width="35px"
										height="35px" />Check JLPT skill</a></li>
								<!-- <li><a href="<c:url value="/quiz/level1" />">Beginner Quiz</a></li>
							<li><a href="#">Intermediate Quiz</a></li>
							<li><a href="#">Senior Quiz</a></li>
							 -->
							</ul>

							<ul class="nav nav-list">
								<li style="font-size: 20px"><a
									href="<c:url value="/quiz/logs" />"><img alt=""
										src="<c:url value='/images/quizicon/Intensify.png'/>"
										width="35px" height="35px" />Quiz Logs</a></li>
								<li style="font-size: 20px"><a
									href="<c:url value="/mysetting/setting" />"><img alt=""
										src="<c:url value='/images/quizicon/SolarWalk.png'/>"
										width="35px" height="35px" />Quiz Setting</a></li>
								<!--  
							<li style="font-size: 20px"><a
								href="<c:url value="/quiz/create" />"><img alt=""
									src="<c:url value='/images/quizicon/Outline.png'/>"
									width="35px" height="35px" />Quiz Create</a></li>
							<li style="font-size: 20px"><a href="#"><img alt=""
									src="<c:url value='/images/quizicon/SolarWalk.png'/>"
									width="35px" height="35px" />Quiz Send & Recommendation</a></li>
							<li style="font-size: 20px"><a href="#"><img alt=""
									src="<c:url value='/images/quizicon/UnRarX.png'/>" width="35px"
									height="35px" />Quiz Delete</a></li>-->

							</ul>
						</div>
					</div>


				</div>
				<div class="col-lg-4">
					<div class="panel panel-primary">
						<div class="panel-heading">Quiz ranking</div>
						<div class="panel-body">
							<table>
								<tr>
									<td><c:forEach items="${quizRanking}" var="quizRanking"
											end="9" varStatus="status">
											<li style="font-size: 16px; margin-left: 10px"><c:if
													test="${status.count == 1}">
													<strong><img alt=""
														src="<c:url value='/images/ranking/ranking-free-sozai1.png'/>"
														width="30px" height="30px" /></strong>
												</c:if> <c:if test="${status.count == 2}">
													<strong><img alt=""
														src="<c:url value='/images/ranking/ranking-free-sozai2.png'/>"
														width="30px" height="50px" /></strong>
												</c:if> <c:if test="${status.count == 3}">
													<strong><img alt=""
														src="<c:url value='/images/ranking/ranking-free-sozai3.png'/>"
														width="30px" height="50px" /></strong>
												</c:if> <c:if test="${status.count == 4}">
													<strong><img alt=""
														src="<c:url value='/images/ranking/ranking-free-sozai4.png'/>"
														width="30px" height="50px" /></strong>
												</c:if> <c:if test="${status.count == 5}">
													<strong><img alt=""
														src="<c:url value='/images/ranking/ranking-free-sozai5.png'/>"
														width="30px" height="50px" /></strong>
												</c:if> <c:if test="${status.count == 6}">
													<strong><img alt=""
														src="<c:url value='/images/ranking/ranking-free-sozai6.png'/>"
														width="30px" height="50px" /></strong>
												</c:if> <c:if test="${status.count == 7}">
													<strong><img alt=""
														src="<c:url value='/images/ranking/ranking-free-sozai7.png'/>"
														width="30px" height="50px" /></strong>
												</c:if> <c:if test="${status.count == 8}">
													<strong><img alt=""
														src="<c:url value='/images/ranking/ranking-free-sozai8.png'/>"
														width="30px" height="50px" /></strong>
												</c:if> <c:if test="${status.count == 9}">
													<strong><img alt=""
														src="<c:url value='/images/ranking/ranking-free-sozai9.png'/>"
														width="30px" height="50px" /></strong>
												</c:if> <c:if test="${status.count == 10}">
													<strong><img alt=""
														src="<c:url value='/images/ranking/ranking-free-sozai10.png'/>"
														width="30px" height="50px" /></strong>
												</c:if> <a style="margin-left: 20px"
												href="<c:url value="/item"><c:param name="username" value="${quizRanking[0].nickname}" /></c:url>">${quizRanking[0].nickname}&nbsp;</a>(${quizRanking[1]})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>

											<hr>
										</c:forEach></td>
									<td></td>
								</tr>
							</table>


						</div>
					</div>

				</div>

			</div>



		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- /#page-wrapper -->

</div>



</html>