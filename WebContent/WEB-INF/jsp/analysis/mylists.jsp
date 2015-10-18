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
		document.getElementById("myjplist").className = "active";

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

<script type="text/javascript">
$(function () {
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'Your Japanese Language Vocabularies'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories:[              
                'N1',
                'N2',
                'N3',
                'N4'
            ]
        },
        yAxis: {
            min: 0,
            title: {
                text: 'The number of words'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series:[{
            name: 'The number of each your word',
            data: [${JPnumber[0].leveltotal}, ${JPnumber[1].leveltotal}, ${JPnumber[2].leveltotal},${JPnumber[3].leveltotal}]

        }]
    });
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
						<h1 class="page-header">My JP Lists</h1>

					</div>
				</div>





				<div class="row">

					<div class="col-lg-6">
						<div class="panel panel-yellow">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">level 1</div>

								</div>
							</div>
							<a href="#">
								<div class="panel-footer">
									<div class="table-responsive">
										<table class="table table-bordered table-hover table-striped">
											<thead>
												<tr>
													<th>Create time</th>
													<th>Log name</th>
													<th>Level</th>
													<th>Status</th>

												</tr>
											</thead>
											<tbody>
												<c:forEach items="${level1}" var="myitem">
													<tr>
														<td><span class="date"><fmt:formatDate
																	value="${myitem.create_time}" type="date"
																	pattern="yyyy/MM/dd" /></span></td>
														<td><a href="<c:url value = "/item/${myitem.id}"/>">${myitem.content}</a></td>
														<td><c:if test="${myitem.level!=null}">
																&nbsp;n${myitem.level}
															</c:if></td>
														
														<td><c:if test="${myitem.flag==0}">
																<img src="<c:url value='/images/quiz_rabit/rabit/happy.png' />" style="witdh:20px;height:20px"/>&nbsp;Remember
															</c:if>
															<c:if test="${myitem.flag==1}">
																&nbsp;Forget!!!
															</c:if>
															</td>
													</tr>

												</c:forEach>
										</table>
									</div>

									
								</div>
							</a>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="panel panel-red">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">level 2</div>
								</div>
							</div>
							<a href="#">
								<div class="panel-footer">
									<table class="table table-bordered table-hover table-striped">
										<thead>
											<tr>
												<th>Create time</th>
												<th>Log name</th>
												<th>Level</th>
												<th>Status</th>

											</tr>
										</thead>
										<tbody>
											<c:forEach items="${level2}" var="myitem">
												<tr>
													<td><span class="date"><fmt:formatDate
																value="${myitem.create_time}" type="date"
																pattern="yyyy/MM/dd" /></span></td>
													<td><a href="<c:url value = "/item/${myitem.id}"/>">${myitem.content}

													</a></td>
													<td><c:if test="${myitem.level!=null}">
																&nbsp;n${myitem.level}
															</c:if></td>
															<td><c:if test="${myitem.flag==0}">
																<img src="<c:url value='/images/quiz_rabit/rabit/happy.png' />" style="witdh:20px;height:20px"/>&nbsp;Remember
															</c:if>
															<c:if test="${myitem.flag==1}">
																&nbsp;Forget!!!
															</c:if>
															</td>
												</tr>

											</c:forEach>
									</table>

								
								</div>
							</a>
						</div>
					</div>
				</div>


				<div class="row">
					<div class="col-lg-6">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">
									Level 3
									</div>

								
								</div>
							</div>
							<a href="#">
								<div class="panel-footer">
									<div class="table-responsive">
										<table class="table table-bordered table-hover table-striped">
											<thead>
												<tr>
													<th>Create time</th>
													<th>Log name</th>
													<th>Level</th>
													<th>Status</th>

												</tr>
											</thead>
											<tbody>
												<c:forEach items="${level3}" var="myitem">
													<tr>
														<td><span class="date"><fmt:formatDate
																	value="${myitem.create_time}" type="date"
																	pattern="yyyy/MM/dd" /></span></td>
														<td><a href="<c:url value = "/item/${myitem.id}"/>">${myitem.content}

														</a></td>
														<td><c:if test="${myitem.level!=null}">
																&nbsp;n${myitem.level}
															</c:if></td>
															<td><c:if test="${myitem.flag==0}">
																<img src="<c:url value='/images/quiz_rabit/rabit/happy.png' />" style="witdh:20px;height:20px"/>&nbsp;Remember
															</c:if>
															<c:if test="${myitem.flag==1}">
																&nbsp;Forget!!!
															</c:if>
															</td>
													</tr>

												</c:forEach>
										</table>
									</div>

								</div>
							</a>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">
										Level 4
									</div>
									
								</div>
							</div>
							<a href="#">
								<div class="panel-footer">
								<div class="table-responsive">
										<table class="table table-bordered table-hover table-striped">
											<thead>
												<tr>
													<th>Create time</th>
													<th>Log name</th>
													<th>Level</th>
													<th>Status</th>

												</tr>
											</thead>
											<tbody>
												<c:forEach items="${level4}" var="myitem">
													<tr>
														<td><span class="date"><fmt:formatDate
																	value="${myitem.create_time}" type="date"
																	pattern="yyyy/MM/dd" /></span></td>
														<td><a href="<c:url value = "/item/${myitem.id}"/>">${myitem.content}

														</a></td>
														<td><c:if test="${myitem.level!=null}">
																&nbsp;n${myitem.level}
															</c:if></td>
															<td><c:if test="${myitem.flag==0}">
																<img src="<c:url value='/images/quiz_rabit/rabit/happy.png' />" style="witdh:20px;height:20px"/>&nbsp;Remember
															</c:if>
															<c:if test="${myitem.flag==1}">
																&nbsp;Forget!!!
															</c:if>
															</td>
													</tr>

												</c:forEach>
										</table>
									</div>

								</div>
							</a>
						</div>
					</div>
				</div>

				<!-- /.row -->

			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->


</body>

</html>
