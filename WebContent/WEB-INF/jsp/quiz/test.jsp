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

<title>VASCROLL</title>
<c:import url="../include/vsjscss.jsp">
</c:import>
<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
<script type="text/javascript">
	$(document).ready(function() {
		document.getElementById("quiz").className = "active";
		document.getElementById("correct").style.display = "none";
		document.getElementById("miss").style.display = "none";
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
<script>
	function ans() {
		var val1 = parseInt($("input[name='answer']:checked").val());
		var val2 = parseInt($("input[name='answer2']:checked").val());
		var val3 = parseInt($("input[name='answer3']:checked").val());
		var val4 = parseInt($("input[name='answer4']:checked").val());
		var val5 = parseInt($("input[name='answer5']:checked").val());
		
		if ((val1 + val2 + val3 + val4 + val5) == "5") {
			document.getElementById("score").innerHTML = "5";
			console.log("1");
			document.getElementById("q1").style.display = "none";
			if(val1==0){
				 document.getElementById('qa1').innerHTML = "Your answer is mistake. The correct answer is ";
			}
			document.getElementById("q2").style.display = "none";
			document.getElementById("q3").style.display = "none";
			document.getElementById("q4").style.display = "none";
			document.getElementById("q5").style.display = "none";
			document.getElementById("correct").style.display = "block";
			
			if(val1==0){
				console.log("5");
				<c:forEach items="${quiz1}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById('qa1').innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val1==1){
				document.getElementById("qa1").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val2==0){
				<c:forEach items="${quiz2}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qa2").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val2==1){
				document.getElementById("qa2").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val3==0){
				console.log("5");
				<c:forEach items="${quiz3}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qa3").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val3==1){
				document.getElementById("qa3").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val4==0){
				console.log("5");
				<c:forEach items="${quiz4}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qa4").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val4==1){
				document.getElementById("qa4").innerHTML = "<b>Your answer is correct!!!</b>";	
			}if(val5==0){
				console.log("5");
				<c:forEach items="${quiz5}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qa5").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val5==1){
				document.getElementById("qa5").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			

		} else if ((val1 + val2 + val3 + val4 + val5) == "4") {
			console.log("2");
			document.getElementById("score").innerHTML = "4";
			document.getElementById("q1").style.display = "none";
			document.getElementById("q2").style.display = "none";
			document.getElementById("q3").style.display = "none";
			document.getElementById("q4").style.display = "none";
			document.getElementById("q5").style.display = "none";
			document.getElementById("correct").style.display = "block";
			
			if(val1==0){
				console.log("5");
				<c:forEach items="${quiz1}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qa1").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val1==1){
				document.getElementById("qa1").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val2==0){
				<c:forEach items="${quiz2}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qa2").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val2==1){
				document.getElementById("qa2").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val3==0){
				console.log("5");
				<c:forEach items="${quiz3}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qa3").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val3==1){
				document.getElementById("qa3").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val4==0){
				console.log("5");
				<c:forEach items="${quiz4}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qa4").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val4==1){
				document.getElementById("qa4").innerHTML = "<b>Your answer is correct!!!</b>";	
			}if(val5==0){
				console.log("5");
				<c:forEach items="${quiz5}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qa5").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val5==1){
				document.getElementById("qa5").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			

		} else if ((val1 + val2 + val3 + val4 + val5) == "3") {
			console.log("3");
			document.getElementById("testscore").innerHTML = "3";
			document.getElementById("q1").style.display = "none";
		
			document.getElementById("q2").style.display = "none";
			document.getElementById("q3").style.display = "none";
			document.getElementById("q4").style.display = "none";
			document.getElementById("q5").style.display = "none";
			document.getElementById("correct").style.display = "none";
			document.getElementById("miss").style.display = "block";
			
			if(val1==0){
				console.log("5");
				<c:forEach items="${quiz1}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest1").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val1==1){
				document.getElementById("qatest1").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val2==0){
				<c:forEach items="${quiz2}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest2").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val2==1){
				document.getElementById("qatest2").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val3==0){
				console.log("5");
				<c:forEach items="${quiz3}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest3").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val3==1){
				document.getElementById("qatest3").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val4==0){
				console.log("5");
				<c:forEach items="${quiz4}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest4").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val4==1){
				document.getElementById("qatest4").innerHTML = "<b>Your answer is correct!!!</b>";	
			}if(val5==0){
				console.log("5");
				<c:forEach items="${quiz5}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest5").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val5==1){
				document.getElementById("qatest5").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			
			
		} else if ((val1 + val2 + val3 + val4 + val5) == "2") {
			console.log("4");
			document.getElementById("testscore").innerHTML = "2";
			document.getElementById("q1").style.display = "none";
		
			document.getElementById("q2").style.display = "none";
			document.getElementById("q3").style.display = "none";
			document.getElementById("q4").style.display = "none";
			document.getElementById("q5").style.display = "none";
			document.getElementById("miss").style.display = "block";
			
			if(val1==0){
				console.log("5");
				<c:forEach items="${quiz1}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest1").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val1==1){
				document.getElementById("qatest1").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val2==0){
				<c:forEach items="${quiz2}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest2").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val2==1){
				document.getElementById("qatest2").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val3==0){
				console.log("5");
				<c:forEach items="${quiz3}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest3").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val3==1){
				document.getElementById("qatest3").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val4==0){
				console.log("5");
				<c:forEach items="${quiz4}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest4").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val4==1){
				document.getElementById("qatest4").innerHTML = "<b>Your answer is correct!!!</b>";	
			}if(val5==0){
				console.log("5");
				<c:forEach items="${quiz5}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest5").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val5==1){
				document.getElementById("qatest5").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			
			
			
		} else {
			console.log("1");
			console.log(val1 + val2 + val3 + val4 + val5);
			var sc = document.getElementById("testscore");
			sc.innerHTML =val1 + val2 + val3 + val4 + val5;
			document.getElementById("q1").style.display = "none";
			if(val1==0){
				console.log("5");
				<c:forEach items="${quiz1}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById('qatest1').innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val1==1){
				document.getElementById("qatest1").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val2==0){
				<c:forEach items="${quiz2}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest2").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val2==1){
				document.getElementById("qatest2").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val3==0){
				console.log("5");
				<c:forEach items="${quiz3}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest3").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val3==1){
				document.getElementById("qatest3").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			if(val4==0){
				console.log("5");
				<c:forEach items="${quiz4}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest4").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val4==1){
				document.getElementById("qatest4").innerHTML = "<b>Your answer is correct!!!</b>";	
			}if(val5==0){
				console.log("5");
				<c:forEach items="${quiz5}" var="choice" varStatus="status">
				<c:if test="${choice.answer==1}">
				 document.getElementById("qatest5").innerHTML = "<b>Your answer is mistake. The correct answer is ${choice.content} </b>";
				</c:if>
			    </c:forEach>
				
			}
			if(val5==1){
				document.getElementById("qatest5").innerHTML = "<b>Your answer is correct!!!</b>";	
			}
			
			
			
			document.getElementById("q2").style.display = "none";
			document.getElementById("q3").style.display = "none";
			document.getElementById("q4").style.display = "none";
			document.getElementById("q5").style.display = "none";
			document.getElementById("miss").style.display = "block";
		}
	}
</script>


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
						<h1 class="page-header">Check test</h1>

					</div>

				</div>



				<div class="row">

					<div class="col-lg-5">

						<div id="q1" style="width: 100%">
							<div
								style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-bottom: 10px;">
								<img src="<c:url value='/images/system-help.png' />" alt="●" />Select
								the right word
								<c:forEach items="${quiz1}" var="choice" varStatus="status">
									<c:if test="${choice.answer==1}">
										<font color="red"><u>${choice.mycontent}</u></font>
									</c:if>
								</c:forEach>
								?
							</div>

							<table style="border-style: none;">
								<c:forEach items="${quiz1}" var="choice" varStatus="status">
									<ul
										style="list-style-image:url('<c:url value='/images/icon_arrow_2.gif' />');margin: 3px 10px; line-height: 30px;font-family: arial,meiryo,simsun,sans-serif; font-weight:bold; font-size: 18px; overflow: visible; color: green; vertical-align: baseline">
										<li><input type="radio" name="answer"
											value="${choice.answer}" />&nbsp;&nbsp;${choice.content}</li>
										<br>
									</ul>
								</c:forEach>
							</table>
						</div>

						<div id="q2" style="width: 100%">
							<div
								style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-bottom: 10px;">
								<img src="<c:url value='/images/system-help.png' />" alt="●" />Select
								the right word
								<c:forEach items="${quiz2}" var="choice" varStatus="status">
									<c:if test="${choice.answer==1}">
										<font color="red"><u>${choice.mycontent}</u></font>
									</c:if>
								</c:forEach>
								?
							</div>

							<table style="border-style: none;">
								<c:forEach items="${quiz2}" var="choice" varStatus="status">
									<ul
										style="list-style-image:url('<c:url value='/images/icon_arrow_2.gif' />');margin: 3px 10px; line-height: 30px;font-family: arial,meiryo,simsun,sans-serif; font-weight:bold; font-size: 18px; overflow: visible; color: green; vertical-align: baseline">
										<li><input type="radio" name="answer2"
											value="${choice.answer}" />&nbsp;&nbsp;${choice.content}</li>
										<br>
									</ul>
								</c:forEach>
							</table>
						</div>




						<div id="q3" style="width: 100%">
							<div
								style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-bottom: 10px;">
								<img src="<c:url value='/images/system-help.png' />" alt="●" />Select
								the right word
								<c:forEach items="${quiz3}" var="choice" varStatus="status">
									<c:if test="${choice.answer==1}">
										<font color="red"><u>${choice.mycontent}</u></font>
									</c:if>
								</c:forEach>
								?
							</div>

							<table style="border-style: none;">
								<c:forEach items="${quiz3}" var="choice" varStatus="status">
									<ul
										style="list-style-image:url('<c:url value='/images/icon_arrow_2.gif' />');margin: 3px 10px; line-height: 30px;font-family: arial,meiryo,simsun,sans-serif; font-weight:bold; font-size: 18px; overflow: visible; color: green; vertical-align: baseline">
										<li><input type="radio" name="answer3"
											value="${choice.answer}" />&nbsp;&nbsp;${choice.content}</li>
										<br>
									</ul>
								</c:forEach>
							</table>
						</div>

						<div id="q4" style="width: 100%">
							<div
								style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-bottom: 10px;">
								<img src="<c:url value='/images/system-help.png' />" alt="●" />Select
								the right word
								<c:forEach items="${quiz4}" var="choice" varStatus="status">
									<c:if test="${choice.answer==1}">
										<font color="red"><u>${choice.mycontent}</u></font>
									</c:if>
								</c:forEach>
								?
							</div>

							<table style="border-style: none;">
								<c:forEach items="${quiz4}" var="choice" varStatus="status">
									<ul
										style="list-style-image:url('<c:url value='/images/icon_arrow_2.gif' />');margin: 3px 10px; line-height: 30px;font-family: arial,meiryo,simsun,sans-serif; font-weight:bold; font-size: 18px; overflow: visible; color: green; vertical-align: baseline">
										<li><input type="radio" name="answer4"
											value="${choice.answer}" />&nbsp;&nbsp;${choice.content}</li>
										<br>
									</ul>
								</c:forEach>
							</table>
						</div>

						<div id="q5" style="width: 100%">
							<div
								style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-bottom: 10px;">
								<img src="<c:url value='/images/system-help.png' />" alt="●" />Select
								the right word
								<c:forEach items="${quiz5}" var="choice" varStatus="status">
									<c:if test="${choice.answer==1}">
										<font color="red"><u>${choice.mycontent}</u></font>
									</c:if>
								</c:forEach>
								?
							</div>

							<table style="border-style: none;">
								<c:forEach items="${quiz5}" var="choice" varStatus="status">
									<ul
										style="list-style-image:url('<c:url value='/images/icon_arrow_2.gif' />');margin: 3px 10px; line-height: 30px;font-family: arial,meiryo,simsun,sans-serif; font-weight:bold; font-size: 18px; overflow: visible; color: green; vertical-align: baseline">
										<li><input type="radio" name="answer5"
											value="${choice.answer}" />&nbsp;&nbsp;${choice.content}</li>
										<br>
									</ul>
								</c:forEach>
							</table>

							<div id="quizselect">
								<br /> <input type="button" class="btn btn-primary"
									value="Answer" style="width: 100%" onClick="ans()" />
							</div>
							<br><br><br>
						</div>


						<div id="correct">
							<br>
							<div class="panel panel-primary" style="margin-top: 5px">
								<div class="panel-heading">Quesition 1 <div id="qa1"></div></div>
								<div class="panel-body">
									<c:forEach items="${quiz1}" var="choice" varStatus="status">
										<table style="line-height: 1.33em; border-collapse: collapse;"
											cellspacing="1″ cellpadding="5″>
											<tbody>
												<tr>
													<c:choose>
														<c:when test="${choice.answer==1}">
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/cans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:when>
														<c:otherwise>
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/fans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:otherwise>
													</c:choose>


												</tr>
												<tr>
													<td>Japanese</td>
													<td>&nbsp; ${choice.content}</td>

												</tr>
												<tr>

													<td>English</td>
													<td>&nbsp; <a
														href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
													</td>

												</tr>


											</tbody>
										</table>
										<br>
									</c:forEach>
								</div>
							</div>
							<div class="panel panel-primary" style="margin-top: 5px">
								<div class="panel-heading">Question 2 <div id="qa2"></div></div>
								<div class="panel-body">
									<c:forEach items="${quiz2}" var="choice" varStatus="status">
										<table style="line-height: 1.33em; border-collapse: collapse;"
											cellspacing="1″ cellpadding="5″>
											<tbody>
												<tr>
													<c:choose>
														<c:when test="${choice.answer==1}">
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/cans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:when>
														<c:otherwise>
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/fans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:otherwise>
													</c:choose>


												</tr>
												<tr>
													<td>Japanese</td>
													<td>&nbsp; ${choice.content}</td>

												</tr>
												<tr>

													<td>English</td>
													<td>&nbsp; <a
														href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
													</td>

												</tr>


											</tbody>
										</table>
										<br>
									</c:forEach>
								</div>
							</div>
							<div class="panel panel-primary" style="margin-top: 5px">
								<div class="panel-heading">Question 3 <div id="qa3"></div></div>
								<div class="panel-body">
									<c:forEach items="${quiz3}" var="choice" varStatus="status">
										<table style="line-height: 1.33em; border-collapse: collapse;"
											cellspacing="1″ cellpadding="5″>
											<tbody>
												<tr>
													<c:choose>
														<c:when test="${choice.answer==1}">
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/cans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:when>
														<c:otherwise>
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/fans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:otherwise>
													</c:choose>


												</tr>
												<tr>
													<td>Japanese</td>
													<td>&nbsp; ${choice.content}</td>

												</tr>
												<tr>

													<td>English</td>
													<td>&nbsp; <a
														href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
													</td>

												</tr>


											</tbody>
										</table>
										<br>
									</c:forEach>
								</div>
							</div>
							<div class="panel panel-primary" style="margin-top: 5px">
								<div class="panel-heading">Question 4 <div id="qa4"></div></div>
								<div class="panel-body">
									<c:forEach items="${quiz4}" var="choice" varStatus="status">
										<table style="line-height: 1.33em; border-collapse: collapse;"
											cellspacing="1″ cellpadding="5″>
											<tbody>
												<tr>
													<c:choose>
														<c:when test="${choice.answer==1}">
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/cans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:when>
														<c:otherwise>
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/fans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:otherwise>
													</c:choose>


												</tr>
												<tr>
													<td>Japanese</td>
													<td>&nbsp; ${choice.content}</td>

												</tr>
												<tr>

													<td>English</td>
													<td>&nbsp; <a
														href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
													</td>

												</tr>


											</tbody>
										</table>
										<br>
									</c:forEach>
								</div>
							</div>
							<div class="panel panel-primary" style="margin-top: 5px">
								<div class="panel-heading">Question 5 <div id="qa5"></div></div>
								<div class="panel-body">
									<c:forEach items="${quiz5}" var="choice" varStatus="status">
										<table style="line-height: 1.33em; border-collapse: collapse;"
											cellspacing="1″ cellpadding="5″>
											<tbody>
												<tr>
													<c:choose>
														<c:when test="${choice.answer==1}">
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/cans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:when>
														<c:otherwise>
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/fans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:otherwise>
													</c:choose>


												</tr>
												<tr>
													<td>Japanese</td>
													<td>&nbsp; ${choice.content}</td>

												</tr>
												<tr>

													<td>English</td>
													<td>&nbsp; <a
														href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
													</td>

												</tr>


											</tbody>
										</table>
										<br>
									</c:forEach>
								</div>
							</div>
							<br> <span
								style="word-break: normal; color: green; font-size: 20px">
								<b>Great!! Your Score is
									<span id="score"></span> Your goal JLPT level is appropriate.<br>
									<img src="<c:url value='/images/quiz_rabit/rabit/blush.png' />"
								alt="" />
							</b>
							</span> <br> <br> <br>
						</div>


						<div id="miss">
							<br>
							<div class="panel panel-primary" style="margin-top: 5px">
								<div class="panel-heading">Quesition 1 <div id="qatest1"></div></div>
								<div class="panel-body">
									<c:forEach items="${quiz1}" var="choice" varStatus="status">
										<table style="line-height: 1.33em; border-collapse: collapse;"
											cellspacing="1″ cellpadding="5″>
											<tbody>
												<tr>
													<c:choose>
														<c:when test="${choice.answer==1}">
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/cans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:when>
														<c:otherwise>
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/fans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:otherwise>
													</c:choose>


												</tr>
												<tr>
													<td>Japanese</td>
													<td>&nbsp; ${choice.content}</td>

												</tr>
												<tr>

													<td>English</td>
													<td>&nbsp; <a
														href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
													</td>

												</tr>


											</tbody>
										</table>
										<br>
									</c:forEach>
								</div>
							</div>
							<div class="panel panel-primary" style="margin-top: 5px">
								<div class="panel-heading">Question 2 <div id="qatest2"></div></div>
								<div class="panel-body">
									<c:forEach items="${quiz2}" var="choice" varStatus="status">
										<table style="line-height: 1.33em; border-collapse: collapse;"
											cellspacing="1″ cellpadding="5″>
											<tbody>
												<tr>
													<c:choose>
														<c:when test="${choice.answer==1}">
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/cans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:when>
														<c:otherwise>
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/fans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:otherwise>
													</c:choose>


												</tr>
												<tr>
													<td>Japanese</td>
													<td>&nbsp; ${choice.content}</td>

												</tr>
												<tr>

													<td>English</td>
													<td>&nbsp; <a
														href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
													</td>

												</tr>


											</tbody>
										</table>
										<br>
									</c:forEach>
								</div>
							</div>
							<div class="panel panel-primary" style="margin-top: 5px">
								<div class="panel-heading">Question 3 <div id="qatest3"></div></div>
								<div class="panel-body">
									<c:forEach items="${quiz3}" var="choice" varStatus="status">
										<table style="line-height: 1.33em; border-collapse: collapse;"
											cellspacing="1″ cellpadding="5″>
											<tbody>
												<tr>
													<c:choose>
														<c:when test="${choice.answer==1}">
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/cans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:when>
														<c:otherwise>
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/fans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:otherwise>
													</c:choose>


												</tr>
												<tr>
													<td>Japanese</td>
													<td>&nbsp; ${choice.content}</td>

												</tr>
												<tr>

													<td>English</td>
													<td>&nbsp; <a
														href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
													</td>

												</tr>


											</tbody>
										</table>
										<br>
									</c:forEach>
								</div>
							</div>
							<div class="panel panel-primary" style="margin-top: 5px">
								<div class="panel-heading">Question 4 <div id="qatest4"></div></div>
								<div class="panel-body">
									<c:forEach items="${quiz4}" var="choice" varStatus="status">
										<table style="line-height: 1.33em; border-collapse: collapse;"
											cellspacing="1″ cellpadding="5″>
											<tbody>
												<tr>
													<c:choose>
														<c:when test="${choice.answer==1}">
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/cans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:when>
														<c:otherwise>
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/fans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:otherwise>
													</c:choose>


												</tr>
												<tr>
													<td>Japanese</td>
													<td>&nbsp; ${choice.content}</td>

												</tr>
												<tr>

													<td>English</td>
													<td>&nbsp; <a
														href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
													</td>

												</tr>


											</tbody>
										</table>
										<br>
									</c:forEach>
								</div>
							</div>
							<div class="panel panel-primary" style="margin-top: 5px">
								<div class="panel-heading">Question 5 <div id="qatest5"></div></div>
								<div class="panel-body">
									<c:forEach items="${quiz5}" var="choice" varStatus="status">
										<table style="line-height: 1.33em; border-collapse: collapse;"
											cellspacing="1″ cellpadding="5″>
											<tbody>
												<tr>
													<c:choose>
														<c:when test="${choice.answer==1}">
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/cans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:when>
														<c:otherwise>
															<td rowspan="3"><img alt=""
																src="<c:url value='/images/fans.png' />"
																style="width: 80px; height: 80px; margin-left: 10px" />&nbsp;</td>
														</c:otherwise>
													</c:choose>


												</tr>
												<tr>
													<td>Japanese</td>
													<td>&nbsp; ${choice.content}</td>

												</tr>
												<tr>

													<td>English</td>
													<td>&nbsp; <a
														href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
													</td>

												</tr>


											</tbody>
										</table>
										<br>
									</c:forEach>
								</div>
							</div>
							<br> 
								<span
								style="word-break: normal; color: green; font-size: 20px">
							<b>Sorry, Your JPLT level is incorrect. I would suggest that you set more low level.
									Your Score is <span id="testscore"></span>
							</b></span>
							 <br><img src="<c:url value='/images/quiz_rabit/rabit/sad.png' />"
								alt="" /> <br> <br>
							
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