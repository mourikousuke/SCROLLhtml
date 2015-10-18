<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="userId">
	<shiro:principal property="id" />
</c:set>
<!doctype html>
<html>
<c:import url="../include/vsjscss.jsp">
</c:import>
<c:import url="../include/head.jsp">
	<c:param name="title" value="オブジェクト" />
	<c:param name="javascript">
		<script
			src="<c:url value="/js/jQuery.jPlayer.2.0.0/jquery.jplayer.min.js" />"></script>
		<script src="<c:url value="/js/jquery/jquery.linkify-1.0-min.js"/>"></script>
		<script
			src="<c:url value='/js/mediaelement/mediaelement-and-player.min.js' />"></script>
		<script type="text/javascript"
			src="http://connect.facebook.net/en_US/all.js"></script>
		<script>
                $(function(){
                	$("video, audio").mediaelementplayer();
                    $(".description").linkify();
                });

                function speak(title, lang){
                	$("#ttsTitleArea").html("<div id=\"ttsTitle\"></div>");
                	$('#ttsTitle').jPlayer({
                		ready:function(){
                        	$('#ttsTitle').jPlayer("setMedia", {
            					mp3: "<c:url value="/api/translate/tts" />?ie=UTF-8&lang="+lang+"&text="+encodeURIComponent(title)
            				}).jPlayer("play");
                		},
                		ended: function(){
                			$("#ttsTitle").jPlayer("destroy");
                			$("#ttsTitleArea").html("");
                		},
                		swfPath:"<c:url value="/js/jQuery.jPlayer.2.0.0" />",
                		supplied: "mp3"
                	});
                }
            </script>
		<script
			src="<c:url value="/js/jquery/stars/jquery.ui.stars.min.js" />"></script>
		<script>
                <c:choose>
                    <c:when test="${ratingExist}">
                        $(function(){
                            $("#rat").children().not("select, #messages").hide();
                            $("#rating_title").text("Rating");
                            var $caption = $('<div id="caption"/>');
                            $("#rat").stars({
                                inputType: "select",
                                cancelShow: false,
                                disabled: true
                            });
                            $("#rat").stars("select", Math.round(${avg}));
                            var $caption = $('<div id="caption"/>');
                            $caption.text(" (" + ${votes} + " votes; " + ${avg} + ")");
                            $caption.appendTo("#rat");
                        });
                    </c:when>
                    <c:otherwise>
                        $(function(){
                            $("#rat").children().not("select, #messages").hide();
                            var $caption = $('<div id="caption"/>');
                            $("#rat").stars({
                                inputType: "select",
                                cancelShow: false,
                                captionEI: $("#caption"),
                                oneVoteOnly: true,
                                callback: function(ui,type,value){
                                    ui.disable();
                                    $("#messages").text("Saving...").stop().css("opacity", 1).fadeIn(30);

                                    $.post("<c:url value="/itemrating/${item.id}?format=json" />", {rate: value}, function(json){
                                        $("#rating_title").text("Rating");
                                        ui.select(Math.round(json.avg));
                                        $caption.text(" (" + json.votes + " votes; " + json.avg + ")");
                                        $("#messages").text("Rating saved (" + value + "). Thanks!").stop().css("opacity", 1).fadeIn(30);
                                        setTimeout(function(){
                                            $("#messages").fadeOut(1000);
                                        }, 2000);
                                    }, "json");
                                }
                            });
                            $("#rat").stars("selectID", -1);
                            $caption.appendTo("#rat");
                            $('<div id="messages"/>').appendTo("#rat");
                        });
                    </c:otherwise>
                </c:choose>
            </script>
		<script src="${baseURL}/js/jquery/jquery.nyroModal.custom.min.js"></script>
		<!--[if IE 6]>
				<script type="text/javascript" src="${baseURL}/js/jquery/jquery.nyroModal-ie6.min.js"></script>
			<![endif]-->
		<script>
	            $(function() {
	            	  function preloadImg(image) {
	            	    var img = new Image();
	            	    img.src = image;
	            	  }

	            	  preloadImg('${baseURL}/images/ajaxLoader.gif');
	            	  preloadImg('${baseURL}/images/prev.gif');
	            	  preloadImg('${baseURL}/images/next.gif');
	            	  preloadImg('${baseURL}/images/close.gif');
	            	  $('.nyroModal').nyroModal();
            	});
            </script>


		<!-- facebook post -->
		<script type="text/javascript">
FB.init({
appId:'338738616232992', cookie:true,
status:true, xfbml:true, oauth:true
});

function post_result(element_id) {
    FB.login(function(res) {
        if (res.session || res.authResponse) {
            var area = document.getElementById(element_id);
            FB.api('/me/feed', 'post', {
                message: '${item.defaultTitle} について学習しました。',
                source: 'http://ll.artsci.kyushu-u.ac.jp/learninglog/images/favicon.png',
                caption: 'SCROLLは日常生活で学習したことを記録・共有して更なる学習に役立てます。',
                link: 'http://ll.artsci.kyushu-u.ac.jp/learninglog/item/${item.id}',
                name: 'SCROLL - ${item.defaultTitle}'
            }, function(response) {
              if (!response || response.error) {
                alert('投稿できませんでした。 ' + response.error.message);
              } else {
                alert('投稿しました。 Post ID: ' + response.id);
              }
            });
        }
    }, { scope: 'publish_stream' })
}
</script>


	</c:param>
	<c:param name="css">
		<link rel="stylesheet" type="text/css" media="screen"
			href="${baseURL}/js/jquery/stars/jquery.ui.stars.min.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="${baseURL}/js/mediaelement/mediaelementplayer.min.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="${baseURL}/css/nyroModal.css" />
	</c:param>
</c:import>
<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("alllog").className = "active";

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
					<h1 class="page-header">Log Information</h1>

				</div>
			</div>



			<div class="row">
				<div class="col-lg-3">
					<div class="panel panel-primary">
						<div class="panel-heading">
				         Image & Location
						</div>
						<div class="panel-body">

							<div id="relatedBox" class="dparts nineTable">
								<div class="parts">
									<button style="width: 100%" class="btn btn-primary"
										onclick="window.location='<c:url value='/item/${item.id}/related' />'">Related
										Objects</button>
								</div>
								<!-- parts -->
							</div>
							<!-- dparts -->
							<div id="memberImageBox_30" class="parts memberImageBox"
								style="text-align: center">
								<c:choose>
									<c:when test="${fileType eq 'image'}">
										<p class="photo">
											<a id="itemImage" class="nyroModal"
												href="${staticserverUrl}/${projectName}/${item.image.id}_800x600.png">
												<img alt=""
												src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png"
												style="width: 100%; height: 300px" />
											</a>
										</p>
										<p class="text"></p>
									</c:when>
									<c:when test="${fileType eq 'video'}">
										<video id="itemvideo" width="240" height="100%"
											controls="controls" preload="none"
											poster="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png">
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.mp4"></source>
										</video>
									</c:when>
									<c:when test="${fileType eq 'audio'}">
										<audio controls="controls" style="width: 240">
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}.mp3"></source>
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}.ogg"></source>
										</audio>
									</c:when>
									<c:when test="${fileType eq 'pdf'}">
										<p class="photo">
											<a id="itemImage"
												href="${staticserverUrl}/${projectName}/${item.image.id}.pdf">
												<img alt=""
												src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png"
												style="width: 100%" />
											</a>
										</p>
									</c:when>
									<c:otherwise>
										<p class="photo">
											<img width="100%" alt=""
												src="<c:url value="/images/no_image.gif" />" />
										</p>
									</c:otherwise>
								</c:choose>
							</div>
							<!-- parts -->
							<c:if
								test="${!empty item.itemLat && !empty item.itemLng && !empty item.itemZoom}">
								<div id="mapbox" class="dparts nineTable">
									<div class="parts">


										<div id="map" style="height: 100%; width: 100%">
											<img
												src="http://maps.google.com/maps/api/staticmap?size=260x200&sensor=false&center=${item.itemLat},${item.itemLng}zoom=${item.itemZoom}&mobile=true&markers=${item.itemLat},${item.itemLng}"
												width="100%" height="250" />
										</div>

										<c:if test="${!empty item.place}">
														
																Place：${item.place}
															
														</c:if>

									</div>
									<!-- parts -->
								</div>
								<!-- dparts -->
							</c:if>

						</div>
					</div>


				</div>
				<div class="col-lg-5">
					<div class="panel panel-primary">
						<div class="panel-heading">
							Information
							<c:if test="${item.author.id eq userId}">
								<c:if test="${item.relogItem==null}">
                                                    &nbsp;<a
										href="<c:url value="/item/${item.id}/edit" />"><font
										color="red">Edit</font></a>
								</c:if>
                                                &nbsp;<a href="#"
									onclick="if(confirm('Delete it?'))$('#itemDeleteForm').submit()"><font
									color="red">Delete</font></a>
                                                &nbsp;<!--<button onclick="javascript:post_result()" style="background:none; border:0"><IMG src="<c:url value="/images/fb.png"/>" width="60" height="30" border="0"></button>-->
							</c:if>
						</div>
						<div class="panel-body">


							<div id="profile" class="dparts listBox">
								<div class="parts">

									<c:if test="${relogable}">
										<div
											style="position: relative; float: right; top: -5px; right: 150px;">
											<input style="position: absolute" type="image"
												src="<c:url value="/images/relog.png" />"
												onclick="$('#itemRelogForm').submit();" />
										</div>
									</c:if>
								
									<c:if test="${categoryPath!=null}">
										<div style="font-weight: bold; color: gray">
											Top
											<c:forEach items="${categoryPath}" var="cat">
                                           		&gt;&nbsp;${cat.name}
                                           	</c:forEach>
										</div>
									</c:if>
									<table>
										<c:if test="${item.teacherConfirm!=null}">
											<tr>
												<th></th>
												<td><c:choose>
														<c:when test="${item.teacherConfirm}">
															<span
																style="color: green; font-size: 16px; font-weight: bolder">Teacher
																Confirmed</span>
														</c:when>
														<c:otherwise>
															<span
																style="color: red; font-size: 16px; font-weight: bolder">Corrections
																needed</span>
														</c:otherwise>
													</c:choose></td>
											</tr>
										</c:if>
										<tr>
											<th id="rating_title" style="margin-top: 10px">Rate this</th>
											<td style="margin-top: 10px"><span id="caption"></span>
												<form id="rat" action="" method="post">
													<select id="itemrating">
														<option value="1">Not so good</option>
														<option value="2">Good</option>
														<option value="3">Quite ggood</option>
														<option value="4">Great!</option>
														<option value="5">Excellent!</option>
													</select> <input type="submit" value="Rate it!" />
												</form></td>
										</tr>
										<c:if test="${itemState != nulll}">
											<tr>
												<th id="exper_title">States</th>
												<td><c:if test="${itemState.experState == 1 }">
														<img class="tooltip" title="experienced"
															src="<c:url value="/images/experienced.png" />"
															width="30px" />
													</c:if> <c:if test="${itemState.rememberState == 1 }">
														<img class="tooltip" title="remembered"
															src="<c:url value="/images/remembered.png" />"
															width="30px" />
													</c:if></td>
											</tr>
										</c:if>
										<tr>
											<th style="margin-top: 25px">Title</th>
											<td style="margin-left: 10px">
												<div id="ttsTitleArea" style="height: 0; width: 0"></div>
												<table>
													<c:forEach items="${item.titles}" var="title">
														<tr>
															<td style="width: 100px">${title.language.name}</td>
															<td><button
																	onclick="speak('${title.content}','${title.language.code}');return false;">
																	<img src="<c:url value='/images/speaker.png' />" />
																</button>&nbsp;<c:out value="${title.content}" /></td>
														</tr>
													</c:forEach>
												</table>
											</td>
										</tr>
										<tr>
											<th>Description</th>
											<%
												pageContext.setAttribute("newLineChar", "\n");
											%>
											<td class="description">
												${fn:replace(item.note,newLineChar,'<br />')}</td>
										</tr>
										<c:if
											test="${!empty item.barcode || !empty item.qrcode || !empty item.rfid}">
											<tr>
												<th><label for="tag1">ID</label></th>
												<td>
													<table>
														<c:if test="${!empty item.barcode}">
															<tr>
																<td style="width: 70px;">Barcode</td>
																<td>${item.barcode}</td>
															</tr>
														</c:if>
														<c:if test="${!empty item.qrcode}">
															<tr>
																<td>QR Code</td>
																<td><c:if test="${!empty item.qrcode}">
																		<img
																			src="http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl=${systemUrl}/instant/item?qrcode=${item.qrcode}" />
																	</c:if></td>
															</tr>
														</c:if>
														<c:if test="${!empty item.rfid}">
															<tr>
																<td>RFID</td>
																<td>${item.rfid}</td>
															</tr>
														</c:if>
													</table>
												</td>
											</tr>
										</c:if>
										<tr>
											<th>Author</th>
											<td style="margin-left: 10px"><c:choose>
													<c:when test="${empty item.relogItem}">
														<a class="userlink" data-uid="${item.author.id}"
															data-uname="${item.author.nickname}"
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
											<th>Created</th>
											<td style="margin-left: 10px"><fmt:formatDate
													type="both" pattern="yyyy/MM/dd HH:mm"
													value="${item.createTime}" /></td>
										</tr>
										<tr>
											<th>Updated</th>
											<td style="margin-left: 10px"><fmt:formatDate
													type="both" pattern="yyyy/MM/dd HH:mm"
													value="${item.updateTime}" /></td>
										</tr>
										<tr>
											<th>Place</th>
											<td style="margin-left: 10px">${placeinfo.place}</td>
										</tr>
										<tr>
											<th>Tags</th>
											<td style="margin-left: 10px"><c:forEach
													items="${item.itemTags}" var="tag">
													<a
														href="<c:url value="/item"><c:param name="tag" value="${tag.tag}" /></c:url>">${tag.tag}</a> &nbsp;
                                                    </c:forEach></td>
										</tr>
									</table>
									
										
									<c:if test="${adminflag=='1'}">
										<div
											style="float: right;">
											<input type="image"
												src="<c:url value="/images/remembered.png" />"
												onclick="$('#itemImportanceForm').submit();" />
										</div>
									</c:if>
								</div>
							</div>
							<!-- dparts -->


						</div>
					</div>




				</div>
				<div class="col-lg-4">

					<div class="panel panel-primary">
						<div class="panel-heading">Post a comment</div>
						<div class="panel-body">

							<c:if test="${!empty item.question}">
								<c:url value="/item/${item.id}/questionconfirm"
									var="questionConfirmUrl" />
								<form action="${questionConfirmUrl}" method="post"
									id="questionConfirmForm"></form>
								<div class="dparts homeRecentList">
									<div class="parts">
										<div class="partsHeading">
											Question
											<c:if
												test="${item.questionResolved !=null && item.questionResolved}">
                                                    &nbsp;<span
													style="color: red; font-weight: bold">(Resolved)</span>
											</c:if>
											<c:if
												test="${item.author.id == userId && item.question!=null && (item.questionResolved==null || item.questionResolved == false) && item.question.answerSet!=null && fn:length(item.question.answerSet)>0}">
												<button onclick="$('#questionConfirmForm').submit();">Confirm</button>
											</c:if>
										</div>
										<div class="block">
											<form action="<c:url value="/item/${item.id}/question" />"
												method="post">
												<table>
													<tr>
														<th style="width: 70px;"><label for="tag1">Question</label></th>
														<td>${item.question.content}</td>
													</tr>
													<c:forEach items="${item.question.answerSet}" var="answer">
														<tr>
															<td>${answer.author.nickname}&nbsp;</td>
															<td>${answer.answer} &nbsp;</td>
														</tr>
													</c:forEach>
													<tr>
														<th>Answer</th>
														<td><textarea name="content" style="width: 350px;"></textarea>
														</td>
													</tr>
													<tr>
														<th colspan="2"><input type="submit" value="Submit" />
														</th>
													</tr>
												</table>
											</form>
										</div>
									</div>
								</div>
							</c:if>
							<div class="new-share-info">
								<span>Read (<strong>${readCount}</strong>)
								</span><span>ReLog (<strong>${relogCount}</strong>)
								</span>
							</div>
							<c:if test="${fn:length(item.commentList)>0}">
								<div class="dparts commentList">
									<div class="parts">

										<c:forEach items="${item.commentList}" var="comment">
											<dl>
												<dt>
													<c:choose>
														<c:when test="${empty comment.user.avatar}">
															<img alt="LearningUser"
																src="<c:url value="/images/no_image.gif" />" width="60"
																height="60" />
														</c:when>
														<c:otherwise>
															<img alt="LearningUser"
																src="${staticserverUrl}/${projectName}/${comment.user.id}_320x240.png"
																width="60" />
														</c:otherwise>
													</c:choose>
												</dt>
												<dd>
													<div class="title">
														${comment.user.nickname} &nbsp; (
														<fmt:formatDate value="${comment.createTime}" type="both"
															dateStyle="long" timeStyle="medium" />
														)
													</div>
													<div class="body">
														<c:out value="${comment.comment}" />
													</div>
												</dd>
											</dl>
										</c:forEach>
									</div>
								</div>
							</c:if>
						

									
										<form action="<c:url value="/item/${item.id}/comment" />"
											method="post">
											<table style="width:100%">
												<tr style="margin-left:30px">
													<th ><label for="tag1">Tag</label></th>
													<td style="margin-left:10px"><input type="text" name="tag" style="width:100%; margin-top:10px" /></td>
												</tr>
												<tr style="margin-top:30px">
													<th style="margin-top:30px">Comment</th>
													<td style="margin-top:30px"><textarea cols="20" rows="4" name="comment" style="width:100%; margin-top:20px"></textarea>
													</td>
												</tr>
											</table>
											<div class="operation">
												<ul class="moreInfo button">
													<li><input type="submit" value="Save"
														class="btn btn-info" /></li>
												</ul>
											</div>
										</form>
									
										<ul class="articleList">
										</ul>
										<div class="moreInfo">
											<ul class="moreInfo">
												<li><a href="<c:url value="/item" />">Return to
														Object List</a></li>
											</ul>
										</div>
									
							
						</div>
					</div>
					
					 <c:url value="/item/${item.id}/delete" var="itemresourcedelete" />
                            <form:form id="itemDeleteForm" method="post" action="${itemresourcedelete}" />
                            <c:url value="/item/${item.id}/relog" var="relogUrl" />
                            <form:form id="itemRelogForm" method="post" action="${relogUrl}" />
                            <c:url value="/item/${item.id}/teacherconfirm" var="teacherConfirmUrl" />
                            <form:form id="teacherConfirmForm" action="${teacherConfirmUrl}" method="post"/>
                            <c:url value="/item/${item.id}/teacherreject" var="teacherRejectUrl" />
                            <form:form id="teacherRejectForm" action="${teacherRejectUrl}" method="post"/>
                            <c:url value="/item/${item.id}/teacherdelcfmstatus" var="teacherDelCfmUrl" />
                            <form:form id="teacherDelCfmStatusForm" action="${teacherDelCfmUrl}" method="post"/>
                            <c:url value="/item/${item.id}/importance" var="importance" />
                            <form:form id="itemImportanceForm" action="${importance}" method="post"/>
				</div>
			</div>


			<!-- /.row -->

		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- /#page-wrapper -->

</div>


<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("alllog").className = "active";

	});
</script>
<c:import url="../include/Slidermenu.jsp" />

</html>
