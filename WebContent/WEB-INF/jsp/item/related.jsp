<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="userId">
	<shiro:principal property="id" />
</c:set>
<!doctype html>
<html>
<c:import url="../include/vsjscss.jsp">
</c:import>

<c:import url="../include/head.jsp">
	<c:param name="title" value="Related Objects" />
	<c:param name="javascript">
		<script type="text/javascript"
			src="<c:url value='/js/mediaelement/mediaelement-and-player.min.js' />"></script>
		<script type="text/javascript">
			$(function() {
				$("video, audio").mediaelementplayer();
			});
		</script>

	</c:param>
	<c:param name="css">
	
		<link rel="stylesheet" type="text/css" media="screen"
			href="<c:url value='/js/mediaelement/mediaelementplayer.min.css' />" />
	</c:param>
</c:import>
<script src="http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6"></script>

<script src="http://maps.google.com/maps/api/js?sensor=false"></script>


<style>
.sigma {
	border-style: solid;
	border-color: #000000;
	border-width: 5pt;
}
</style>
<style>
div,p {
	font-family: Verdana, Arial, sans-serif;
}

p.content {
	font-size: 12px;
	width: 30em;
}

div#help {
	font-size: 12px;
	width: 45em;
	padding: 1em;
}

div#timemap {
	border-style: solid;
	border-color: #000000;
	border-width: 2pt;
	height: 505px;
}

div#timelinecontainer {
	width: 100%;
	height: 0px;
}

div#timeline {
	overflow: scroll;
	width: 100%;
	height: 200px;
	font-size: 12px;
	background: #CCCCCC;
}

div#mapcontainer {
	width: 100%;
	height: 300px;
}

div#map {
	position: relative;
	width: 100%;
	height: 300px;
	background: #EEEEEE;
}

div.infotitle {
	font-size: 14px;
	font-weight: bold;
}

div.infodescription {
	font-size: 14px;
	font-style: italic;
}

div.custominfostyle {
	font-family: Georgia, Garamond, serif;
	font-size: 1.5em;
	font-style: italic;
	width: 20em;
}
</style>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						//Sleep(3);

					});

	function Sleep(T) {
		var d1 = new Date().getTime();
		var d2 = new Date().getTime();
		while (d2 < d1 + 1000 * T) { //T秒待つ 
			d2 = new Date().getTime();
		}
		return;
	}
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
					<h1 class="page-header">Related Objects</h1>

				</div>
			</div>



			<div class="row">
				<div class="col-lg-3">
					<div class="panel panel-primary">
						<div class="panel-heading">Edit and Continue</div>
						<div class="panel-body">
							<div class="partsInfo" style="color: navy">
								<div id="opbox" class="dparts nineTable">
									<div class="parts">
										<c:choose>
											<c:when
												test="${item.author.id eq userId && fromcreated && item.relogItem==null}">
												<button class="btn btn-primary"
													onclick="location.href='<c:url value="/item/${item.id}/edit"/>'">Return
													to edit</button>
												<button class="btn btn-info"
													onclick="location.href='<c:url value="/item/${item.id}" />'">Continue</button>
											</c:when>
											<c:otherwise>
												<button style="width: 100%"
													onclick="location.href='<c:url value="/item/${item.id}" />'">Return</button>
											</c:otherwise>
										</c:choose>
									</div>
								</div>

							</div>


							<div id="memberImageBox_30" class="parts memberImageBox">
								<c:choose>
									<c:when test="${fileType eq 'image'}">
										<p class="photo">
											<a id="itemImage" class="zoom" href="#itemImageZoom"> <img
												alt=""
												src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png"
												style="width:100%" />
											</a>
										</p>
										<!--  <div id="itemImageZoom">
											<img alt=""
												src="${staticserverUrl}/${projectName}/${item.image.id}_800x600.png" />
										</div>-->
										<p class="text"></p>
										<!-- <div class="moreInfo">
											<ul class="moreInfo">
												<li><a class="zoom" href="#itemImageZoom">Zoom in</a></li>
											</ul>
										</div>-->
									</c:when>
									<c:when test="${fileType eq 'video'}">
										<p class="photo">
											<video id="itemvideo" class="video" width="240px" controls=""
												preload="auto"
												poster="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png"
												style="background-color: black">
												<source
													src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.mp4"></source>
											</video>
										</p>
									</c:when>
									<c:when test="${fileType eq 'audio'}">
										<audio controls style="width: 240px">
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}.mp3" />
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}.ogg" />
										</audio>
									</c:when>
									<c:when test="${fileType eq 'pdf'}">
										<p class="photo">
											<a id="itemImage"
												href="${staticserverUrl}/${projectName}/${item.image.id}.pdf">
												<img alt=""
												src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png"
												width="240px" />
											</a>
										</p>
									</c:when>
									<c:otherwise>
										<p class="photo">
											<img style="width:100%" alt=""
												src="<c:url value="/images/no_image.gif" />" />
										</p>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>



					<div class="panel panel-primary">
						<div class="panel-heading">Information & Map</div>
						<div class="panel-body">
							
								

										<table style="width:100%">
											<tr>
												<th>Title</th>
												<td><c:choose>
														<c:when test="${empty item.titles}">
                                                        NO NAME
                                                    </c:when>
														<c:otherwise>
															<table>
																<c:forEach items="${item.titles}" var="title">
																	<tr>
																		<td style="width: 70px;">${title.language.name}</td>
																		<td>${title.content}</td>
																	</tr>
																</c:forEach>
															</table>
														</c:otherwise>
													</c:choose></td>
											</tr><!--  
											<tr>
												<th><label for="tag1">ID</label></th>
												<td>
													<table>
														<tr>
															<td style="width: 70px;">Barcode</td>
															<td>${item.barcode}</td>
														</tr>
														<tr>
															<td>QR Code</td>
															<td>${item.qrcode}</td>
														</tr>
														<tr>
															<td>RFID</td>
															<td>${item.rfid}</td>
														</tr>
													</table>
												</td>
											</tr>-->
											<tr>
												<th>Author</th>
												<td ><c:choose>
														<c:when test="${empty item.relogItem}">
															<a 
																href="<c:url value="/item"><c:param name="username" value="${item.author.nickname}" /></c:url>"><c:out
																	value="${item.author.nickname}" /></a>
														</c:when>
														<c:otherwise>
															<a href="<c:url value="/item/${item.relogItem.id}" />">ReLog</a> from <a
																href="<c:url value="/item"><c:param name="username" value="${item.relogItem.author.nickname}" /></c:url>"><c:out
																	value="${item.relogItem.author.nickname}" /></a>
														</c:otherwise>
													</c:choose></td>
											</tr>
											<tr>
												<th>Created at</th>
												<td><fmt:formatDate type="both" dateStyle="short"
														timeStyle="short" value="${item.createTime}" /></td>
											</tr>
											<tr>
												<th>Updated at</th>
												<td><fmt:formatDate type="both" dateStyle="short"
														timeStyle="short" value="${item.updateTime}" /></td>
											</tr>
											<tr>
												<th>Date of<br /> photo
												</th>
												<td></td>
											</tr>
											<tr>
												<th>Comment</th>
												<%
													pageContext.setAttribute("newLineChar", "\n");
												%>
												<td>${fn:replace(item.note,newLineChar,'<br />')}</td>
											</tr>
											<tr>
												<th>Tags</th>
												<td><c:forEach items="${item.itemTags}" var="tag">
														<a
															href="<c:url value="/item"><c:param name="tag" value="${tag.tag}" /></c:url>">${tag.tag}</a> &nbsp;
                                                    </c:forEach></td>
											</tr>
										</table>
								


						
							<c:if
								test="${!empty item.itemLat && !empty item.itemLng && !empty item.itemZoom}">
								<div id="mapbox" class="dparts TagsParts">
									<div class="parts">

										<table>
											<tr>
												<td><center>
													<div id="map" style="height: 200px;width:80%">
														<img
															src="http://maps.google.com/maps/api/staticmap?size=260x200&sensor=false&center=${item.itemLat},${item.itemLng}zoom=${item.itemZoom}&mobile=true&markers=${item.itemLat},${item.itemLng}" />
													</div></center>
												</td>
											</tr>
										
										</table>
									</div>
								</div>
							</c:if>


						</div>
					</div>

				</div>
				<c:url value="/item/${item.id}/delete" var="itemresourcedelete" />
				<form:form id="itemDeleteForm" method="post"
					action="${itemresourcedelete}" />
				<c:url value="/item/${item.id}/relog" var="relogUrl" />
				<form:form id="itemRelogForm" method="post" action="${relogUrl}" />
				<c:url value="/item/${item.id}/teacherconfirm"
					var="teacherConfirmUrl" />
				<form:form id="teacherConfirmForm" action="${teacherConfirmUrl}"
					method="post" />
				<c:url value="/item/${item.id}/teacherreject" var="teacherRejectUrl" />
				<form:form id="teacherRejectForm" action="${teacherRejectUrl}"
					method="post" />
				<c:url value="/item/${item.id}/teacherdelcfmstatus"
					var="teacherDelCfmUrl" />
				<form:form id="teacherDelCfmStatusForm" action="${teacherDelCfmUrl}"
					method="post" />
				<div class="col-lg-4">
					<div class="panel panel-primary">
						<div class="panel-heading">Related Objects</div>
						<div class="panel-body">
							<div class="partsInfo" style="color: navy">
								<div id="profile" class="dparts searchResultList">
									<c:if test="${!empty relatedItemList.result}">
										<div class="parts">
											
											<div class="block">
												<c:forEach items="${relatedItemList.result}" var="item">
													<c:set var="privateFlg" value="false" />
													<c:if
														test="${item.shareLevel=='PRIVATE' && userId!=item.author.id}">
														<c:set var="privateFlg" value="true" />
													</c:if>
													<div class="ditem">
														<div class="item">
															<table>
																<tbody>
																	<tr>
																		<td rowspan="5" class="photo"><c:choose>
																				<c:when test="${!privateFlg}">
																					<a href="<c:url value="/item/${item.id}" />"
																						target="_blank"> <c:choose>
																							<c:when test="${(empty item.image)}">
																								<img height="70px" alt=""
																									src="<c:url value="/images/no_image.gif" />" />
																							</c:when>
																							<c:otherwise>
																								<img height="70px" alt=""
																									src="${staticserverUrl}/${projectName}/${item.image.id}_160x120.png" />
																							</c:otherwise>
																						</c:choose>
																					</a>
																					<br />
																					<a href="<c:url value="/item/${item.id}" />"
																						target="_blank">Details<img alt="photo"
																						src="<c:url value="/images/icon_camera.gif" />" /></a>
																				</c:when>
																				<c:otherwise>
																					<img height="70px" alt=""
																						src="<c:url value="/images/locked.png" />"
																						title="Private" />
                                                                        		Details<img
																						alt="photo"
																						src="<c:url value="/images/icon_camera.gif" />" />
																				</c:otherwise>
																			</c:choose></td>
																		<th>Title</th>
																		<td><c:choose>
																				<c:when test="${empty item.titles}">
                                                                            NO NAME
                                                                        </c:when>
																				<c:otherwise>
																					<table>
																						<c:forEach items="${item.titles}" var="title">
																							<tr>
																								<td style="width: 70px;">${title.language.name}</td>
																								<td>${title.content}</td>
																							</tr>
																						</c:forEach>
																					</table>
																				</c:otherwise>
																			</c:choose></td>
																	</tr>
																	<tr>
																		<th>Author</th>
																		<td><a
																			href="<c:url value="/item"><c:param name="username" value="${item.author.nickname}" /></c:url>"
																			target="_blank"> <c:out
																					value="${item.author.nickname}" />
																		</a> <c:if test="${!empty item.relogItem}">
                                                                            &nbsp;(<a
																					href="<c:url value="/item/${item.relogItem.id}" />"
																					target="_blank">ReLog</a> from <a
																					href="<c:url value="/item"><c:param name="username" value="${item.relogItem.author.nickname}" /></c:url>"
																					target="_blank"><c:out
																						value="${item.relogItem.author.nickname}" /></a>)
                                                                        </c:if>
																		</td>
																	</tr>
																	<tr>
																		<th>Create</th>
																		<td><fmt:formatDate type="both" dateStyle="full"
																				timeStyle="short" value="${item.createTime}" /></td>
																	</tr>
																	<tr>
																		<th>Update</th>
																		<td><fmt:formatDate type="both" dateStyle="full"
																				timeStyle="short" value="${item.updateTime}" /></td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
												</c:forEach>
											</div>
										</div>
									</c:if>

								</div>
							</div>
						</div>
					</div>


				</div>
				<div class="col-lg-4">
					<div class="panel panel-primary">
						<div class="panel-heading">Nearest Objects</div>
						<div class="panel-body">
							<div class="partsInfo" style="color: navy">
								<c:if test="${!empty nearestItems.result}">
									<div class="parts">

										<div class="block">
											<c:forEach items="${nearestItems.result}" var="item">
												<c:set var="privateFlg" value="false" />
												<c:if
													test="${item.shareLevel=='PRIVATE' && userId!=item.author.id}">
													<c:set var="privateFlg" value="true" />
												</c:if>
												<div class="ditem">
													<div class="item">
														<table>
															<tbody>
																<tr>
																	<td rowspan="5" class="photo"><c:choose>
																			<c:when test="${!privateFlg}">
																				<a href="<c:url value="/item/${item.id}" />"
																					target="_blank"> <c:choose>
																						<c:when test="${(empty item.image)}">
																							<img height="70px" alt=""
																								src="<c:url value="/images/no_image.gif" />" />
																						</c:when>
																						<c:otherwise>
																							<img height="70px" alt=""
																								src="${staticserverUrl}/${projectName}/${item.image.id}_160x120.png" />
																						</c:otherwise>
																					</c:choose>
																				</a>
																				<br />
																				<a href="<c:url value="/item/${item.id}" />"
																					target="_blank">Details<img alt="photo"
																					src="<c:url value="/images/icon_camera.gif" />" /></a>
																			</c:when>
																			<c:otherwise>
																				<img height="70px" alt=""
																					src="<c:url value="/images/locked.png" />"
																					title="Private" />
                                                                        		Details<img
																					alt="photo"
																					src="<c:url value="/images/icon_camera.gif" />" />
																			</c:otherwise>
																		</c:choose></td>
																	<th>Name</th>
																	<td><c:choose>
																			<c:when test="${empty item.titles}">
                                                                            NO NAME
                                                                        </c:when>
																			<c:otherwise>
																				<table>
																					<c:forEach items="${item.titles}" var="title">
																						<tr>
																							<td style="width: 70px;">${title.language.name}</td>
																							<td>${title.content}</td>
																						</tr>
																					</c:forEach>
																				</table>
																			</c:otherwise>
																		</c:choose></td>
																</tr>
																<tr>
																	<th>Author</th>
																	<td><a
																		href="<c:url value="/item"><c:param name="username" value="${item.author.nickname}" /></c:url>"
																		target="_blank"> <c:out
																				value="${item.author.nickname}" />
																	</a> <c:if test="${!empty item.relogItem}">
                                                                            &nbsp;(<a
																				href="<c:url value="/item/${item.relogItem.id}" />"
																				target="_blank">ReLog</a> from <a
																				href="<c:url value="/item"><c:param name="username" value="${item.relogItem.author.nickname}" /></c:url>"
																				target="_blank"><c:out
																					value="${item.relogItem.author.nickname}" /></a>)
                                                                        </c:if>
																	</td>
																</tr>
																<tr>
																	<th>Created time</th>
																	<td><fmt:formatDate type="both" dateStyle="full"
																			timeStyle="short" value="${item.createTime}" /></td>
																</tr>
																<tr>
																	<th>Updated time</th>
																	<td><fmt:formatDate type="both" dateStyle="full"
																			timeStyle="short" value="${item.updateTime}" /></td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
								</c:if>


							</div>
						</div>
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




</html>