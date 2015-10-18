<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!doctype html>
<html>
<c:import url="../include/vsjscss.jsp">
</c:import>
    <c:import url="../include/head.jsp">
        <c:param name="title" value="Edit object" />
        <c:param name="content">
            <style>
                .titleLangName{
                    width:70px;
                }
                .titleMap{
                    width:60%;
                }
                #titleTable button{
                    width:30%;
                }
            </style>
            <link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/js/mediaelement/mediaelementplayer.min.css' />" />
            <script src="<c:url value='/js/mediaelement/mediaelement-and-player.min.js' />"></script>
            <script src="http://www.google.com/jsapi"></script>
            <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
            <script src="<c:url value='/js/LLMap.js' />"></script>
            <script>
                $(function(){
                    $("video, audio").mediaelementplayer();
                });
            </script>
            <script>
                function translateTitle(code){
                    var translateTitleUri = "<c:url value='/api/translate/itemTitle' />";
                    var titles = "{";
                    $.each($(".titleMap"),function(i, item){
                        titles+=$(item).attr("lang")+":\""+$(item).val()+"\"";
                        if(i<$(".titleMap").length-1)titles+=",";
                    });
                    titles+="}";
                    var inputdata={ 'target':code, 'titles': titles};
                    $.get(translateTitleUri,inputdata ,function(data){
                        $("#inputTitle_"+code).val(data);
                    });
                }
                
                function addLangTitle(){
                    var code = $("#addLangSelect").val();
                    var name = $("#addLangSelect").find("option:selected").text();
                    $("<tr><td class=\"titleLangName\">"+name+"</td><td><input name=\"titleMap['"+code+"']\" id=\"inputTitle_"+code+"\" class=\"titleMap\" lang=\""+code+"\" />&nbsp;<button onclick=\"translateTitle('"+code+"');return false;\">Translate</button></td></tr>").appendTo($("#titleTable"));
                    $("#addLangSelect option[value='"+code+"']").remove();
                }
                
                var map;
                $(function(){
                	<c:choose>
                	<c:when test="${(empty item.itemLng) || (empty item.itemLat) || (empty item.itemZoom)}">
                    map = new LLMap("map", {
                        onchange:function(lat, lng, zoom){
                            $("#itemLat").val(lat);
                            $("#itemLng").val(lng);
                            $("#itemZoom").val(zoom);
                        }
                    });
                    </c:when>
                    <c:otherwise>
                    map = new LLMap("map", {
                    	lat: ${item.itemLat},
                    	lng: ${item.itemLng},
                    	zoom: ${item.itemZoom},
                        onchange:function(lat, lng, zoom){
                            $("#itemLat").val(lat);
                            $("#itemLng").val(lng);
                            $("#itemZoom").val(zoom);
                        }
                    });
                    </c:otherwise>
                    </c:choose>
                    
                    $("#generateQrcode").click(function(){
                        if($("#qrcode").val()!=""){
                            if(!confirm("Generate a new QR code?")){
                                return;
                            }
                        }
                        $.get("<c:url value="/api/qrcode/generate" />", function(data){
                            $("#qrcode").val(data);
                            $("#qrcodeArea").html("<img src=\"http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl=learninglog://item?qrcode="+data+"\"/>");
                        });
                        return false;
                    });
                    $("#clearQrcode").click(function(){
                        $("#qrcode").val("");
                        $("#qrcodeArea").html("");
                       });
                    $("#printQrcode").click(function(){
                        $.get("<c:url value="/api/qrcode/generate" />", function(data){
                            $("#qrcode").val(data);
                            $("#qrcodeArea").html("<img src=\"http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl=learninglog://item?qrcode="+data+"\"/>");
                            window.open("<c:url value='/qrcodeprint?content=' />"+$("#qrcode").val(),"", "height=170, width=170" );
                        });
                    });
                    $("#qrcode").change(function(){
                        if($.trim($("#qrcode").val())==""){
                            $("#qrcodeArea").html("");
                            return;
                        }
                        $("#qrcodeArea").html("<img src=\"http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl=learninglog://item?qrcode="+$("#qrcode").val()+"\"/>");
                    });
                });
            </script>
        </c:param>
    </c:import>
    <script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("mylog").className = "active";

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
						<h1 class="page-header">Edit</h1>

					</div>
				</div>



				<div class="row">
				
					<div class="col-lg-4">
					
						<div class="panel panel-primary">
						<div class="panel-heading">
							<div class="row">
								<div class="col-xs-3"></div>


							</div>
						</div>

						<div class="panel-footer">
					<div id="memberImageBox_30" class="parts memberImageBox" style="text-align:center">
                                <c:choose>
                                    <c:when test="${fileType eq 'image'}">
                                        <p class="photo">
                                            <a id="itemImage" class="zoom" href="#itemImageZoom">
                                               <img alt="" src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png" width="240px" />
                                            </a>
                                        </p>
                                        <p class="text"></p>
                                        <div class="moreInfo">
                                        </div>
                                    </c:when>
                                    <c:when test="${fileType eq 'video'}">
                                        <video id="itemvideo" class="video"
                                            width="240px" controls preload
                                            poster="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png"
                                            style="background-color:black"
                                            onclick="this.play();"/>
                                            <source src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.mp4"></source>
                                        </video>
                                    </c:when>
                                    <c:when test="${fileType eq 'audio'}">
                                            <audio controls style="width:240px">
                                                <source src="${staticserverUrl}/${projectName}/${item.image.id}.mp3" />
                                                <source src="${staticserverUrl}/${projectName}/${item.image.id}.ogg" />
                                            </audio>
                                    </c:when>
                                    <c:when test="${fileType eq 'pdf'}">
                                        <p class="photo">
                                            <a id="itemImage" href="${staticserverUrl}/${projectName}/${item.image.id}.pdf">
                                               <img alt="" src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png" width="240px" />
                                            </a>
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="photo">
                                            <img width="240px" alt="" src="<c:url value="/images/no_image.gif" />" />
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                                </div>
					  <c:url value="/item/${item.id}/edit" var="itemresource" />
                            <form:form commandName="form"  action="${itemresource}" method="post">
                                <div id="Center">
                                    <div id="profile" class="dparts listBox">
                                        <div class="parts">
                                             <div class="navbar navbar-inner" style="position: static;">
									<div class="navbar-primary">
                                                <h3 style="font-size: 14px; font-weight: bolder; line-height: 150%">Edit Information</h3>
                                            </div></div>
                                            <strong>*</strong> Required.
                                            <c:url value="/item/${item.id}" var="itemUrl" />
                                            <table>
                                            <!-- 
                                                <tr>
                                                    <th><label for="shareLevel">Share Level</label></th>
                                                    <td>
                                                        <form:select path="shareLevel">
                                                            <form:option value="PUBLIC" label="Public" />
                                                            <form:option value="PRIVATE" label="Private" />
                                                        </form:select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th><label for="category">Category</label></th>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${empty user.myCategoryList}">
                                                                <a href="<c:url value="/mysetting" />" target="_blank">Please set your categories in Setting.</a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form:select path="categoryId">
                                                                    <form:option value="" label="Select category" />
                                                                    <c:forEach items="${user.myCategoryList}" var="cat">
                                                                      <form:option value="${cat.id}" label="${cat.name}" />
                                                                    </c:forEach>                                                            
                                                                </form:select>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                -->
                                                   <tr>
                                                    <th><label for="setting">Setting</label></th>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td style="width:80px;">Share Level</td>
                                                                <td style="width:120px;">
                                                                    <form:select path="shareLevel" cssStyle="width:90%" >
                                                                        <form:option value="PUBLIC" label="Public" />
                                                                        <form:option value="PRIVATE" label="Private" />
                                                                    </form:select>
                                                                </td>
                                                                  <td style="width:60px;">Category</td>
                                                                <td>
                                                                    <c:choose>
                                                            <c:when test="${empty user.myCategoryList}">
                                                                <a href="<c:url value="/mysetting" />" target="_blank">Please set your categories in Setting.</a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form:select path="categoryId">
                                                                    <form:option value="" label="Select" />
                                                                    <c:forEach items="${user.myCategoryList}" var="cat">
                                                                      <form:option value="${cat.id}" label="${cat.name}" />
                                                                    </c:forEach>                                                            
                                                                </form:select>
                                                            </c:otherwise>
                                                        </c:choose>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th><label for="quiztype">Options</label></th>
                                                    <td style="margin-top:5px">
                                                        <c:forEach items="${questionTypes}" var="qestype">
                                                            <form:checkbox path="questionTypeIds" value="${qestype.id}" />&nbsp;${qestype.title}&nbsp;&nbsp;
                                                        </c:forEach>   
                                                        <form:checkbox path="locationBased" />&nbsp;Location Based&nbsp;&nbsp;
                                                    </td>
                                                </tr>
                                                <tr >
                                                    <th style="width: 80px;margin-top:50px">Title</th>
                                                    <td  style="margin-top:15px">
                                                        <table id="titleTable">
                                                            <c:forEach items="${langs}" var="lang">
                                                                <tr>
                                                                    <td style="margin-top:10px"  class="titleLangName">${lang.name}</td>
                                                                    <td>
                                                                        <form:input style="margin-top:10px" path="titleMap['${lang.code}']" id="inputTitle_${lang.code}" cssClass="titleMap" lang="${lang.code}" />&nbsp;<button class="btn btn-success" onclick="translateTitle('${lang.code}');return false;" >Translate</button>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </table>
                                                        <div>
                                                            <select id="addLangSelect">
                                                                <c:forEach items="${langList}" var="lang">
                                                                <c:if test="${!langs.contains(lang)}"><option style="margin-top:10px"  id="addLang_${lang.code}" value="${lang.code}">${lang.name}</option></c:if>
                                                                </c:forEach>
                                                            </select>
                                                            <button style="margin-top:10px"   class="btn btn-danger" onclick="addLangTitle();return false;">Add</button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                 </table>
                                             Description
                                                    <form:textarea path="note" cols="20" rows="4" cssStyle="width:98%;margin-top:10px" />
                                            
                                                <!-- 
                                                <tr>
                                                    <th><label for="tag1">ID</label></th>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td style="width:70px;">Barcode</td>
                                                                <td><form:input path="barcode" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>QR Code</td>
                                                                <td>
                                                                    <form:input path="qrcode" id="qrcode" />
                                                                     <button class="btn btn-primary" id="printQrcode" onclick="return false;">Print</button>
                                                                    <button class="btn btn-info" id="clearQrcode" onclick="return false;">Clear</button>
                                                                    <div id="qrcodeArea"></div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>RFID</td>
                                                                <td><form:input path="rfid" /></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th rowspan="2">Place</th>
                                                    <td>
                                                        <form:input path="place" cssClass="input_text" id="place" />
                                                    </td>
                                                </tr>-->
                                                
                                         
                                                        <form:hidden path="itemLat" id="itemLat"/>
                                                        <form:hidden path="itemLng" id="itemLng"/>
                                                        <form:hidden path="itemZoom" id="itemZoom"/>
                                                        <center>
                                                        <div id="map" style="height: 300px;width:90%;margin-top:20px">
                                                        </div></center>
                                               
                                               <label for="question" style="margin-top:20px">Question</label>
                                                       <form:textarea path="question" cssStyle="width:98%;height:50px;" />
                                                       Ask: <form:select style="margin-top:10px" path="quesLan" items="${langList}" itemValue="code" itemLabel="name" />
                                                 
                                           
                                        </div>
                                        <div class="operation">
                                            <ul class="moreInfo button">
                                                <li>
                                                    <input type="submit" class="btn btn-primary" value="Edit" style="margin-top:10px"/>
                                                </li><br>
                                                <li>
                                                    <a href="<c:url value="/item/${item.id}" />" style="margin-top:10px">Return to Object List</a>
                                                </li>
                                            </ul>
                                            <br><br><br>
                                        </div>
                                    </div><!-- dparts -->
                                </div>
                            </form:form>
					</div>
					</div></div>
					<div class="col-lg-4">
					
					</div>
				</div>


				<!-- /.row -->

			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- /#page-wrapper -->

	</div>




</html>
