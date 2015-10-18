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
		
		document.getElementById("mygoal").className = "active";
		
	

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
			<c:import url="../include/vascorllheader.jsp">
			</c:import>

			<!-- /.navbar-collapse -->
		</nav>

		<div id="page-wrapper">

			<div class="container-fluid">

				<!-- Page Heading -->
				<div class="row">
					<div class="col-lg-12">
						<h1 class="page-header">My goal</h1>

					</div>
				</div>



				<div class="row">
					<div class="col-lg-4">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-long-arrow-right fa-fw"></i> Japanese Language
									Level
								</h3>
							</div>
							<div class="panel-body">

								<div id="container"
									style="min-width: 310px; height: 400px; margin: 0 auto"></div>
								<div class="text-right">
									<a href="#">View Details <i
										class="fa fa-arrow-circle-right"></i></a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> My goal
								</h3>
							</div>
							<div class="panel-body">
								<div class="bs-callout bs-callout-primary">
									<h4>JLPT Word Level</h4>
									<ul>
										<li>${mygoal.jplevel}</li>
									</ul>
									<br>
									<h4>Target time (deadline)</h4>
									<ul>
										<li>${mygoal.totaltime} day <br>(${mygoal.nickname})
										</li>
									</ul>
									<br>
									<h4>Learning time for one day</h4>
									<ul>
										<li>${mygoal.onetime} minute</li>
									</ul>
									<br>
									<h4>Goal word numbers</h4>
									<ul>
										<li>${mygoal.totalword} words</li>
									</ul>
									<br>
									<h4>Goal word numbers for one day</h4>
									<ul>
										<li>${mygoal.oneword} words</li>
									</ul>
									<br>
								</div>

								<div class="text-right">
									<a href="#">View All Activity <i
										class="fa fa-arrow-circle-right"></i></a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-money fa-fw"></i><a class="addlink"
										href="<c:url value="/item/add"/>"><FONT color="red">Add
											new object</FONT></a> &nbsp; Today my logs
								</h3>
							</div>
							<div class="panel-body">

								<div class="table-responsive">
									<table class="table table-bordered table-hover table-striped">
										<thead>
											<tr>
												<th>Create time</th>
												<th>Log name</th>
												<th>Level</th>

											</tr>
										</thead>
										<tbody>
											<c:forEach items="${todaylogs}" var="myitem">
												<tr>
													<td><span class="date"><fmt:formatDate
																value="${myitem.create_time}" type="date"
																pattern="yyyy/MM/dd" /></span></td>
													<td><a href="<c:url value = "/item/${myitem.id}"/>">${myitem.content}

													</a></td>
													<td><c:if test="${myitem.level!=null}">
																&nbsp;n${myitem.level}
															</c:if></td>
												</tr>

											</c:forEach>
									</table>
								</div>
								<div class="text-right">
									<a href="#">View All Transactions <i
										class="fa fa-arrow-circle-right"></i></a>
								</div>
							</div>
						</div>
					</div>
				</div>



				<div class="row">
					<div class="col-lg-3 col-md-6">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">
										<c:if test="${onelog >0}">
											<img
												src="<c:url value='/images/quiz_rabit/rabit/wink.png' />"
												alt="" />


										</c:if>
										<c:if test="${onelog ==0}">
											<img
												src="<c:url value='/images/quiz_rabit/rabit/happy.png' />"
												alt="" />

										</c:if>
									</div>

									<div class="col-xs-9 text-right">
										<c:if test="${onelog >0}">
											<div class="huge">${onelog}</div>
											<div>Almost there! Study ${onelog} word</div>
										</c:if>
										<c:if test="${onelog ==0}">
											<div class="huge">Clear</div>
											<div>Very good!! Today goal is clear</div>
										</c:if>


									</div>
								</div>
							</div>
							<a href="#">
								<div class="panel-footer">
									<span class="pull-left">View Details</span> <span
										class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
									<div class="clearfix"></div>
								</div>
							</a>
						</div>
					</div>
					<div class="col-lg-3 col-md-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">
										<c:if test="${goallog >0}">
											<img
												src="<c:url value='/images/quiz_rabit/rabit/smile.png' />"
												alt="" />

										</c:if>
										<c:if test="${goallog ==0}">
											<img
												src="<c:url value='/images/quiz_rabit/rabit/happy.png' />"
												alt="" />

										</c:if>


									</div>
									<div class="col-xs-9 text-right">
										<c:if test="${goallog >0}">
											<div class="huge">${goallog}</div>
											<div>Study ${goallog} word in total</div>

										</c:if>
										<c:if test="${goallog ==0}">
											<div class="huge">Clear</div>
											<div>Very good!! Your goal is clear</div>
										</c:if>


									</div>
								</div>
							</div>
							<a href="#">
								<div class="panel-footer">
									<span class="pull-left">View Details</span> <span
										class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
									<div class="clearfix"></div>
								</div>
							</a>
						</div>
					</div>
					<!--  
					<div class="col-lg-3 col-md-6">
						<div class="panel panel-yellow">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">
										<i class="fa fa-shopping-cart fa-5x"></i>
									</div>
									<div class="col-xs-9 text-right">
										<div class="huge">124</div>
										<div>New Orders!</div>
									</div>
								</div>
							</div>
							<a href="#">
								<div class="panel-footer">
									<span class="pull-left">View Details</span> <span
										class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
									<div class="clearfix"></div>
								</div>
							</a>
						</div>
					</div>
					<div class="col-lg-3 col-md-6">
						<div class="panel panel-red">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">
										<i class="fa fa-support fa-5x"></i>
									</div>
									<div class="col-xs-9 text-right">
										<div class="huge">13</div>
										<div>Support Tickets!</div>
									</div>
								</div>
							</div>
							<a href="#">
								<div class="panel-footer">
									<span class="pull-left">View Details</span> <span
										class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
									<div class="clearfix"></div>
								</div>
							</a>
						</div>
					</div>-->
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
