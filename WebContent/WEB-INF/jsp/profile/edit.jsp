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

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Jan 2000 00:00:00 GMT">

<title>VASCORLL</title>

<!-- Bootstrap Core CSS -->

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Jan 2000 00:00:00 GMT">

<title>VASCORLL</title>
<c:import url="../include/vsjscss.jsp">
</c:import>

<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("mygoalsetting").className = "active";
	});
</script>


</head>

<script>

function Check(){
	
		var ddl = document.getElementById("placeselect");
		var selected = ddl.options[ddl.selectedIndex].value;
		var ddl2 = document.getElementById("timeselect");
		var selected2 = ddl2.options[ddl2.selectedIndex].value;
		console.log($('input[id="jpradio"]:checked').val());
		console.log(selected);
		console.log(selected2);
		
		location.href="<c:url value="/quiz/quiztest?"/>"+"jp="+$('input[id="jpradio"]:checked').val()+"&place="+selected+"&time="+selected2;


	
}

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

		</nav>

		<div id="page-wrapper">

			<div class="container-fluid">

				<!-- Page Heading -->
				<div class="row">
					<div class="col-lg-12">
						<h1 class="page-header">My status setting</h1>

					</div>
				</div>


				<div class="row">
					<div class="col-lg-3">
						<div id="memberImageBox_22" class="parts memberImageBox">

							<p class="photo">
								<c:choose>
									<c:when test="${empty user.avatar}">
										<img alt="LearningUser"
											src="<c:url value="/images/no_image.gif" />" height="180"
											width="180" />
									</c:when>
									<c:otherwise>
										<img alt="LearningUser"
											src="<c:url value="${staticserverUrl}/${projectName}/${user.avatar.id}_320x240.png" />"
											height="180" />
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
						</div>


					</div>

					<div class="col-lg-9">
					
					<c:url value="/profile/edit" var="profileEditFormUrl" />
							<form:form modelAttribute="form" action="${profileEditFormUrl}"
								method="post">
								<input type="hidden" name="userid" value="${user.id}" />
								<strong>*</strong>&nbsp;Required。
                                            <table>
									<tr>
										<th><label for="pcEmail">PC E-mail:</label></th>
										<td>${user.pcEmail}</td>
									</tr>
									<tr>
										<th><label for="nickname">Nickname</label> <strong>*</strong></th>
										<td><form:input path="nickname" cssClass="input_text"
												id="nickname" style="height:30px" /> <form:errors
												path="nickname" cssClass="error" /></td>
									</tr>
									<tr>
										<th><label for="firstName">First name</label></th>
										<td><form:input path="firstName" style="height:30px" />
											<form:errors path="firstName" cssClass="error" /></td>
									</tr>
									<tr>
										<th><label for="lastName">Last name</label></th>
										<td><form:input path="lastName" style="height:30px" /> <form:errors
												path="lastName" cssClass="error" /></td>
									</tr>
									<tr>
										<th><label for="interesting">Interests</label></th>
										<td><form:textarea rows="2" cols="30" path="interesting"
												id="interesting" />
											<div>
												<form:errors path="interesting" cssClass="error" />
											</div></td>
									</tr>

									<c:forEach begin="0" end="1" var="myLangsIndex"
										varStatus="status">
										<tr>
											<th><label for="myLangs[${status.index}]">Native
													language&nbsp;${status.count}</label> <c:if
													test="${status.index eq 0}">
													<strong>*</strong>
												</c:if></th>
											<td><form:select path="myLangs[${myLangsIndex}]">
													<option value="">-Please select-</option>
													<form:options items="${langList}" itemValue="code"
														itemLabel="name" />
												</form:select> <form:errors path="myLangs[${myLangsIndex}]"
													cssClass="error" /></td>
										</tr>
									</c:forEach>


									<c:forEach begin="0" end="1" var="studyLangsIndex"
										varStatus="st">
										<tr>
											<th><label for="studyLangs[${st.index}]">Language
													of study&nbsp;${st.count}</label> <c:if test="${0 eq st.index}">
													<strong>*</strong>
												</c:if></th>
											<td><form:select path="studyLangs[${st.index}]">
													<option value="">-Please select-</option>
													<form:options items="${langList}" itemValue="code"
														itemLabel="name" />
												</form:select> <form:errors path="studyLangs[${st.index}]"
													cssClass="error" /></td>
										</tr>
									</c:forEach>

									<tr>
										<th><label for="age">Age</label></th>
										<td><form:select path="age">
												<option value="">-Please select-</option>
												<form:option value="10~20" label="10~20" />
												<form:option value="21~30" label="21~30" />
												<form:option value="31~40" label="31~40" />
												<form:option value="41~50" label="41~50" />
												<form:option value="51~60" label="51~60" />
											</form:select></td>
									</tr>
									<tr>
										<th><label for="gender">Gender</label></th>
										<td><form:select path="gender">
												<option value="">-Please select-</option>
												<form:option value="man" label="man" />
												<form:option value="woman" label="woman" />

											</form:select></td>
									</tr>

									<tr>
										<th><label for="nationality">* Plaese confirm your native language</label></th>
										<td><form:select path="nationality">
												<option value="">-Please select-</option>
												<form:option value="Afrikaans" label="Afrikaans" />
												<form:option value="Amharic" label="Amharic" />
												<form:option value="Armenian" label="Armenian" />
												<form:option value="Basque" label="Basque" />
												<form:option value="Bengali" label="Bengali" />
												<form:option value="Bulgarian" label="Bulgarian" />
												<form:option value="Catalan" label="Catalan" />
												<form:option value="Cherokee" label="Cherokee" />
												<form:option value="Czech" label="Czech" />
												<form:option value="Dhivehi" label="Dhivehi" />
												<form:option value="estonian" label="estonian" />
												<form:option value="Finnish" label="Finnish" />
												<form:option value="Galician" label="Galician" />
												<form:option value="German" label="German" />
												<form:option value="Greek" label="Greek" />
												<form:option value="Gujarati" label="Gujarati" />

												<form:option value="Hindi" label="Hindi" />
												<form:option value="Indonesian" label="Indonesian" />
												<form:option value="Kazakh" label="Kazakh" />
												<form:option value="Korean" label="Korean" />
												<form:option value="Kurdish" label="Kurdish" />
												<form:option value="Laothian" label="Laothian" />
												<form:option value="Latvian" label="Latvian" />
												<form:option value="Lithuanian" label="Lithuanian" />
												<form:option value="Malayalam" label="Malayalam" />
												<form:option value="Marathi" label="Marathi" />
												<form:option value="Mongolian" label="Mongolian" />
												<form:option value="Norwegian" label="Norwegian" />
												<form:option value="Persian" label="Persian" />
												<form:option value="Portuguese" label="Portuguese" />
												<form:option value="Romanian" label="Romanian" />
												<form:option value="Sanskrit" label="Sanskrit" />

												<form:option value="Sindhi" label="Sindhi" />
												<form:option value="Slovenian" label="Slovenian" />
												<form:option value="Swahili" label="Swahili" />
												<form:option value="Swedish" label="Swedish" />
												<form:option value="Tamil" label="Tamil" />
												<form:option value="Thai" label="Thai" />
												<form:option value="Turkish" label="Turkish" />
												<form:option value="Urdu" label="Urdu" />
												<form:option value="Uighua" label="Uighua" />
												<form:option value="Welsh" label="Welsh" />
												<form:option value="Albanian" label="Albanian" />
												<form:option value="Arabic" label="Arabic" />
												<form:option value="Azerbaijani" label="Azerbaijani" />
												<form:option value="Belarusian" label="Belarusian" />
												<form:option value="Bihari" label="Bihari" />
												<form:option value="Burmese" label="Burmese" />

												<form:option value="Croatian" label="Croatian" />
												<form:option value="Danish" label="Danish" />
												<form:option value="Dutch" label="Dutch" />
												<form:option value="Esperanto" label="Esperanto" />
												<form:option value="Tagalog" label="Tagalog" />
												<form:option value="French" label="French" />
												<form:option value="Georgian" label="Georgian" />
												<form:option value="Guarani" label="Guarani" />
												<form:option value="Hebrew" label="Hebrew" />
												<form:option value="Hungarian" label="Hungarian" />
												<form:option value="Icelandic" label="Icelandic" />
												<form:option value="Inuktitut" label="Inuktitut" />
												<form:option value="Irish" label="Irish" />
												<form:option value="Italian" label="Italian" />
												<form:option value="Kannada" label="Kannada" />
												<form:option value="Khmer" label="Khmer" />

												<form:option value="Kyrgyz" label="Kyrgyz" />
												<form:option value="Macedonian" label="Macedonian" />
												<form:option value="Malay" label="Malay" />
												<form:option value="Maltese" label="Maltese" />
												<form:option value="Nepali" label="Nepali" />
												<form:option value="Oriya" label="Oriya" />
												<form:option value="Pashto" label="Pashto" />
												<form:option value="Polish" label="Polish" />
												<form:option value="Punjabi" label="Punjabi" />
												<form:option value="Russian" label="Russian" />
												<form:option value="Serbian" label="Serbian" />
												<form:option value="Sinhalese" label="Sinhalese" />
												<form:option value="Slovak" label="Slovak" />
												<form:option value="Spanish" label="Spanish" />
												<form:option value="Tajik" label="Tajik" />
												<form:option value="Telugu" label="Telugu" />


												<form:option value="Tibetan" label="Tibetan" />
												<form:option value="Ukranian" label="Ukranian" />
												<form:option value="Uzbek" label="Uzbek" />
												<form:option value="Vietnamese" label="Vietnamese" />
												<form:option value="Yiddish" label="Yiddish" />
												<form:option value="English" label="English" />
												<form:option value="Japanese" label="Japanese" />
												<form:option value="Chinese" label="Chinese" />


											</form:select></td>
									</tr>
									<tr>
										<th><label for="stay">Length of stay</label></th>
										<td><form:select path="stay">
												<option value="">-Please select-</option>
												<form:option value="1" label="1 years" />
												<form:option value="2" label="2 years" />
												<form:option value="3" label="3 years" />
												<form:option value="4" label="4 years" />
												<form:option value="5" label="5 years" />
												<form:option value="6" label="6 years" />
												<form:option value="7" label="7 years" />
												<form:option value="8" label="8 years" />
												<form:option value="9" label="9 years" />
												<form:option value="10" label="10 years" />
											</form:select></td>
									</tr>
									<tr>
										<th><label for="j_level">Japanese Language
												Proficiency Test</label></th>
										<td><form:select path="j_level">
												<option value="">-Please select-</option>
												<form:option value="1" label="Level 1 (N5)" />
												<form:option value="2" label="Level 2 (N4)" />
												<form:option value="3" label="Level 3 (N3 & N2)" />
												<form:option value="4" label="Level 4 (N1)" />
												<form:option value="none" label="None" />
											</form:select></td>
									</tr>
								</table>
								<div class="operation">
									<ul class="moreInfo button">
										<li><center>
												<input type="submit" class="btn btn-block btn-primary"
													value="Update" style="width: 75px" />
											</center></li>
										<br>
										<li><a class="btn" href="<c:url value="/profile" />">Return</a>
										</li>
									</ul>
								</div>
							</form:form>
					
					</div>


				</div>
				<!-- /.row -->


				<!-- /.row -->

			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- /#page-wrapper -->

	</div>


</body>

</html>

