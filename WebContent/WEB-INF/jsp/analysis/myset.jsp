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
						<h1 class="page-header">
							My goal Setting <small>Please decide your JP goal</small>
						</h1>

					</div>
				</div>


				<div class="row">
					<div class="col-lg-4">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">Check Test</h3>
							</div>
							<div class="panel-body">

								<c:url value="/mysetting/mygoal" var="mygoalurl" />
								<form:form commandName="setting" action="${mygoalurl}"
									method="post">

									<div class="alert alert-info">Japanese Language
										Proficiency Test Vocabularies</div>
									<table>
										<tr>
											<td><form:radiobutton name="n1" path="n1" value="1" id="jpradio"
													style="margin-top:-5px" /></td>
											<td><label>&nbsp;Level 1 very easy (The number of words: 753)</label></td>
										</tr>
										<tr>
											<td><form:radiobutton name="n1" path="n1" value="2" id="jpradio"
													style="margin-top:-5px" /></td>
											<td><label>&nbsp;Level 2 easy (The number of words: 3694)</label></td>
										</tr>
										<tr>
											<td><form:radiobutton name="n1" path="n1" value="3" id="jpradio"
													style="margin-top:-5px" /></td>
											<td><label>&nbsp;level 3 difficult (The number of words: 3983)</label></td>
										</tr>
										<tr>
											<td><form:radiobutton name="n1" path="n1" value="4" id="jpradio"
													style="margin-top:-5px" /></td>
											<td><label>&nbsp;Level 4 very difficult (The number of words: 6176)</label></td>
										</tr>
									</table>
									<br>
									
									<br>
									
									<div class="alert alert-info">Please select place where you prefer </div>
									<form:select id="placeselect" path="g_totalword" style="width:260px;height:28px;margin-top:2px;margin-left:20px">
																<form:option value="Please select place" />
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
															</form:select>
									<br>
									<br>
									
									<div class="alert alert-info">Please select time zone when you prefer </div>
									<form:select id="timeselect" path="g_totalword" style="width:260px;height:28px;margin-top:2px;margin-left:20px">
																<form:option value="Please select time zone" />
																<form:option value="Morning" />
																<form:option value="Daytime"  />
																<form:option value="Night"  />
															
															
															</form:select>
									<br>
									<br>
									
									
									
									<!--
									<div class="alert alert-info">Please select the number of
										words that you want to challenge for one day</div>
								  
									<form:select path="g_oneword"
										style="margin-left:20px; width:260px">
										<form:option value=""
											label="Please select the number of
										words for one day" />
										<form:option value="5" label="5" />
										<form:option value="10" label="10" />
										<form:option value="15" label="15" />
										<form:option value="20" label="20" />
										<form:option value="25" label="25" />
										<form:option value="30" label="30" />
										<form:option value="35" label="35" />
										<form:option value="40" label="40" />
										<form:option value="45" label="45" />
										<form:option value="50" label="50" />

									</form:select>-->
									<br>
									<input type="button" value="Check" class="btn btn-info" onClick="Check()"
										style="width: 100px; margin-left: 20px; margin-top: 20px" />
								
								</form:form>



								

							</div>
						</div>
					</div>
					
					<div class="col-lg-4">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">setting</h3>
							</div>
							<div class="panel-body">

								<c:url value="/mysetting/mygoal" var="mygoalurl" />
								<form:form commandName="setting" action="${mygoalurl}"
									method="post">

									<div class="alert alert-info">Japanese Language
										Proficiency Test Vocabularies</div>
										<table>
										<tr>
											<td><form:radiobutton name="n1" path="n1" value="1" id="jpradio"
													style="margin-top:-5px" /></td>
											<td><label>&nbsp;Level 1 very easy (The number of words: 753)</label></td>
										</tr>
										<tr>
											<td><form:radiobutton name="n1" path="n1" value="2" id="jpradio"
													style="margin-top:-5px" /></td>
											<td><label>&nbsp;Level 2 easy (The number of words: 3694)</label></td>
										</tr>
										<tr>
											<td><form:radiobutton name="n1" path="n1" value="3" id="jpradio"
													style="margin-top:-5px" /></td>
											<td><label>&nbsp;level 3 difficult (The number of words: 3983)</label></td>
										</tr>
										<tr>
											<td><form:radiobutton name="n1" path="n1" value="4" id="jpradio"
													style="margin-top:-5px" /></td>
											<td><label>&nbsp;Level 4 very difficult (The number of words: 6176)</label></td>
										</tr>
									</table>
									<br>
									<div class="alert alert-info">Please select learning time
										in total of goals</div>
									<form:select path="g_totaltime"
										style="margin-left:20px; width:260px;height:28px">
										<form:option value=""
											label="Please select learning time
										in total of goals" />
										<form:option value="1" label="1 day" />
										<form:option value="2" label="2 day" />
										<form:option value="3" label="3 day" />
										<form:option value="4" label="4 day" />
										<form:option value="5" label="5 day" />
										<form:option value="6" label="6 day" />
										<form:option value="7" label="7 day" />
										<form:option value="8" label="8 day" />
										<form:option value="9" label="9 day" />
										<form:option value="10" label="10 day" />
										<form:option value="11" label="11 day" />
										<form:option value="12" label="12 day" />

									</form:select>
									<br>
									<br>
									<div class="alert alert-info">Please select learning time
										of goals for one day</div>
									<form:select path="g_onetime"
										style="margin-left:20px; width:260px;height:28px">
										<form:option value=""
											label="Please select learning time
										of goals for one day" />
										<form:option value="30" label="30 minute" />
										<form:option value="60" label="60 minute" />
										<form:option value="90" label="90 minute" />
										<form:option value="120" label="120 minute" />
										<form:option value="150" label="150 minute" />
										<form:option value="180" label="180 minute" />
										<form:option value="210" label="210 minute" />
										<form:option value="240" label="240 minute" />
										<form:option value="270" label="270 minute" />
										<form:option value="300" label="300 minute" />
										<form:option value="330" label="330 minute" />
										<form:option value="360" label="360 minute" />

									</form:select>
									<br>
									<br>
									<div class="alert alert-info">Please select the number of
										words that you want to challenge</div>
									<form:select path="g_totalword"
										style="margin-left:20px; width:260px;height:28px">
										<form:option value=""
											label="Please select the number of
										words" />
										<form:option value="10" label="10" />
										<form:option value="20" label="20" />
										<form:option value="30" label="30" />
										<form:option value="40" label="40" />
										<form:option value="50" label="50" />
										<form:option value="60" label="60" />
										<form:option value="70" label="70" />
										<form:option value="80" label="80" />
										<form:option value="90" label="90" />
										<form:option value="100" label="100" />
										<form:option value="150" label="150" />
										<form:option value="200" label="200" />
										<form:option value="300" label="300" />
									</form:select>
									<br>
									<br>
						
									
									
									
									<!--
									<div class="alert alert-info">Please select the number of
										words that you want to challenge for one day</div>
								  
									<form:select path="g_oneword"
										style="margin-left:20px; width:260px">
										<form:option value=""
											label="Please select the number of
										words for one day" />
										<form:option value="5" label="5" />
										<form:option value="10" label="10" />
										<form:option value="15" label="15" />
										<form:option value="20" label="20" />
										<form:option value="25" label="25" />
										<form:option value="30" label="30" />
										<form:option value="35" label="35" />
										<form:option value="40" label="40" />
										<form:option value="45" label="45" />
										<form:option value="50" label="50" />

									</form:select>-->
							
									<input type="submit" value="Setting" class="btn btn-info"
										style="width: 100px; margin-left: 20px; margin-top: 20px" />
								</form:form>



								

							</div>
						</div>
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
