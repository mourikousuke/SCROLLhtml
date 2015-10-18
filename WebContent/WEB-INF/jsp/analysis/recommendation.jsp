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
<c:import url="../include/vsjscss.jsp">
</c:import>
	<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
<script type="text/javascript">
	$(document).ready(function() {
		document.getElementById("recommendation").className = "active";
    	navigator.geolocation.watchPosition(successCallback, errorCallback);
    	var place_lat = -1;
    	var place_log = -1;
    	function successCallback(position) {
    		place_lat = position.coords.latitude;

    		place_log = position.coords.longitude;
    	//	var clickElem = document.getElementById('nextpage');
//    		clickElem.href = "<c:url value="/analysis/recommendation"/>" + "?lat=" + place_lat
//    				+ "&lng=" + place_log;

    	}
    	function errorCallback(error) {
    		alert("位置情報取得できない");
    	}
    	
	

	});
</script>


</head>
<script type="text/javascript">

	

                $(function(){
                
                	var place_lat = -1;
                	var place_log = -1;
                	navigator.geolocation.watchPosition(successCallback, errorCallback);

                	function successCallback(position) {
                		place_lat = position.coords.latitude;

                		place_log = position.coords.longitude;
                	
                	}
                	function errorCallback(error) {
                		alert("位置情報取得できない");
                	}

            
                	
                	var map = new google.maps.Map(document.getElementById("searchMap"), {
                        disableDefaultUI: true,
                        scaleControl: true,
                        navigationControl: true,
                        mapTypeId: google.maps.MapTypeId.ROADMAP,
                    });
                    
                    var bounds = new google.maps.LatLngBounds();
                   // var marker;
         
                    var currentmarker;
                    currentmarker = new google.maps.Marker({position:new google.maps.LatLng(${nowlat},${nowlng}), map:map,icon:'${baseURL}/images/icon/pin_green_l.png'});
                    infowin= new google.maps.InfoWindow({
                        content: "Your current position"
                });
                    infowin.open(map, currentmarker);
                    var marker=[];
                    var infowindow=[];
	                <c:forEach items="${current}" var="item" varStatus="sta" >
	                    <c:if test="${(!empty item.lat) and (!empty item.lng)}">
	                    
                            marker[${sta.index}] = new google.maps.Marker({position:new google.maps.LatLng(${item.lat}, ${item.lng}), map:map,title:"${item.place}"});
                            infowindow[${sta.index}]= new google.maps.InfoWindow({
                                content: "${item.place}(${item.attribute})"+"<br>"+
                                '<a href="<c:url value="/analysis/recommendationout?lat=${nowlat}&lng=${nowlng}&season=${season}&timezone=${timezone}&place=${item.attribute}"/>">'+
                                "Check in"+'<i class="fa fa-arrow-circle-right"></i>'+'</a>'
                        });
                            //infowindow.open(map, marker);
                            
                            bounds.extend(marker[${sta.index}].getPosition());
                            
                            google.maps.event.addListener(infowindow[${sta.index}], "closeclick", function() {
                        	   
                        	});
                            google.maps.event.addListener(marker[${sta.index}], "click", function(event) {
                         
                    	        infowindow[${sta.index}].open(map, marker[${sta.index}]);
                    	    });
	                    </c:if>
	               </c:forEach>
	    
                   map.fitBounds(bounds);
                   google.maps.event.addListener(map, "bounds_changed", function(){
                       $('#x1').val(map.getBounds().getNorthEast().lat());
                       $('#y1').val(map.getBounds().getNorthEast().lng());
                       $('#x2').val(map.getBounds().getSouthWest().lat());
                       $('#y2').val(map.getBounds().getSouthWest().lng());
                    
                       //$('#mapenabled').attr("checked", "checked");
                   }
                  );
               
 
                });
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
			<!-- Top Menu Items -->
			<!-- <ul class="nav navbar-right top-nav">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="fa fa-envelope"></i> <b
						class="caret"></b></a>
					<ul class="dropdown-menu message-dropdown">

						<li class="message-preview"><a href="#">
								<div class="media">
									<span class="pull-left"> <img class="media-object"
										src="http://placehold.it/50x50" alt="">
									</span>
									<div class="media-body">
										<h5 class="media-heading">
											<strong>John Smith</strong>
										</h5>
										<p class="small text-muted">
											<i class="fa fa-clock-o"></i> Yesterday at 4:32 PM
										</p>
										<p>Lorem ipsum dolor sit amet, consectetur...</p>
									</div>
								</div>
						</a></li>
						<li class="message-preview"><a href="#">
								<div class="media">
									<span class="pull-left"> <img class="media-object"
										src="http://placehold.it/50x50" alt="">
									</span>
									<div class="media-body">
										<h5 class="media-heading">
											<strong>John Smith</strong>
										</h5>
										<p class="small text-muted">
											<i class="fa fa-clock-o"></i> Yesterday at 4:32 PM
										</p>
										<p>Lorem ipsum dolor sit amet, consectetur...</p>
									</div>
								</div>
						</a></li>
						<li class="message-preview"><a href="#">
								<div class="media">
									<span class="pull-left"> <img class="media-object"
										src="http://placehold.it/50x50" alt="">
									</span>
									<div class="media-body">
										<h5 class="media-heading">
											<strong>John Smith</strong>
										</h5>
										<p class="small text-muted">
											<i class="fa fa-clock-o"></i> Yesterday at 4:32 PM
										</p>
										<p>Lorem ipsum dolor sit amet, consectetur...</p>
									</div>
								</div>
						</a></li>
						<li class="message-footer"><a href="#">Read All New
								Messages</a></li>
					</ul></li>

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="fa fa-bell"></i> <b
						class="caret"></b></a>
					<ul class="dropdown-menu alert-dropdown">
						<li><a href="#">Alert Name <span
								class="label label-default">Alert Badge</span></a></li>
						<li><a href="#">Alert Name <span
								class="label label-primary">Alert Badge</span></a></li>
						<li><a href="#">Alert Name <span
								class="label label-success">Alert Badge</span></a></li>
						<li><a href="#">Alert Name <span class="label label-info">Alert
									Badge</span></a></li>
						<li><a href="#">Alert Name <span
								class="label label-warning">Alert Badge</span></a></li>
						<li><a href="#">Alert Name <span
								class="label label-danger">Alert Badge</span></a></li>
						<li class="divider"></li>
						<li><a href="#">View All</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="fa fa-user"></i> John Smith <b
						class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>
						</li>
						<li><a href="#"><i class="fa fa-fw fa-envelope"></i>
								Inbox</a></li>
						<li><a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
						</li>
						<li class="divider"></li>
						<li><a href="#"><i class="fa fa-fw fa-power-off"></i> Log
								Out</a></li>
					</ul></li>
			</ul>
			<!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
<c:import url="../include/vascorllheader.jsp">
			</c:import>
			<!-- /.navbar-collapse -->
		</nav>

		<div id="page-wrapper">

			<div class="container-fluid">

				<!-- Page Heading -->
				<div class="row">
					<div class="col-lg-12">
						<h1 class="page-header"> </h1>

					</div>

				</div>



				<div class="row">

					<div class="col-lg-4">
						<div class="panel panel-yellow">
							<div class="panel-heading">
								<div class="row">
									<div class="col-xs-3">Check in <span class="date"><fmt:formatDate
																	value="${nowtime}" type="date"
																	pattern="yyyy/MM/dd" /></span>/${season}/${timezone}</div>

								</div>
							</div>
							<table class="table table-striped">
							<c:forEach items="${current}" var="myitem">
							<tr><td><img src="${myitem.icon}"></img></td>
								<td>${myitem.place}(${myitem.attribute})

									
										<div class="text-right">
									<a href="<c:url value="/analysis/recommendationout?lat=${nowlat}&lng=${nowlng}&season=${season}&timezone=${timezone}&place=${myitem.attribute}"/>">Check in<i
										class="fa fa-arrow-circle-right"></i></a>
								</div>
									</td>
								
									</tr>

							</c:forEach></table>
						</div>
					</div>
					<div class="col-lg-8">
						 <div id="searchMap" style="width:100%;height:500px">
                                                        </div>
					
					</div>
				</div>





			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->


</body>

</html>
