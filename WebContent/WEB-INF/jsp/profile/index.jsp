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
		//document.getElementById("default__homepage").className = "active";
	});
</script>
<script type="text/javascript">
function myEnter(){
     myPassWord=prompt("パスワードを入力してください","");
     if ( myPassWord == "mouri" ){
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
						<h1 class="page-header">My profile</h1>
<c:import url="../include/profile_var.jsp"></c:import>

					</div>
				</div>



				<div class="row">
					<div class="col-lg-3">
						<div class="panel panel-primary">
								<div class="panel-heading">
									My status
								</div>
								<div class="panel-body">
													<div id="memberImageBox_22" class="parts memberImageBox">

								<p class="photo">
									<c:choose>
										<c:when test="${empty user.avatar}">
											<img alt="LearningUser"
												src="<c:url value="/images/no_image.gif" />" height="180"
												width="100%" />
										</c:when>
										<c:otherwise>
											<img alt="LearningUser"
												src="<c:url value="${staticserverUrl}/${projectName}/${user.avatar.id}_320x240.png" />"
												 style="width:100%"/>
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
										</ul>
										
								</div>
								<ul style="margin-top:10px;margin-right:10px"><b>Your group :</b> <c:forEach items="${groupname}" var="group"
												varStatus="status">
													<li>${group.groupname}</li>
											</c:forEach>
									</ul>
							</div>
								</div>
							</div>
							<font color="black"><input type="button" class="btn btn-block btn-danger" value="Move to Admin" onclick="myEnter()"></font>
					</div>
					<div class="col-lg-5">
							<div id="Left">
							
							<div class="panel panel-primary">
								<div class="panel-heading">
									Group &nbsp;&nbsp;
								</div>
								<div class="panel-body">
										<c:forEach items="${groupdata}" var="group" varStatus="status">

								<li><a href=""
									onClick="onJoin('${group.groupname}','${group.author}','${group.id}')"
									style="margin-left: 30px" data-toggle="modal"
									data-target="#myModal">${group.groupname}</a></li>



							</c:forEach>
								</div>
							</div>
							
							
							
			
						</div>
					</div>
					<div class="col-lg-4">
						<div class="panel panel-primary" style="margin-top:5px">
								<div class="panel-heading">
									Profile edit &nbsp;<a href="<c:url value="/profile/edit" />"><font color="red">Edit</font></a>
								</div>
								<div class="panel-body">
													<c:url value="/signup/${user.activecode}" var="signupFormUrl" />
													
		<div class="bs-callout bs-callout-primary" style="margin-top:-5px">
									<h4>E-mail</h4>
									<ul>
										<li>${user.pcEmail}</li>
									</ul>
									
									<h4>Nick name</h4>
									<ul>
										<li>${user.nickname}
										</li>
									</ul>
									
									<h4>Family Name</h4>
									<ul>
										<li>${user.firstName}</li>
									</ul>
									
									<h4>Given Name</h4>
									<ul>
										<li>${user.lastName}</li>
									</ul>
									
									<c:forEach items="${user.myLangs}" var="myLan" varStatus="lan">
									<h4>Native language(${lan.count})</h4>
									<ul><li>${myLan.name}</li></ul>
								    </c:forEach>
								    <c:forEach items="${user.studyLangs}" var="slan"
									varStatus="status">
								<h4>Language of study(${status.count})</h4>
										<ul><li>${slan.name}</li></ul>
								</c:forEach>
								
								<h4>Categories</h4>
									<ul>
											<c:forEach items="${user.myCategoryList}" var="cat">
												<li <c:if test="${user.defaultCategory!=null && user.defaultCategory.id==cat.id}"></c:if>>${cat.name}</li>
											</c:forEach>
										</ul>
								<h4>Age</h4>
									<ul>
										<li>${ability.age}</li>
									</ul>
									<h4>Gender</h4>
									<ul>
										<li>${ability.gender}</li>
									</ul>
									<!--  
									<h4>Nationality</h4>
									<ul>
										<li>${ability.nationality}</li>
									</ul>-->
									<h4>Length stay</h4>
									<ul>
										<li>${ability.stay} years</li>
									</ul>
									<h4>Japanese Language Proficiency Test</h4>
									<ul>
										<li>Level ${ability.j_level}</li>
									</ul>
								
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

	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true"
					style="height: 200px; width: 610px">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">
									<div id="gname"></div>
								</h4>
							</div>
							<div>
							<c:forEach items="${authorgroup}" var="group" varStatus="status">

								${group.nickname}

								<br>
							</c:forEach>
							</div>
							<div class="modal-body">
								<form class="contact">
									<button value="Join" class="btn btn-info" data-dismiss="modal"
										id="submit">Join</button>
									<button type="submit" class="btn btn-primary" value="Not Join"
										data-dismiss="modal" id="delete">Delete Join</button>
										<button type="submit" class="btn btn-primary" value="Not Join"
										data-dismiss="modal">Not Join</button>
								</form>

							</div>

						</div>
					</div>
					</div>
</html>
