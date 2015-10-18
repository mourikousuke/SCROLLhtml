<%@page contentType="text/html" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html>
<c:import url="include/vsjscss.jsp">
</c:import>
<c:import url="include/head.jsp">
	<c:param name="title" value="Learning Log" />
</c:import>
<script src="${baseURL}/js/highchart/highcharts.js"></script>
<script src="${baseURL}/js/highchart/modules/exporting.js"></script>
<script src="${baseURL}/js/notify/notify.min.js"></script>
<script src="${baseURL}/js/notify/styles/bootstrap/notify-bootstrap.js"></script>


<script type="text/javascript">
	$(document).ready(function() {
		

		document.getElementById("home").className = "active";

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
		<c:import url="include/vascorllheader.jsp">
		</c:import>

		<!-- /.navbar-collapse -->
	</nav>

	<div id="page-wrapper">

		<div class="container-fluid">

			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Home</h1>

				</div>
			</div>



			<div class="row">
				<div class="col-lg-4">
					<div class="panel panel-primary">
						<div class="panel-heading">Current Login Users</div>
						<div class="panel-body">
							<c:forEach items="${logininfo}" var="logininfo" end="9">
								<table style="line-height: 1.33em; border-collapse: collapse;"
									cellspacing="1″ cellpadding="5">
									<tbody>
										<tr>


											<c:choose>
												<c:when test="${not empty logininfo.avatar}">
													<td rowspan="5"><img alt=""
														src="${staticserverUrl}/${projectName}/${logininfo.avatar}_320x240.png"
														style="width: 40px; height: 40px" />&nbsp;</td>
												</c:when>
												<c:otherwise>
													<td rowspan="5"><img width="40px" height="40px" alt=""
														src="<c:url value="/images/no_image.gif" />" /> &nbsp;</td>
												</c:otherwise>
											</c:choose>
											<td>${logininfo.nickname}</td>
										</tr>
									</tbody>
								</table>
								<br>

							</c:forEach>

						</div>


					</div>

					<div id="rankingbox2" class="parts ranking">



						<div class="panel panel-primary">
							<div class="panel-heading">Answer Hero</div>
							<div class="panel-body">
								<div class="partsInfo" style="color: navy">
									<ul>
										<c:forEach items="${answerRanking}" var="aRanking" end="9">
											<li><a
												href="<c:url value="/item"><c:param name="answeruser" value="${aRanking[0].nickname}" /></c:url>">${aRanking[0].nickname}&nbsp;(${aRanking[1]})</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
						</div>

					</div>

					<div id="rankingbox2" class="parts ranking">
						<div class="panel panel-primary">
							<div class="panel-heading">Statistics</div>
							<div class="panel-body">

								<ul>
									<c:forEach items="${stat}" var="stat">
										<li>${stat.key}&nbsp;(${stat.value})</li>
									</c:forEach>
								</ul>

							</div>
						</div>

					</div>

					<div class="panel panel-primary">
						<div class="panel-heading">Latest answered questions</div>
						<div class="panel-body">
							<div class="block">
								<ul class="articleList">
									<c:forEach items="${answeredItems.result}" var="item">
										<li><span class="date"> <fmt:formatDate
													value="${item.updateTime}" type="date" pattern="yyyy/MM/dd" />
										</span> <a href="<c:url value="/item/${item.id}"/>">${item.question.content}(${fn:length(item.question.answerSet)})</a>
											(${item.author.nickname})</li>
									</c:forEach>
								</ul>
								<c:if test="${answeredItems.hasNext}">
									<div class="moreInfo">
										<c:url value="/item" var="answeredQuesItemUrl">
											<c:param name="userId" value="${user.id}" />
											<c:param name="hasAnswers" value="true" />
										</c:url>
										<ul class="moreInfo">
											<li><a href="${answeredQuesItemUrl}">More...</a></li>
										</ul>
									</div>
								</c:if>
							</div>




						</div>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="panel panel-danger">
						<div class="panel-heading">Entries awaiting your answers</div>
						<div class="panel-body">

							<div class="block">
								<ul class="articleList">
									<c:forEach items="${toAnswerItems.result}" var="item">
										<li><span class="date"><fmt:formatDate
													value="${item.createTime}" type="date" pattern="yyyy/MM/dd" /></span>&nbsp;&nbsp;<a
											href="<c:url value = "/item/${item.id}"/>">${item.question.content}(${fn:length(item.question.answerSet)})</a>
											(${item.author.nickname})</li>
									</c:forEach>
								</ul>
								<c:if test="${toAnswerItems.hasNext}">
									<div class="moreInfo">
										<ul class="moreInfo">
											<c:url value="/item" var="toAnswerQuesItemUrl">
												<c:forEach items="${user.myLangs}" var="lang">
													<c:param name="toAnswerQuesLangsCode" value="${lang.code}" />
												</c:forEach>
											</c:url>
											<li><a href="${toAnswerQuesItemUrl}">More...</a></li>
										</ul>
									</div>
								</c:if>
							</div>




						</div>
					</div>
					<div class="panel panel-info">
						<div class="panel-heading">Learning Log Dashborad</div>
						<div class="panel-body">
							<div class="block">
								<table class="table" style="width:100%">
									<tr>
										<td colspan="2">Uploaded learning logs</td>
										<td><span class="badge"> <c:forEach
													items="${uploadItemRanking}" var="uploadRanking" end="9">
										${uploadRanking[1]}
										</c:forEach>
										</span></td>
										<td></td>
									</tr>
									<tr>
										<td colspan="2">Completed quizzes</td>
										<td><span class="badge">${numberCompletedQuizzes}</span></td>
										<td></td>
									</tr>
									<tr>
										<td colspan="2">Learning log views</td>
										<td><span class="badge">${numberLogsViews}</span></td>
										<td></td>
									</tr>
									<tr style="width:100%">
										<td>Memorized learning logs</td>
										<td><span class="badge">${correct_items.correct}</span></td>
										<td><a href="<c:url value='/dashboard/4/1' />">
												<button class="btn btn-info">View the logs</button>
										</a></td>
										<td></td>
									</tr>
									<tr style="width:100%">
										<td>Number of incorrect answers (once)</td>
										<td><span class="badge">${items.wrong1}</span></td>
										<td><a href="<c:url value='/dashboard/1/1' />"><button
													class="btn btn-success">View the logs</button></a>
										<a href="<c:url value='/quiz/1' />"><button style="margin-top:5px"
													class="btn btn-success">Enjoy the quiz!</button></a></td>
									</tr>
									<tr style="width:100%">
										<td>Number of incorrect answers (twice)</td>
										<td><span class="badge">${items.wrong2}</span></td>
										<td><a href="<c:url value='/dashboard/2/1' />"><button
													class="btn btn-warning">View the logs</button></a>
										<a href="<c:url value='/quiz/2' />"><button style="margin-top:5px"
													class="btn btn-warning">Enjoy the quiz!</button></a></td>
									</tr>
									<tr style="width:100%">
										<td>Number of incorrect answers (3 or more times)</td>
										<td><span class="badge">${items.wrong3}</span></td>
										<td><a href="<c:url value='/dashboard/3/1' />"><button
													class="btn btn-danger">View the logs</button></a><a href="<c:url value='/quiz/3' />"><button style="margin-top:5px"
													class="btn btn-danger">Enjoy the quiz!</button></a></td>
									</tr>
									<tr style="width:100%">
										<td>Recommended learning logs</td>
										<td><span class="badge"></span></td>
										<td><a href="<c:url value='/dashboard/5/1' />"><button
													class="btn btn-default">View the logs</button></a>
										<a href="<c:url value='/quiz' />"><button style="margin-top:5px"
													class="btn btn-default">Enjoy the quiz!</button></a></td>
									</tr>
								</table>

								<div id="chart"></div>
								<script>
								$(function() {
									var chart;

									$(document)
											.ready(
													function() {

														// Build the chart
														$('#chart')
																.highcharts(
																		{
																			chart : {
																				plotBackgroundColor : null,
																				plotBorderWidth : null,
																				plotShadow : false
																			},
																			title : {
																				text : ' '
																			},
																			tooltip : {
																				pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
																			},
																			plotOptions : {
																				pie : {
																					allowPointSelect : true,
																					cursor : 'pointer',
																					dataLabels : {
																						enabled : true,
																						format: '<b>{point.name}</b>: {point.percentage:.1f} %',
																		                style: {
																		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
																		                    }
																					},
																					showInLegend : true
																				}
																			},
																			series : [ {
																				type : 'pie',
																				name : 'Browser share',
																				data : [																						
																						{
																							name : 'The learning logs of incorrect answer(once)',
																							color: '#5bb75b',
																							y : ${items.wrong1}																						
																						}	,
																						{
																							name : 'The learning logs of incorrect answer(twice)',
																							color: '#faa732',
																							y : ${items.wrong2}																						
																						}	,	
																						{
																							name : 'The learning logs of incorrect answer(3 or more times)',
																							color: '#da4f49',
																							y : ${items.wrong3}																						
																						}	,	
																						{
																							name : 'Memorized learning logs',
																							color: '#49afcd',
																							y : ${correct_items.correct},
																							sliced : true,
																							selected : true
																						}
																						 ],	
																			} ]
																		});
													});

								});
								/**
								 * Grid-light theme for Highcharts JS
								 * @author Torstein Honsi
								 */

								// Load the fonts
								Highcharts
										.createElement(
												'link',
												{
													href : 'http://fonts.googleapis.com/css?family=Dosis:400,600',
													rel : 'stylesheet',
													type : 'text/css'
												},
												null,
												document
														.getElementsByTagName('head')[0]);

								Highcharts.theme = {
									colors : [ "#7cb5ec", "#f7a35c", "#90ee7e",
											"#7798BF", "#aaeeee", "#ff0066",
											"#eeaaee", "#55BF3B", "#DF5353",
											"#7798BF", "#aaeeee" ],
									chart : {
										backgroundColor : null,
										style : {
											fontFamily : "Dosis, sans-serif"
										}
									},
									title : {
										style : {
											fontSize : '16px',
											fontWeight : 'bold',
											textTransform : 'uppercase'
										}
									},
									tooltip : {
										borderWidth : 0,
										backgroundColor : 'rgba(219,219,216,0.8)',
										shadow : false
									},
									legend : {
										itemStyle : {
											fontWeight : 'bold',
											fontSize : '13px'
										}
									},
									xAxis : {
										gridLineWidth : 1,
										labels : {
											style : {
												fontSize : '12px'
											}
										}
									},
									yAxis : {
										minorTickInterval : 'auto',
										title : {
											style : {
												textTransform : 'uppercase'
											}
										},
										labels : {
											style : {
												fontSize : '12px'
											}
										}
									},
									plotOptions : {
										candlestick : {
											lineColor : '#404048'
										}
									},

									// General
									background2 : '#F0F0EA'

								};

								// Apply the theme
								Highcharts.setOptions(Highcharts.theme);
								
								$(".box1").notify("Enjoy the quizes!", {position: "right"})
							</script>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4">

					<div class="panel panel-danger">
						<div class="panel-heading">New entries written in the
							language you are learning</div>
						<div class="panel-body">

							<div class="block">
								<ul class="articleList">
									<c:forEach items="${toStudyItems.result}" var="item">
										<li><span class="date"><fmt:formatDate
													value="${item.updateTime}" type="date" pattern="yyyy/MM/dd" /></span>&nbsp;&nbsp;<a
											href="<c:url value="/item/${item.id}"/>">${item.question.content}(${fn:length(item.question.answerSet)})</a>
											(${item.author.nickname})</li>
									</c:forEach>
								</ul>
								<c:if test="${toStudyItems.hasNext}">
									<div class="moreInfo">
										<c:url value="/item" var="toStudyQuesItemUrl">
											<c:forEach items="${user.studyLangs}" var="lang">
												<c:param name="toStudyQuesLangsCode" value="${lang.code}" />
											</c:forEach>
										</c:url>
										<ul class="moreInfo">
											<li><a href="${toStudyQuesItemUrl}">More...</a></li>
										</ul>
									</div>
								</c:if>
							</div>

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


<script type="text/javascript">
	document.getElementById("chartcontain").style.display = "none";
	document.getElementById("chartcontain2").style.display = "none";
	document.getElementById("chartcontain4").style.display = "none";
	document.getElementById("rightplace").style.display = "none";
	document.getElementById("placereview").style.display = "none";
	document.getElementById("rightseason").style.display = "none";
	document.getElementById("seasonreview").style.display = "none";
	document.getElementById("rightday").style.display = "block";
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-16851731-2']);
_gaq.push(['_trackPageview']);

(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript';
ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' :
'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0];
s.parentNode.insertBefore(ga, s);
})();

</script>


</body>

</html>
<c:import url="include/Slidermenu.jsp" />

