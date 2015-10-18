<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="${baseURL}/js/networkanalysis/colorbox.js"></script>
<script type="text/javascript"
	src="${baseURL}/js/networkanalysis/timeliner.min.js"></script>

<script src="http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6"></script>
<script type="text/javascript"
	src="${baseURL}/js/networkanalysis/sigma.min.js"></script>
<script type="text/javascript"
	src="${baseURL}/js/networkanalysis/sigma.parseGexf.js"></script>
<script type="text/javascript"
	src="${baseURL}/js/networkanalysis/sigma2.js"></script>

<script src="${baseURL}/js/timemap/lib/mxn/mxn.js?(googlev3)"></script>
<script src="${baseURL}/js/timemap/lib/timeline-1.2.js"></script>
<script src="${baseURL}/js/timemap/timemap_full.pack.js"></script>

<script src="${baseURL}/js/highchart/highcharts.js"></script>
<script src="${baseURL}/js/highchart/modules/exporting.js"></script>

<script src="${baseURL}/js/networkanalysis/osdc2012.reddit.js"></script>
<script src="${baseURL}/js/networkanalysis/osdc2012.misc.js"></script>
<script src="${baseURL}/js/networkanalysis/sigma.forceatlas2.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
<script>
		$(document).ready(function() {

			
			 var local = false;
			 
				var greyColor = '#666';
				var theMapZoom = 4;
				var lon = 134.198822;
				var lat = 34.767522;
				var theMapCenter = new mxn.LatLonPoint()
				theMapCenter.lon = lon;
				theMapCenter.lat = lat;
				theMapCenter.lng = lon;
				
				//Time Map Searching
				
									var tm;
									var now;
									var nodeurl = "${baseURL}/analysis/show?format=json&username="+"${userid}";

									tm = TimeMap.init({
										mapId : "map", // Id of map div element (required)
										timelineId : "timeline", // Id of timeline div element (required)
										options : {
											eventIconPath : "${baseURL}/js/timemap/images/",
											centerOnItems : false,
											mapCenter : theMapCenter,
											mapZoom : theMapZoom

										},
										datasets : [ {
											id : "llog",
											title : "Llog",
											theme : "red",
											type : "json_string",
											options : {
												url : nodeurl
											}
										} ],
										bandIntervals : [ Timeline.DateTime.WEEK,
												Timeline.DateTime.MONTH ]
									});
									
			 
			   // Circular plugin:
		    sigma.publicPrototype.circularize = function() {
		      var R = 100, i = 0, L = this.getNodesCount();
		   
		      this.iterNodes(function(n){
		        n.x = Math.cos(Math.PI*(i++)/L)*R;
		        n.y = Math.sin(Math.PI*(i++)/L)*R;
		      });
		   
		      return this.position(0,0,1).draw();
		    };

		    // Instanciate sigma.js:

		    var s1 = sigma.init($('.sigma-container')[0]).drawingProperties({
				defaultLabelColor : '#ccc',
				defaultLabelSize : 14,
				defaultLabelBGColor : '#fff',
				defaultLabelHoverColor : '#000',
				labelThreshold : 6,
				defaultEdgeType : 'curve',
				defaultEdgeArrow: 'target',
				edgeLabels : true
			}).graphProperties({
				minNodeSize : 0.5,
				maxNodeSize : 20,
				minEdgeSize : 1,
				maxEdgeSize : 1
			}).mouseProperties({
				maxRatio : 8
			});
		  
		    /**
		     * NAVIGATION:
		     */
		    var moveDelay = 80,
		        zoomDelay = 2;

		    $('.move-icon').bind('click keypress',function(event) {
		      var newPos = s1.position();
		    
		      switch ($(this).attr('action')) {
		        case 'up':
		          newPos.stageY += moveDelay;
		          newPos2.stageY += moveDelay;
		          break;
		        case 'down':
		          newPos.stageY -= moveDelay;
		          break;
		        case 'left':
		          newPos.stageX += moveDelay;
		          break;
		        case 'right':
		          newPos.stageX -= moveDelay;
		          break;
		      }

		      s1.goTo(newPos.stageX, newPos.stageY);

		      event.stopPropagation();
		      return false;
		    });

		    $('.zoom-icon').bind('click keypress',function(event) {
		      var ratio = s1.position().ratio;
		      switch ($(this).attr('action')) {
		        case 'in':
		          ratio *= zoomDelay;
		          break;
		        case 'out':
		          ratio /= zoomDelay;
		          break;
		      }

		      s1.goTo(
		        $('.sigma-container').width() / 2,
		        $('.sigma-container').height() / 2,
		        ratio
		      );
		    

		      event.stopPropagation();
		      return false;
		    });

		    $('.refresh-icon').bind('click keypress',function(event) {
		      s1.position(0, 0, 1).draw();
		      s2.position(0, 0, 1).draw();
		      event.stopPropagation();
		      return false;
		    });

		    $('.sigma-container').keydown(function(e) {
		      var newPos = s1.position(),
		          change = false;
		      newPos.ratio = undefined;

		      switch (e.keyCode) {
		        case 32:
		          s1.position(0, 0, 1).draw();
		          e.stopPropagation();
		          return false;
		        case 38:
		        case 75:
		          newPos.stageY += moveDelay;
		          change = true;
		          break;
		        case 40:
		        case 74:
		          newPos.stageY -= moveDelay;
		          change = true;
		          break;
		        case 37:
		        case 72:
		          newPos.stageX += moveDelay;
		          change = true;
		          break;
		        case 39:
		        case 76:
		          newPos.stageX -= moveDelay;
		          change = true;
		          break;
		        case 107:
		          newPos.ratio = s1.position().ratio * zoomDelay;
		          newPos.stageX = $('.sigma-container').width() / 2;
		          newPos.stageY = $('.sigma-container').height() / 2;
		          change = true;
		          break;
		        case 109:
		          newPos.ratio = s1.position().ratio / zoomDelay;
		          newPos.stageX = $('.sigma-container').width() / 2;
		          newPos.stageY = $('.sigma-container').height() / 2;
		          change = true;
		          break;
		      }

		      if(change) {
		        s1.goTo(newPos.stageX, newPos.stageY, newPos.ratio);
		        e.stopPropagation();
		        return false;
		      }
		    }).focus(function(){
		      s1.stopForceAtlas2();
		    }).blur(function(){
		      s1.startForceAtlas2();
		    });
		    


		    /**
		     * OTHER
		     */
		    function onAction() {
		      // Make all nodes unactive:
		      s1.iterNodes(function(n) {
		        n.active = false;
		      });
		    
		    }

		    // Autocompleted search field:
		    $('form.search-nodes-form').submit(function(e) {
		      onAction();
		      e.preventDefault();
		    });

		    // Node information:
		    function loadRedditUser(node) {
		      hideTwitterUser();

		      if(node['label'] !== '[deleted]')
		        reddit.user(node['label']);
		      else
		        showRedditUser();
		    }

		    function showRedditUser(obj) {
		      hideTwitterUser();

		      if(obj){
		        // Name :
		        $('div.node-info-container .node-name').append(
		          '<h3>' +
		            '<a target="_blank" href="' +
		              'http://www.reddit.com/user/' + obj['name'] +
		            '">' +
		            obj['name'] +
		            '</a>' +
		          '</h3>'
		        );

		        // Link Karma :
		        $('div.node-info-container .node-link-karma').append(
		          'Link karma: ' + obj['link_karma']
		        );

		        // Comments Karma :
		        $('div.node-info-container .node-comments-karma').append(
		          'Comments karma: ' + obj['comment_karma']
		        );
		      }else{
		        $('div.node-info-container .node-name').append(
		          '<h3>' +
		            'Oops, the requested user has been deleted.' +
		          '</h3>'
		        );
		      }
		    }

		    function hideTwitterUser() {
		      $('div.node-info-container .node-info').empty();
		    }
		   // s2.parseGexf("http://ll.artsci.kyushu-u.ac.jp/Gexf/tdadata.gexf");
		    //s1.parseGexf("http://ll.artsci.kyushu-u.ac.jp/Gexf/kpt.gexf");

			s1.parseGexf("http://localhost:8080/learninglog/js/networkanalysis/kpt.gexf");
		    // Tweak:
		    // Give focus to sigma-container when sigma is clicked:
		    $('#sigma_mouse_1').click(function(){
		      $('.sigma-container').focus();
		      $('.sigma-container2').focus();
		     
		    });

	

		    $('form[name="post-url-form"]').submit(function(e){
		      if(local)
		    	  s1.parseGexf("http://localhost:8080/learninglog/js/networkanalysis/kpt.gexf");
		      else
		        reddit.pageComments($(this).find('input[type="text"]').attr('value'));

		      e.stopPropagation();
		      e.preventDefault();
		      return false;
		    });

		    $('.contains-icon').mouseover(function() {
		      $(this).find('.icon-button').addClass('icon-white');
		    }).mouseout(function() {
		      $(this).find('.icon-button').removeClass('icon-white');
		    });

		    // Init first loading:
		    if(local)
		      reddit.localPageComments('data_sample.json');
		    else
		      reddit.pageComments($(this).find('input[type="text"]').attr('value'));

		  

		    s1.bind(
					'overnodes',
					function(event) {
						var nodes = event.content;
						var neighbors = {};
						s1
								.iterEdges(
										function(e) {
											if (nodes.indexOf(e.source) < 0
													&& nodes
															.indexOf(e.target) < 0) {
												if (!e.attr['grey']) {
													e.attr['true_color'] = e.color;
													e.color = greyColor;
													e.attr['grey'] = 1;
												}
											} else {
												e.color = e.attr['grey'] ? e.attr['true_color']
														: e.color;
												e.attr['grey'] = 0;

												neighbors[e.source] = 1;
												neighbors[e.target] = 1;
											}
										})
								.iterNodes(
										function(n) {
											if (!neighbors[n.id]) {
												if (!n.attr['grey']) {
													n.attr['true_color'] = n.color;
													n.color = greyColor;
													n.attr['grey'] = 1;
												}
											} else {
												n.color = n.attr['grey'] ? n.attr['true_color']
														: n.color;
												n.attr['grey'] = 0;
											}
										}).draw(2, 2, 2);

					})
			.bind(
					'outnodes',
					function() {
						s1
								.iterEdges(
										function(e) {
											e.color = e.attr['grey'] ? e.attr['true_color']
													: e.color;
											e.attr['grey'] = 0;
										})
								.iterNodes(
										function(n) {
											n.color = n.attr['grey'] ? n.attr['true_color']
													: n.color;
											n.attr['grey'] = 0;
										}).draw(2, 2, 2);
					});



		s1.bind('downnodes', function(event) {
		s1.iterNodes(
				function(n) {
					var theMapZoom = 6;
					
					if(n.id==event.content[0]){
					//alert(n.attr.attributes[4].val);
					
					for(var i=0;i<n.attr.attributes.length;i++){
						if(n.attr.attributes[i].attr=="Authorid"){
							var tm;

							var nodeurl = "${baseURL}/analysis/show?format=json&username="
									+ n.attr.attributes[i].val;

							tm = TimeMap.init({
								mapId : "map", // Id of map div element (required)
								timelineId : "timeline", // Id of timeline div element (required)
								options : {
									eventIconPath : "${baseURL}/js/timemap/images/",
									centerOnItems : false,
									mapCenter : theMapCenter,
									mapZoom : theMapZoom

								},
								datasets : [ {
									id : "llog",
									title : "Llog",
									theme : "red",
									type : "json_string",
									options : {
										url : nodeurl
									}
								} ],
								bandIntervals : [ Timeline.DateTime.WEEK,
										Timeline.DateTime.MONTH ]
							});
							
							// add our new function to the map and timeline filters
							//tm.addFilter("map", TimeMap.filters.hasSelectedTag); // hide map markers on fail
							//tm.addFilter("timeline", TimeMap.filters.hasSelectedTag); // hide timeline events on fail
							for(var i=0;i<n.attr.attributes.length;i++){
								if(n.attr.attributes[i].attr=="createtime"){
							var nodestate = n.attr.attributes[i].val;
							var timedata = nodestate.split("/");
							obj = new Date();

							obj.setFullYear(timedata[0]);

							obj.setMonth(timedata[1]);

							//obj.setDate(timedata[2]);

						
							tm.scrollToDate(obj, false, true);
								}
							}
						}
						}
					}
					
				}
				
		);

		});
		 
			
		
	  
		
		

	
		
		 });
	
		

	</script>
<title>SB Admin - Bootstrap Admin Template</title>

<!-- Bootstrap Core CSS -->
<link href="${baseURL}/css/vascorll/top/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="${baseURL}/css/vascorll/top/css/sb-admin.css"
	rel="stylesheet">

<!-- Morris Charts CSS -->
<link href="${baseURL}/css/vascorll/top/css/plugins/morris.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="${baseURL}/css/vascorll/top/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

	<!-- jQuery -->
		<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<!--  <script src="${baseURL}/css/vascorll/top/js/jquery.js"></script>-->

	<!-- Bootstrap Core JavaScript -->

	<!--<script src="${baseURL}/css/vascorll/top/js/bootstrap.min.js"></script>-->

	<!-- Morris Charts JavaScript -->
	<script
		src="${baseURL}/css/vascorll/top/js/plugins/morris/raphael.min.js"></script>
	<script
		src="${baseURL}/css/vascorll/top/js/plugins/morris/morris.min.js"></script>
	<script
		src="${baseURL}/css/vascorll/top/js/plugins/morris/morris-data.js"></script>

	<!-- Flot Charts JavaScript -->
	<!--[if lte IE 8]><script src="js/excanvas.min.js"></script><![endif]-->
	<script
		src="${baseURL}/css/vascorll/top/js/plugins/flot/jquery.flot.js"></script>
	<script
		src="${baseURL}/css/vascorll/top/js/plugins/flot/jquery.flot.tooltip.min.js"></script>
	<script
		src="${baseURL}/css/vascorll/top/js/plugins/flot/jquery.flot.resize.js"></script>
	<script
		src="${baseURL}/css/vascorll/top/js/plugins/flot/jquery.flot.pie.js"></script>


	<script src="${baseURL}/css/vascorll/top/js/plugins/flot/flot-data.js"></script>

	
	

</head>
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
			<ul class="nav navbar-right top-nav">
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
				<!--  
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                    <ul class="dropdown-menu alert-dropdown">
                        <li>
                            <a href="#">Alert Name <span class="label label-default">Alert Badge</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-primary">Alert Badge</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-success">Alert Badge</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-info">Alert Badge</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-warning">Alert Badge</span></a>
                        </li>
                        <li>
                            <a href="#">Alert Name <span class="label label-danger">Alert Badge</span></a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">View All</a>
                        </li>
                    </ul>
                </li>-->
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
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav side-nav">
					<li class="active"><a href="<c:url value = "/analysis/home"/>"><i
							class="fa fa-fw fa-dashboard"></i>My goal</a></li>
					<li><a href="<c:url value = "/analysis/visualization"/>"><i
							class="fa fa-fw fa-bar-chart-o"></i>Visualization</a></li>
					<li><a href="tables.html"><i class="fa fa-fw fa-table"></i>
							Tables</a></li>
					<li><a href="forms.html"><i class="fa fa-fw fa-edit"></i>
							Forms</a></li>
					<li><a href="bootstrap-elements.html"><i
							class="fa fa-fw fa-desktop"></i> Bootstrap Elements</a></li>
					<li><a href="bootstrap-grid.html"><i
							class="fa fa-fw fa-wrench"></i> Bootstrap Grid</a></li>
					<li><a href="javascript:;" data-toggle="collapse"
						data-target="#demo"><i class="fa fa-fw fa-arrows-v"></i>
							Dropdown <i class="fa fa-fw fa-caret-down"></i></a>
						<ul id="demo" class="collapse">
							<li><a href="#">Dropdown Item</a></li>
							<li><a href="#">Dropdown Item</a></li>
						</ul></li>
					<li><a href="blank-page.html"><i class="fa fa-fw fa-file"></i>
							Blank Page</a></li>
					<li><a href="index-rtl.html"><i
							class="fa fa-fw fa-dashboard"></i> RTL Dashboard</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</nav>

		<div id="page-wrapper">

			<div class="container-fluid">

				<!-- Page Heading -->
				<!--  
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Charts
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="index.html">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-bar-chart-o"></i> Charts
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

				<!-- Flot Charts -->
				<div class="row">
					<div class="col-lg-12">
						<h2 class="page-header">Visualization for analyzing ULLS</h2>
					</div>
				</div>
				<!-- /.row -->

				<div class="row">
					<div class="col-lg-4" style="height:500px">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-long-arrow-right"></i> Pie Chart Example with
									Tooltips
								</h3>
							</div>
							<div class="panel-body">
								<div class="flot-chart">
									<div class="flot-chart-content" id="flot-pie-chart"></div>
								</div>
								<div class="text-right">
									<a href="#">View Details <i
										class="fa fa-arrow-circle-right"></i></a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-8" >
					
					
								<div class="span12 sigma-parent" id="sigma-example-parent"
									>
									<div class="sigma-container" id="sigma-example"
										style="background-color: #10000d;height:470px">

									</div>
  <!-- And here go all the button to navigate in the graph -->
  	
        
									<div class="control-panel" style="witdh:400px;height: 1px">
										<!-- Here are the info about user -->
										<div class="move"
											style="margin-top: -80px; position: absolute">
											<div class="contains-icon move-icon" tabindex="0" action="up"
												title="Move up in the graph"
												style="background-color: #D9E5FF">
												<div class="icon-button icon-arrow-up"
													style="background-color: #D9E5FF"></div>
											</div>
											<div class="contains-icon move-icon" tabindex="0"
												action="left" title="Move left in the graph"
												style="background-color: #D9E5FF">
												<div class="icon-button icon-arrow-left"
													style="background-color: #D9E5FF"></div>
											</div>
											<div class="contains-icon move-icon" tabindex="0"
												action="right" title="Move right in the graph"
												style="background-color: #D9E5FF">
												<div class="icon-button icon-arrow-right"
													style="background-color: #D9E5FF"></div>
											</div>
											<div class="contains-icon move-icon" tabindex="0"
												action="down" title="Move down in the graph"
												style="background-color: #D9E5FF">
												<div class="icon-button icon-arrow-down"
													style="background-color: #D9E5FF"></div>
											</div>
										</div>
										<div class="zoom" style="margin-top: -80px">
											<div class="contains-icon zoom-icon" tabindex="0"
												action="out" title="Zoom out the graph"
												style="background-color: #D9E5FF">
												<div class="icon-button icon-zoom-out"
													style="background-color: #D9E5FF"></div>
											</div>
											<div class="contains-icon" tabindex="0" action="refresh"
												title="Reset graph position"
												style="background-color: #D9E5FF">
												<div class="icon-button refresh-icon icon-resize-full"
													style="background-color: #D9E5FF"></div>
											</div>
											<div class="contains-icon zoom-icon" tabindex="0" action="in"
												title="Zoom in the graph" style="background-color: #D9E5FF">
												<div class="icon-button icon-zoom-in"
													style="background-color: #D9E5FF"></div>
											</div>
										</div>



										<!-- And here go all the button to navigate in the graph -->

									</div>

								

								</div>
					
						
					</div>
				</div>
				<br>
				<!-- /.row -->

				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-bar-chart-o"></i> 	
								</h3>
							</div>
							<div class="panel-body">
								<div id="disp">
										<div id="timemap">
											<div id="timelinecontainer"></div>
											<div id="timeline"></div>

											<div id="mapcontainer">
												<div id="map"></div>
											</div>
										</div>
										<div id="ContentsContainer"
											style="font-size: 24px;  class="optional"></div>
									</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.row -->

<div class="row"><div class="control-panel" style="height:100px;width:60px">
          <div class="move">
              <div class="contains-icon move-icon" tabindex="0" action="up" title="Move up in the graph">
                <div class="icon-button icon-arrow-up"></div>
              </div>
              <div class="contains-icon move-icon" tabindex="0" action="left" title="Move left in the graph">
                <div class="icon-button icon-arrow-left"></div>
              </div>
              <div class="contains-icon move-icon" tabindex="0" action="right" title="Move right in the graph">
                <div class="icon-button icon-arrow-right"></div>
              </div>
              <div class="contains-icon move-icon" tabindex="0" action="down" title="Move down in the graph">
                <div class="icon-button icon-arrow-down"></div>
              </div>
            </div>
            <div class="zoom">
              <div class="contains-icon zoom-icon" tabindex="0" action="out" title="Zoom out the graph">
                <div class="icon-button icon-zoom-out"></div>
              </div>
              <div class="contains-icon" tabindex="0" action="refresh" title="Reset graph position">
                <div class="icon-button refresh-icon icon-resize-full"></div>
              </div>
              <div class="contains-icon zoom-icon" tabindex="0" action="in" title="Zoom in the graph">
                <div class="icon-button icon-zoom-in"></div>
              </div>
            </div></div></div>

				<div class="row">
					<div class="col-lg-6">
						<div class="panel panel-red">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-long-arrow-right"></i> Moving Line Chart
								</h3>
							</div>
							<div class="panel-body">
							
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-long-arrow-right"></i> Bar Graph with Tooltips
								</h3>
							</div>
							<div class="panel-body">
								<div class="flot-chart">
									<div class="flot-chart-content" id="flot-bar-chart"></div>
								</div>
								<div class="text-right">
									<a href="#">View Details <i
										class="fa fa-arrow-circle-right"></i></a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.row -->

				<!-- Morris Charts -->
				<div class="row">
					<div class="col-lg-12">
						<h2 class="page-header">Morris Charts</h2>
						<p class="lead">
							Morris.js is a very simple API for drawing line, bar, area and
							donut charts. For full usage instructions and documentation for
							Morris.js charts, visit <a
								href="http://morrisjs.github.io/morris.js/">http://morrisjs.github.io/morris.js/</a>.
						</p>
					</div>
				</div>
				<!-- /.row -->

				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-bar-chart-o"></i> Area Line Graph Example with
									Tooltips
								</h3>
							</div>
							<div class="panel-body">
								<div id="morris-area-chart"></div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.row -->

				<div class="row">
					<div class="col-lg-4">
						<div class="panel panel-yellow">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-long-arrow-right"></i> Donut Chart Example
								</h3>
							</div>
							<div class="panel-body">
								<div id="morris-donut-chart"></div>
								<div class="text-right">
									<a href="#">View Details <i
										class="fa fa-arrow-circle-right"></i></a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="panel panel-red">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-long-arrow-right"></i> Line Graph Example with
									Tooltips
								</h3>
							</div>
							<div class="panel-body">
								<div id="morris-line-chart"></div>
								<div class="text-right">
									<a href="#">View Details <i
										class="fa fa-arrow-circle-right"></i></a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-long-arrow-right"></i> Bar Graph Example
								</h3>
							</div>
							<div class="panel-body">
								<div id="morris-bar-chart"></div>
								<div class="text-right">
									<a href="#">View Details <i
										class="fa fa-arrow-circle-right"></i></a>
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
</body>

</html>
