<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html>
<c:import url="../include/vsjscss.jsp">
</c:import>
<c:import url="../include/head.jsp">
	<c:param name="title" value="写真編集" />
</c:import>
<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("setting").className = "active";
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
					<h1 class="page-header">Photo Edit</h1>

				</div>
			</div>



			<div class="row">
				<div class="col-lg-4">
				
				<c:url value="/profile/avataredit" var="url" />
									<form:form modelAttribute="form" action="${url}" method="post"
										enctype="multipart/form-data">
										<div id="memberImageBox_30" class="parts memberImageBox">
											<p class="photo">
												<a id="avatarImage" class="zoom" href="#avatarImageZoom">
													<img alt=""
													src="<c:url value="${staticserverUrl}/${projectName}/${user.avatar.id}_320x240.png" />"
													width="240px" />
												</a>
											</p>
											<p class="text"></p>
										</div>
										<!-- parts -->
										<table>
											<tr>
												<td><input type="file" name="photo" id="photo" />
												<form:errors path="photo" /></td>
											</tr>
										</table>
										<div class="operation">
											<ul class="moreInfo button">
												<li><center>
														<input type="submit" class="btn btn-block btn-primary"
															value="Save" style="width: 150px" />
													</center></li>
											</ul>
										</div>
									</form:form>
				
				
				
				</div>

			</div>

			<!-- /.row -->

		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->

</html>