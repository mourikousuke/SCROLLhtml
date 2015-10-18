<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!doctype html>
<html>
<c:import url="../include/vsjscss.jsp">
</c:import>

<script type="text/javascript">
	$(document).ready(function() {
		
		document.getElementById("setting").className = "active";
		document.getElementById("default__homepage").className = "active";
	});
</script>
<script type="text/javascript">
function myEnter(){
     myPassWord=prompt("パスワードを入力してください","");
     if ( myPassWord == "pass1" ){
         location.href="<c:url value = "/profile/ins"/>";
     }else{
         alert( "パスワードが違います!" );
     }
}
</script>
<style>
table {
	width: 600px;
	border-spacing: 0;
	font-size: 14px;
}

table th {
	color: #000;
	padding: 8px 15px;
	background: #eee;
	background: -moz-linear-gradient(#eee, #ddd 50%);
	background: -webkit-gradient(linear, 100% 100%, 100% 50%, from(#eee),
		to(#ddd) );
	font-weight: bold;
	border-top: 1px solid #aaa;
	border-bottom: 1px solid #aaa;
	line-height: 120%;
	text-align: center;
	text-shadow: 0 -1px 0 rgba(255, 255, 255, 0.9);
	box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.3) inset;
}

table th:first-child {
	border-left: 1px solid #aaa;
	border-radius: 5px 0 0 0;
}

table th:last-child {
	border-radius: 0 5px 0 0;
	border-right: 1px solid #aaa;
	box-shadow: 2px 2px 1px rgba(0, 0, 0, 0.1);
}

table tr td {
	padding: 8px 15px;
	text-align: center;
}

table tr td:first-child {
	border-left: 1px solid #aaa;
}

table tr td:last-child {
	border-right: 1px solid #aaa;
	box-shadow: 2px 2px 1px rgba(0, 0, 0, 0.1);
}

table tr {
	background: #fff;
}

table tr:nth-child(2n+1) {
	background: #f5f5f5;
}

table tr:last-child td {
	border-bottom: 1px solid #aaa;
	box-shadow: 2px 2px 1px rgba(0, 0, 0, 0.1);
}

table tr:last-child td:first-child {
	border-radius: 0 0 0 5px;
}

table tr:last-child td:last-child {
	border-radius: 0 0 5px 0;
}

table tr:hover {
	background: #eee;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	//var gname;
	//var gauthor;
	var globalauthor;
	var globalgroupname;
	var groupid;
	function onJoin(id, n, group) {
		globalauthor = "";
		globalauthor = n;
		groupid = group;
		globalgroupname = "";
		globalgroupname = id;
		//gname=id;
		//gauthor=n;
		//alert(id);
		//var text=document.createTextNode(id);
		//gname.document.value="test"
		//gname.appendChild(text);
		document.getElementById("gname").innerHTML = id;
		//getauthor
		<c:url value="/mysetting/getauthor" var="group" />
		$.ajax({
			type : "POST",
			url : "${group}",
			data : {
				groupid : groupid
			},
			success : function(msg) {

			},
			error : function() {
				alert("failure");
			}
		});
	}

	$(function() {
		<c:url value="/mysetting/groupadd" var="group" />
		$("button#submit").click(function() {
			$.ajax({
				type : "POST",
				url : "${group}",
				data : {
					authorid : globalauthor,
					groupname : globalgroupname,
					groupid : groupid
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		});
		<c:url value="/mysetting/groupdelete" var="groupdelete" />
		$("button#delete").click(function() {
			$.ajax({
				type : "POST",
				url : "${groupdelete}",
				data : {
					authorid : globalauthor,
					groupname : globalgroupname,
					groupid : groupid
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		});

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
						<h1 class="page-header">Admin page</h1>
					

					</div>
				</div>
		
				<div class="row">
					<div class="col-lg-6">
					<div class="panel panel-red">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">
									ALL users
									</div>

								</div>
							</div>
							<table class="table table-striped">
							<tr><td>User</td><td>Nickname</td><td>e-mail</td><td>Last Login</td><td>Quiz detail</td></tr>
							<c:forEach items="${adminall}" var="myitem">
									<tr>
										<td><img src="${staticserverUrl}/${projectName}/${myitem.avatar}_160x120.png"
											style="height: 30px; width: 30px"></img></td>
											<td>${myitem.nickname}</td>
										
										
										<td><a href="mailto:${myitem.pc_email}?subject=問い合わせ&amp;body=ご記入ください">${myitem.pc_email}</a></td>
										<td>

											${myitem.lastlogin}
											<div class="text-right">
												
											</div>
										</td>
										<td>
										<a href="<c:url value="/profile/userquiz?studentid=${myitem.id}"/>">View</a>
										</td>

									</tr>

								</c:forEach>
							
			
							</table>
						</div>
							
					</div>
				
				
				
					<div class="col-lg-6">
					<div class="panel panel-red">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">
									Group member
									</div>

								</div>
							</div>
							<table class="table table-striped">
							<tr><td>User</td><td>Group</td><td>Nickname</td><td>e-mail</td><td>Last Login</td><td>Quiz detail</td></tr>
							<c:forEach items="${admingroup}" var="myitem">
									<tr>
										<td><img src="${staticserverUrl}/${projectName}/${myitem.avatar}_160x120.png"
											style="height: 30px; width: 30px"></img></td>
											<td>${myitem.groupname}</td>
										<td>${myitem.nickname}</td>
										
										<td><a href="mailto:${myitem.pc_email}?subject=問い合わせ&amp;body=ご記入ください">${myitem.pc_email}</a></td>
										<td>

											${myitem.lastlogin}
											<div class="text-right">
												
											</div>
										</td>
										<td>
										<a href="<c:url value="/profile/userquiz?studentid=${myitem.other}"/>">View</a>
										</td>

									</tr>

								</c:forEach>
							
							
							<!--  
								<c:forEach items="${current}" var="myitem">
									<tr>
										<td><img src="${myitem.icon}"
											style="height: 30px; width: 30px"></img></td>
										<td>${myitem.place}(${myitem.attribute})


											<div class="text-right">
												<a
													href="<c:url value="/quiz/myquiz?lat=${nowlat}&lng=${nowlng}&season=${season}&timezone=${timezone}&place=${myitem.attribute}"/>">Check
													in<i class="fa fa-arrow-circle-right"></i>
												</a>
											</div>
										</td>

									</tr>

								</c:forEach>-->
							</table>
						</div>
							
					</div>
				
				</div>


			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

</html>