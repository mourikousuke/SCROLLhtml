<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!doctype html>
<html>
<c:import url="../include/Slidermenu.jsp" />
<c:import url="../include/vsjscss.jsp">
</c:import>
<c:import url="../include/head.jsp">
	<c:param name="title" value="Messages" />
	<c:param name="javascript">
		<c:url value="/usermessage/send" var="usermessagesenduri" />
		<script type="text/javascript">
        		$(function(){
        			$("#msgbox").dialog({
        				autoOpen:false,
        				modal:true
        			});
        		});
        		function showMsg(target, msgId){
        			$.post("<c:url value="/usermessage/readmessage" />",{'msgId':msgId} , function(data){
        				if(typeof(data.message)!="undefined"){
	        				refreshUnreadMsg();
	        				$(target).parent().removeClass("unreadMsg");
	        				$("#msgboxcontent").html(data.message.content.replace(/\\n/g,"<br />"));
	        				$("#msgboxreply").attr("onclick", "replyMsg('"+data.message.sendFromId+"','"+data.message.sendFromName+"')");
	        				$("#msgbox").dialog( "option", "title", "Message from "+data.message.sendFromName).dialog("open");
        				}
        			},"json");
        		}

        		function replyMsg(sendToUid, sendToUname){
        			$("#msgbox").dialog("close");
	            	$("<div id=\"usermsgdlg\"  style=\"margin-top:100px\">"
			                +"<div><form id=\"usermessageform\" action=\"#\" method=\"post\"  style=\"margin-top:100px\">"
			            	+"<input id=\"umsg_sendto\" name=\"umsg_sendto\" type=\"hidden\" value=\""+sendToUid+"\" />"
			            	+"<textarea id=\"umsg_content\" name=\"content\" style=\"width:100%;height:100%;\" rows=\"5\"></textarea>"
			            	+"<input type=\"submit\" value=\"Send\" onclick=\"sendUserMessage();return false;\"/>"
					        +"</form></div>"
					        +"</div>").dialog({
					        	title:"Send A Message To <span style=\"color:green\">"+sendToUname+"</span>",
					        	modal:true,
					        	resizable:false});
        		}
        	</script>
	</c:param>
</c:import>
<script type="text/javascript">
	___________________$tag_______$tag___$tag__$tag__$tag_______________________"
									+ sendToUname
									+ "_$tag_________
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
					<h1 class="page-header">Message</h1>

				</div>
			</div>



			<div class="row">
				<div class="col-lg-4">
					<div class="panel panel-danger">
						<div class="panel-heading">Sent Messages</div>
						<div class="panel-body">
							<ul class="articleList">
								<c:forEach items="${mysendlist}" var="mym">
									<div class="block">

										<li class="msgitem"><fmt:formatDate
												value="${mym.create_time}" type="both" dateStyle="default" />
											to ${mym.nickname}</li> ${mym.content}

									</div>
									<br>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="panel panel-info">
						<div class="panel-heading">Received Messages</div>
						<div class="panel-body">

							<div id="homeRecentList_11" class="dparts homeRecentList">
								<div class="parts">

									<div class="block">
										<ul class="articleList">
											<c:forEach items="${messageList}" var="msg">
												<li <c:if test="${!msg.readFlag}">class="unreadMsg"</c:if>><a
													class="msgitem" href="#"
													onclick="showMsg(this, '${msg.id}')"><fmt:formatDate
															value="${msg.createTime}" type="both" dateStyle="default" />
														from ${msg.sendFrom.nickname}</a></li>
											</c:forEach>
										</ul>

									</div>
								</div>
							</div>
						</div>
					</div>



					<div id="msgbox">
						<div id="msgboxcontent" style="margin-top:100px"></div>
						<button id="msgboxreply">Reply</button>
					</div>
				</div>
				<div class="col-lg-4"></div>
			</div>


		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- /#page-wrapper -->

</div>

</html>
