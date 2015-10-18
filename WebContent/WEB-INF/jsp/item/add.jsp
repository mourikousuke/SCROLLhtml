<%@page contentType="text/html" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<style>
.optional {
	display: none
}
</style>

		<script src="<c:url value='/js/LLMap.js' />"></script>
				<c:import url="../include/vsjscss.jsp">
			</c:import>
			 <script src="http://www.google.com/jsapi"></script>
            <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
		   <script>
	
                function translateTitle(code){
                    var translateTitleUri = "${baseURL}/api/translate/itemTitle";
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

                function translateQuestion(){
                    var translateTitleUri = "${baseURL}/api/translate/text";
                    var inputdata={ 'src': $("#transFrom").val(), 'dest':$("#transTo").val(), 'text': $("#question").val()};
                    $.get(translateTitleUri,inputdata ,function(data){
                        $("#question").val($("#question").val()+"{"+data+"}");
                    });
                }
                
                var map;
                $(function(){
                	map = new LLMap("map", {
                		onchange:function(lat, lng, zoom){
                			$("#itemLat").val(lat);
                			$("#itemLng").val(lng);
                			$("#itemZoom").val(zoom);
                		}
                	});
                	
                	$(document).on("change", "#addLangSelect", function(){
                        var code = $("#addLangSelect").val();
                        if(code==null && code==-1)return;
                        var name = $("#addLangSelect").find("option:selected").text();
                        $("<tr><td class=\"titleLangName\">"+name+"</td><td><input name=\"titleMap['"+code+"']\" id=\"inputTitle_"+code+"\" class=\"titleMap\" lang=\""+code+"\" />&nbsp;<button onclick=\"translateTitle('"+code+"');return false;\">Translate</button></td></tr>").appendTo($("#titleTable"));
                        $("#addLangSelect option[value='"+code+"']").remove();
                        if($("#addLangSelect option").length<=1){
                            $("#addLangSelect").parent().hide();
                        }
                	}).on("click", "#showMoreButton",function(){
                		if($(".optional:first").is(":hidden")){
                			$(".optional").show();
                			$("#showMoreButton").text("Hide Details");
                		}else{
                			$(".optional").hide();
                			$("#showMoreButton").text("Show Details");
                		}
                	}).on("click", "#generateQrcode", function(){
                        if($("#qrcode").val()!=""){
                            if(!confirm("Generate a new QR code?")){
                                return;
                            }
                        }
                        $.get("<c:url value="/api/qrcode/generate" />", function(data){
                            $("#qrcode").val(data);
                            $("#qrcodeArea").html("<img src=\"http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl="+data+"\"/>");
                        });
                        return false;
                    }).on("click", "#clearQrcode", function(){
                        $("#qrcode").val("");
                        $("#qrcodeArea").html("");
                    }).on("click", "#printQrcode", function(){
                        $.get("<c:url value="/api/qrcode/generate" />", function(data){
                            $("#qrcode").val(data);
                            $("#qrcodeArea").html("<img src=\"http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl="+data+"\"/>");
                            window.open("<c:url value='/qrcodeprint?content=' />"+$("#qrcode").val(),"", "height=170, width=170" );
                        });
                    }).on("change", "#qrcode", function(){
                        if($.trim($("#qrcode").val())==""){
                            $("#qrcodeArea").html("");
                            return;
                        }
                        $("#qrcodeArea").html("<img src=\"http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl="+$("#qrcode").val()+"\"/>");
                    });
                });
            </script>
            


		<script type="text/javascript">
        function getUrlVars()
        {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for(var i = 0; i <hashes.length; i++)
            {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }
	    
	    $(document).ready(function() {
	    	var vars = getUrlVars();
	    	if (vars["langlist"] === void 0) return ;
	   		var lang = vars["langlist"].split("|");
	    	$.each(lang, function(i, val){
		    	if (vars[val+"_title"] !== void 0) {
		    		$("#inputTitle_"+val).val(decodeURI(vars[val+"_title"]));
		    	}
	    	});
	    });
	    </script>

<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("addull").className = "active";
		
	
		
	});
</script>

<script type="text/javascript">

	$(function() {
		$('#boldadd').click(
				function(e) {

					//document.getElementById("descriptionform").innerHTML = "_$ttest_$t_$ta";
					var info = document.getElementById("descriptionform");
					var tarea  = document.getElementById("msg");
					//var textNode = document
					//		.createTextNode('<b>'+tarea.value+'</b>');

					info.value +='<b>'+tarea.value+'</b>';
					//info.appendChild(textNode);
					//		document.getElementById("descriptionform").appendChild(element);

				});
		
		$('#underlineadd').click(
				function(e) {

					//document.getElementById("descriptionform").innerHTML = "_$ttest_$t_$ta";
					var info = document.getElementById("descriptionform");
					var tarea  = document.getElementById("underline");
					var textNode = document
							.createTextNode('<u>'+tarea.value+'</u>');

					//textNode.id="descriptionform";
					//info.appendChild(textNode);
					info.value +='<u>'+tarea.value+'</u>';
					
					//		document.getElementById("descriptionform").appendChild(element);

				});

		$('#linkingadd').click(
				function(e) {

					//document.getElementById("descriptionform").innerHTML = "_$ttest_$t_$ta";
					var info = document.getElementById("descriptionform");
					var tarea  = document.getElementById("linking");
					var lname  = document.getElementById("linkingname");
					var link = document.createElement('a');
					//link.href= tarea.value;
					//var textNode = document
					//		.createTextNode('<a href='+'"'+tarea.value+'">'+lname.value+'</a>');
					info.value+='<a href='+'"'+tarea.value+'">'+lname.value+'</a>';
					//info.appendChild(textNode);
					//		document.getElementById("descriptionform").appendChild(element);

				});


	});
	



	function myLocation(locationReturned) {
	}
</script>

<script language="javascript" type="text/javascript">
	function boldadd() {
		var info = document.getElementById("descriptionform");
		var tarea = document.getElementById("msg");
		var textNode = document.createTextNode('_$t' + tarea.value + '_$t_$ta');

		info.appendChild(textNode);
</script>


<style>
div.ditem {
	padding: -10px -10px;
}

.searchResultList .ditem {
	margin: 10px 0;
}

div.partsInfo {
	padding: 5px 20px;
}

div.partsInfo div.body {
	margin: 10px 0;
}

div.parts,div.dparts {
	margin: 0 auto 10px;
	clear: both;
}

div.dparts div.parts {
	margin: 0;
}

.form .block {
	text-align: center;
	padding: 10px 1em;
}

.searchResultList .partsInfo {
	background: #EEEEEE;
}

div.pagerRelative {
	padding: 4px;
	text-align: right;
}

.searchResultList .item_block {
	background: #FFF;
	margin: 0px 1px 2px 0px;
	height: 120px;
	float: left;
	position: relative;
	top: 0;
	left: 0;
	border: 1px solid #CCC;
}

.searchResultList .item_block:hover {
	background: #FFD;
	border-color: #888;
}

.searchResultList .item_block hr {
	border: solid #000;
	border-width: 1px 0 0 0;
	margin: 2px 0;
}

.searchResultList .item_block .item_image {
	text-align: center;
	height: 70px;
	overflow: hidden;
}

.searchResultList .item_block .item_info {
	padding: 1px;
	border-top: 1px solid #CCC;
	height: 50px;
	overflow: hidden;
}

.searchResultList .item_block:hover .item_info {
	height: auto;
	border: 0;
	font-weight: bold;
	background: #FFD;
	position: absolute;
	top: 70px;
	left: 0;
	z-index: 100;
	box-shadow: 1px 1px 5px #000;
}

.searchResultList .item_block .item_hide {
	display: none;
}

.searchResultList .item_block:hover .item_hide {
	display: inline;
	font-weight: normal;
}

.item :link,.item :visited {
	color: black;
}

.item :hover {
	background: #F5F5F5;
	color: #000;
}

div.pagerRelative {
	padding: 4px;
	text-align: right;
}

div.pagerRelativeMulti {
	padding: 4px;
}

div.pagerRelative p,div.pagerRelativeMulti div.pager p {
	display: inline;
	margin-left: 10px;
}

div.pagerRelative p:first-child,div.pagerRelativeMulti div.pager p:first-child,div.pagerRelative p.first-child,div.pagerRelativeMulti div.pager p.first-child
	{
	margin-left: 0;
}

div.pagerRelativeMulti div.text {
	float: left;
}

div.pagerRelativeMulti div.pager {
	float: right;
	margin-top: 0.5em;
	text-align: right;
}

.pagerRelative {
	line-height: 20px;
	height: 20px
}

.pagerRelative a,.pagerRelative .now-page {
	padding: 1px 3px 2px 3px;
	margin: 0;
	text-align: center;
	font: normal normal normal 12px/1.6em Verdana, Helvetica, Arial,
		sans-serif;
	border: 1px solid #ccc;
	text-decoration: none
}

.pagerRelative .now-page {
	background-color: #09C;
	border-color: #09C;
	color: white;
	font-weight: 700;
}

.pagerRelative a:hover {
	border: 1px solid #c00;
	text-decoration: none
}

div.ditem {
	padding: -10px -10px;
}

div.parts table.mceToolbar {
	width: auto;
}

.searchResultList .partsInfo {
	background: #EEEEEE;
}

.searchResultList .ditem {
	margin: 8px 0;
}

.searchResultList td.photo {
	padding: 5px;
}

.searchResultList th,.searchResultList td {
	padding: 5px;
}

.searchResultList th {
	width: 90px;
}

.searchResultList tr.operation th {
	padding-top: 0;
	padding-bottom: 0;
}

.searchResultList tr.operation td {
	padding: 0;
}

.searchResultList tr.operation span.text {
	float: left;
	display: block;
	width: 180px;
	padding: 5px;
	border-right: 1px solid #CCCCCC;
}

.searchResultList tr.operation span.moreInfo {
	zoom: 1;
	display: block;
	margin-left: 121px;
	padding: 4px 0 3px;
	text-align: center;
}

.searchResultList div.operation {
	text-align: center;
}

.searchResultList tr.operation span.moreInfo img,.searchResultList div.operation form,.searchResultList div.operation fieldset
	{
	display: inline;
	vertical-align: top;
}

.searchResultList .item_block {
	background: #FFF;
	margin: 0px 1px 2px 0px;
	width: 105px;
	height: 120px;
	float: left;
	position: relative;
	top: 0;
	left: 0;
	border: 1px solid #CCC;
}

.searchResultList .item_block:hover {
	background: #FFD;
	border-color: #888;
}

.searchResultList .item_block hr {
	border: solid #000;
	border-width: 1px 0 0 0;
	margin: 2px 0;
}

.searchResultList .item_block .item_image {
	text-align: center;
	height: 70px;
	overflow: hidden;
}

.searchResultList .item_block .item_info {
	padding: 1px;
	border-top: 1px solid #CCC;
	height: 50px;
	overflow: hidden;
}

.searchResultList .item_block:hover .item_info {
	height: auto;
	border: 0;
	font-weight: bold;
	background: #FFD;
	width: 250px;
	position: absolute;
	top: 70px;
	left: 0;
	z-index: 100;
	box-shadow: 1px 1px 5px #000;
}

.searchResultList .item_block .item_hide {
	display: none;
}

.searchResultList .item_block:hover .item_hide {
	display: inline;
	font-weight: normal;
}
</style>
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
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Add ULL</h1>

				</div>
			</div>



				<div class="row">
					<div class="col-lg-6">

						<div class="panel panel-primary">
							<div class="panel-heading">
								Add new object</a>
							</div>
							<div class="panel-body">

								<c:url value="/item" var="itemUrl" />
								<form:form commandName="item" action="${itemUrl}" method="post"
									enctype="multipart/form-data">
									<strong>*</strong>&nbsp;Required.
                                            <button style="float: right"
										id="showMoreButton" onclick="return false;"
										class="btn btn-primary">Show Details</button>
									<table style="width: 100%">
										<tr class="optional">
											<th><label for="setting">Setting</label></th>
											<td>
												<table>
													<tr style="width:100%">
														<td><form:select path="shareLevel" style="margin-top:10px">
																<form:option value="PUBLIC" label="Public" />
																<form:option value="PRIVATE" label="Private" />
															</form:select></td>
														
														<td><c:choose>
																<c:when test="${empty user.myCategoryList}">
																	<a href="<c:url value="/mysetting" />" target="_blank">Set
																		categories</a>
																</c:when>
																<c:otherwise>
																	<form:select path="categoryId"  style="margin-top:10px">
																		<form:option value="" label="Select category" />
																		<c:forEach items="${user.myCategoryList}" var="cat">
																			<form:option value="${cat.id}" label="${cat.name}" />
																		</c:forEach>
																	</form:select>
																</c:otherwise>
															</c:choose></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr class="optional">
											<th><label for="quiztype">Quiz Options</label></th>
											<td>
												<ul style="width:100%">
													<c:forEach items="${questionTypes}" var="qestype">
														<li style="width:100%"><form:checkbox path="questionTypeIds"
																value="${qestype.id}" checked="true" /><label>&nbsp;${qestype.title}</label></li>
													</c:forEach>
													<li style="width:100%"><form:checkbox path="locationBased" /><label>&nbsp;Location
															Based</label></li>
												</ul>
											</td>
										</tr>
									</table>
									<table style="width: 100%">
										<tr style="width: 100%; float: left">

											<td>
												<table style="margin-top: 10px">
													<c:forEach items="${langs}" var="lang">
														<tr>
															<td>${lang.name}</td>
															<td><form:input path="titleMap['${lang.code}']"
																	id="inputTitle_${lang.code}" cssClass="titleMap"
																	lang="${lang.code}" placeholder="Language input"
																	style="width:100%;margin-top:2px;margin-left:10px" /></td>
															<td>
																<button
																	onclick="translateTitle('${lang.code}');return false;"
																	class="btn btn-success"
																	style="margin-top: 5px; width: 100%">Translate</button>
															</td>
														</tr>
													</c:forEach>
												</table>
												<div>
													<select id="addLangSelect" style="margin-top: 20px">
														<option value="-1">--Add a new language--</option>
														<c:forEach items="${langList}" var="lang">
															<c:if test="${!langs.contains(lang)}">
																<option id="addLang_${lang.code}" value="${lang.code}">${lang.name}</option>
															</c:if>
														</c:forEach>
													</select>
												</div>
											</td>
										</tr>

									</table>
									<table style="width: 100%;">
										<tr style="width: 100%; float: left">
											<th><label for="photo" style="margin-top: 20px">Photo|Video<br />Audio|PDF
											</label></th>
											<td><input type="file" name="image" id="image"
												class="input_file" style="margin-top:20px;margin-left:20px"/> <form:errors cssClass="error"
													path="image" /></td>
										</tr>
									</table>
									<table>
										<tr>
											<th><label for="note">Description</label></th>
											<td><form:textarea id="descriptionform"
													name="description" path="note" cols="20" rows="4"
													cssStyle="width:98%;margin-top:10px;margin-left:10px"
													placeholder="please enter up your description" />
												<button title="bold" id="link" class="btn"
													style="width: 20px;margin-top:10px;margin-left:5px" onClick="return false;"
													data-toggle="modal" data-target="#myModal">
													<i class="glyphicon glyphicon-font" style="margin-left: -6px"></i>
												</button>
												<button title="underline" id="link" class="btn"
													style="width: 20px;margin-top:10px;margin-left:5px" onClick="return false;"
													data-toggle="modal" data-target="#myModal2">
													<i class="glyphicon glyphicon-bold" style="margin-left: -6px"></i>
												</button>
												<button title="link" id="link" class="btn"
													style="width: 20px;margin-top:10px;margin-left:5px" onClick="return false;"
													data-toggle="modal" data-target="#myModal3">
													<i class=" glyphicon glyphicon-link" style="margin-left: -6px"></i>
												</button></td>
										</tr>
									</table>
									<table>
										<tr class="optional">
											<th><label for="tag1">ID</label></th>
											<td>
												<table>
													<tr>
														<td style="width: 70px;">Barcode</td>
														<td><form:input path="barcode" id="barcode" /></td>
													</tr>
													<tr>
														<td>QR code</td>
														<td><form:input path="qrcode" id="qrcode" />
															<button id="printQrcode" onclick="return false;">Print</button>
															<button id="clearQrcode" onclick="return false;">Clear</button>
															<div id="qrcodeArea"></div></td>
													</tr>
													<tr>
														<td>RFID</td>
														<td><form:input path="rfid" /></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th rowspan="2" style="margin-left:20px"><label for="place">Location</label></th>
											
											<td style="width:100%"><form:hidden path="itemLat" id="itemLat" /> <form:hidden
													path="itemLng" id="itemLng" /> <form:hidden
													path="itemZoom" id="itemZoom" />
												<div id="map" style="width: 90%; height: 350px;margin-top:30px;margin-left:20px"></div></td>
										</tr>
										
										<tr class="optional">
											<th><label for="question">Question</label></th>
											<td><form:textarea path="question" cols="30" rows="10"
													id="question" cssStyle="width:98%"></form:textarea> <select
												id="transFrom" name="transFrom">
													<c:forEach items="${langList}" var="lang">
														<option value="${lang.code}">${lang.name}</option>
													</c:forEach>
											</select> -&gt; <select id="transTo" name="transTo">
													<c:forEach items="${langList}" var="lang">
														<option value="${lang.code}">${lang.name}</option>
													</c:forEach>
											</select>
												<button id="transButton"
													onclick="translateQuestion();return false;">Translate
													Question</button></td>
										</tr>
										<tr class="optional">
											<th><label for="tag1">Tag</label></th>
											<td><input type="text" name="tag" id="tagInput" /></td>
										</tr>

									</table>
								<label for="place">Place</label>
								
								<table class="table table-striped">								
											<c:forEach items="${current}" var="obj">
									<tr><td><img src="${obj.icon}" style="width:30px;height:30px"></img></td>
										<td>
													<li><form:radiobutton name="q1"
															path="placeinformation" value="${obj.attribute}" />&nbsp;${obj.attribute}
														
															</li></td></tr>

												</c:forEach></table>
												<!--  
												<c:forEach items="${currentplace}" var="obj">

													<li><form:radiobutton name="q1"
															path="map['${obj.key}']" value="${obj.value}" /><label>&nbsp;<c:out
																value="${obj.key}" /></label></li>

												</c:forEach>
										-->
										
									<label for="inputplace">If there is no options in above </label>
								
								<table class="table table-striped">								
											
									<tr><td><form:input path="inputplace" placeholder="Place name input"
																	style="width:100%;margin-top:2px;margin-left:10px" /></td>
										<td><form:select path="inputplaceatt" style="width:100%;height:28px;margin-top:2px;margin-left:10px">
																<form:option value="Please select place attribute" />
																<form:option value="accounting" />
																<form:option value="amusement_park"  />
																<form:option value="bakery" />
																<form:option value="bank"  />
																<form:option value="beauty_salon" />
																<form:option value="book_store"  />
																<form:option value="bus_station" />
																<form:option value="cafe"  />
																<form:option value="city_hall" />
																<form:option value="clothing_store"  />
																<form:option value="convenience_store" />
																<form:option value="dentist"  />
																<form:option value="department_store" />
																<form:option value="electronics_store"  />
																<form:option value="fire_station" />
																<form:option value="hair_care"  />
																<form:option value="hardware_store" />
																<form:option value="hospital"  />
																
																<form:option value="jewelry_store" />
																<form:option value="laundry"  />
																<form:option value="lawyer" />
																<form:option value="library"  />
																<form:option value="liquor_store" />
																<form:option value="lodging"  />
																<form:option value="movie_theater" />
																<form:option value="museum"  />
																<form:option value="park" />
																<form:option value="pet_store"  />
																<form:option value="pharmacy" />
																<form:option value="post_office"  />
																<form:option value="restaurant" />
																<form:option value="school"  />
																<form:option value="shopping_mall" />
																<form:option value="stadium"  />
																<form:option value="train_station" />
																<form:option value="transit_station" />
																<form:option value="university"  />
															</form:select></td></tr>

											</table>
										
										
										
									<div class="operation">
										<ul class="moreInfo button">
											<li><input type="submit" class="btn btn-info"
												value="Save" /></li>
											<li><a href="<c:url value="/item" />">Return to
													Object List</a></li>
										</ul>
									</div>
								</form:form>

							</div>
						</div>



					</div>





				</div>
				<div class="row">
					<div class="col-lg-6"></div>
				</div>

			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->



	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="height: 300px; width: 100%">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<div id="gname">Add boldfaced type</div>
					</h4>
				</div>
				<div></div>
				<div class="modal-body">
					<form class="contact">
						<textarea id="msg" name="msg" cols=140 rows=2 style="width: 100%"></textarea>

						<button value="Join" class="btn btn-info" data-dismiss="modal"
							id="boldadd" style="width:100%">Add</button>

					</form>

				</div>

			</div>
		</div>
	</div>

	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="height: 300px; width: 100%">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<div id="gname">Add underline</div>
					</h4>
				</div>
				<div></div>
				<div class="modal-body">
					<form class="contact">
						<textarea id="underline" name="msg" cols=140 rows=2
							style="width: 520px"></textarea>

						<button value="Join" class="btn btn-info" data-dismiss="modal"
							id="underlineadd">Add</button>

					</form>

				</div>

			</div>
		</div>
	</div>

	<div class="modal fade" id="myModal3" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="height: 300px; width: 610px">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<div id="gname">Add link</div>
					</h4>
				</div>
				<div></div>
				<div class="modal-body">
					<form class="contact">
						<table>
							<tr>
								<td style="witdh: 100px">Title&nbsp;&nbsp;</td>
								<td><input type="text" id="linkingname"></input></td>
							</tr>
							<tr>
								<td>Link</td>
								<td><textarea id="linking" name="msg" cols=140 rows=1
										style="width: 420px"></textarea></td>
							</tr>
						</table>

						<button value="Join" class="btn btn-info" data-dismiss="modal"
							id="linkingadd">Add</button>

					</form>

				</div>

			</div>
		</div>
	</div>

</body>
</html>
