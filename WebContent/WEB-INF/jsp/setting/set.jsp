<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!doctype html>
<html>
<c:import url="../include/vsjscss.jsp">
</c:import>
<c:import url="../include/head.jsp">
	<c:param name="title" value="Profile" />
</c:import>
<link rel="stylesheet" href="${ctx}/learninglog/css/setting.css" />

<script type="text/javascript">
	$(document).ready(function() {
		
		
		document.getElementById("prof_setting").className = "active";
	});
</script>
<script type="text/javascript">
	$(function() {
		$('#dateFrom').datepicker({
			dateFormat : 'yy-mm-dd'
		});
		$('#dateTo').datepicker({
			dateFormat : 'yy-mm-dd'
		});
		$(".item").click(function() {
			window.location.href = $(this).attr("data-url");
		}).css("cursor", "pointer");
	});
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
			<c:import url="../include/vascorllheader.jsp">
			</c:import>

			<!-- /.navbar-collapse -->
		</nav>

		<div id="page-wrapper">

			<div class="container-fluid">

				<!-- Page Heading -->
				<div class="row">
					<div class="col-lg-12">
						<h1 class="page-header">Setting</h1>
<c:import url="../include/profile_var.jsp"></c:import>
					</div>
				</div>



				<div class="row">
					<div class="col-lg-4">
						<div class="panel panel-primary">
							<div class="panel-heading">Myquiz setting</div>
							<div class="panel-body">
								<table>
									<tr>
										<td><c:url value="/mysetting/quiz" var="itemSearchUrl" />
											<form:form commandName="setting" action="${itemSearchUrl}"
												method="post">
												<div class="list-group-item">

													<b>Date</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<form:input id="dateFrom" path="d1" size="10"
														maxlength="10" cssStyle="width:25%;height:30px;" />
													&nbsp;～&nbsp;
													<form:input id="dateTo" path="d2" size="10" maxlength="10"
														cssStyle="width:25%;height:30px;" />

												</div>
												<input type="submit" value="Setting" class="btn btn-info"
													style="width: 100px; margin-left: 20px; margin-top: 20px" />
											</form:form></td>
									</tr>
									<tr>
										<td><c:url value="/mysetting/quizdelete"
												var="itemSearchUrl" /> <form:form commandName="setting"
												action="${itemSearchUrl}" method="post">

												<input type="submit" value="Initialization"
													class="btn btn-info"
													style="width: 100px; margin-left: 20px; margin-top: 20px" />
											</form:form></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
							<div class="panel panel-primary">
							<div class="panel-heading">Group setting</div>
							<div class="panel-body">
								<c:url value="/mysetting/group" var="set2" />
								<form:form commandName="setting" action="${set2}" method="post"
									enctype="multipart/form-data">
									<div class="radioka" style="height: 20px">
										Group Name
										<form:input path="groupname"
											style="height:30px;margin-left:10px;margin-top:5px" />
									</div>

									<hr size="1" color="#ffc8c8"
										style="width: 100%; margin-top: 40px">
									<table>
										<tr>
											<th rowspan="4">Privacy</th>
											<td width="200"><center>
													<form:radiobutton name="q1" value="public"
														style="height: 20px; margin-top: -1px;" path="privacy" />
													Public
												</center></td>
										</tr>
										<tr>
											<td width="200"><center>
													<form:radiobutton name="q1" value="private"
														style="height: 20px; margin-top: -1px;" path="privacy" />
													Private
												</center></td>
										</tr>
									</table>


									<input type="submit" value="Add" class="btn btn-info"
										style="width: 100px; margin-left: 20px; margin-top: 20px" />
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