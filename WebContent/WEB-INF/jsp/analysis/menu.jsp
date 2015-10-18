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
<!-- 
    	Boxer Template
    	http://www.templatemo.com/preview/templatemo_446_boxer
    	-->
<meta charset="utf-8">
<title>VASCORLL</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords" content="">
<meta name="description" content="">

<!-- animate css -->
<link rel="stylesheet"
	href="${baseURL}/css/vascorll/css/animate.min.css">
<!-- bootstrap css -->
<link rel="stylesheet"
	href="${baseURL}/css/vascorll/css/bootstrap.min.css">
<!-- font-awesome -->
<link rel="stylesheet"
	href="${baseURL}/css/vascorll/css/font-awesome.min.css">
<!-- google font -->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,700,800'
	rel='stylesheet' type='text/css'>

<!-- custom css -->
<link rel="stylesheet"
	href="${baseURL}/css/vascorll/css/templatemo-style.css">

</head>
<script src="${baseURL}/css/vascorll/js/jquery.js"></script>
<script src="${baseURL}/css/vascorll/js/bootstrap.min.js"></script>
<script src="${baseURL}/css/vascorll/js/wow.min.js"></script>
<script src="${baseURL}/css/vascorll/js/jquery.singlePageNav.min.js"></script>
<script src="${baseURL}/css/vascorll/js/custom.js"></script>
<script type="text/javascript">
<!--
function go_href() {
	window.location.href = "http://ll.artsci.kyushu-u.ac.jp/learninglog/analysis";
}
// -->
</script>

<body>
	<!-- start preloader -->
	<div class="preloader">
		<div class="sk-spinner sk-spinner-rotating-plane"></div>
	</div>
	<!-- end preloader -->
	<!-- start navigation -->
	<nav class="navbar navbar-default navbar-fixed-top templatemo-nav"
		role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="icon icon-bar"></span> <span class="icon icon-bar"></span>
					<span class="icon icon-bar"></span>
				</button>
				<a href="#" class="navbar-brand">VASCORLL</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#home">Home</a></li>
	
				
				</ul>
			</div>
		</div>
	</nav>
	<!-- end navigation -->
	<!-- start home -->
	<section id="home">
		<div class="overlay">
			<div class="container">
				<div class="row">
					<div class="col-md-1"></div>
					<div class="col-md-10 wow fadeIn" data-wow-delay="0.3s">
						<h1 class="text-upper">Visualization and Analysis System for
							Connecting Relationships of Learning Logs</h1>
									</div>
					<div id="timemapBox" class="parts memberImageBox"
									style="text-align: center">
									<button
										onClick="location.href='<c:url value = "/analysis/home"/>'"
										class="btn btn-block btn-danger">Move to VASCORLL</button>
								</div>
						<p class="tm-white">VASCORLL works in a cyber-physical setting
							to link learners in the real world and learning logs that are
							accumulated in cyber spaces by using a ubiquitous learning system
							called SCROLL. VASCORLL can find relationships
							between learners’ contexts in the real world and past learners'
							contexts in cyber space, and then recommend knowledge that can be
							applied into other contexts to learners in the real world.</p>
							
						<img src="${baseURL}/css/vascorll/images/software-img.png"
							class="img-responsive" alt="home img">
			
								
					<div class="col-md-1"></div>
				</div>
			</div>
		</div>
	</section>
	
	<!-- end home -->
	<!-- start divider -->
	<!--  
	<section id="divider">
		<div class="container">
			<div class="row">
				<div class="col-md-4 wow fadeInUp templatemo-box"
					data-wow-delay="0.3s">
					<i class="fa fa-laptop"></i>
					<h3 class="text-uppercase">RESPONSIVE LAYOUT</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
						sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
						Ut enim ad minim veniam, quis nostrud exercitation.</p>
				</div>
				<div class="col-md-4 wow fadeInUp templatemo-box"
					data-wow-delay="0.3s">
					<i class="fa fa-twitter"></i>
					<h3 class="text-uppercase">BOOTSTRAP 3.3.4</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
						sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
						Ut enim ad minim veniam, quis nostrud exercitation.</p>
				</div>
				<div class="col-md-4 wow fadeInUp templatemo-box"
					data-wow-delay="0.3s">
					<i class="fa fa-font"></i>
					<h3 class="text-uppercase">GOOGLE FONT</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
						sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
						Ut enim ad minim veniam, quis nostrud exercitation.</p>
				</div>
			</div>
		</div>
	</section>-->
	<!-- end divider -->





	<!-- start contact -->
	<section id="contact">
		<div class="overlay">
			<div class="container">
				<div class="row">
					<div class="col-md-6 wow fadeInUp" data-wow-delay="0.6s">
						<h2 class="text-uppercase">Contact Us</h2>
	
						<address>
							<p>
								<i class="fa fa-map-marker"></i>744 Motooka, Nishi-ku, Fukuoka, 819-0395, Japan
							</p>
				
							<p>
								<i class="fa fa-envelope-o"></i>mourikousuke@gmail.com
							</p>
						</address>
					</div><!-- 
					<div class="col-md-6 wow fadeInUp" data-wow-delay="0.6s">
						<div class="contact-form">
							<form action="#" method="post">
								<div class="col-md-6">
									<input type="text" class="form-control" placeholder="Name">
								</div>
								<div class="col-md-6">
									<input type="email" class="form-control" placeholder="Email">
								</div>
								<div class="col-md-12">
									<input type="text" class="form-control" placeholder="Subject">
								</div>
								<div class="col-md-12">
									<textarea class="form-control" placeholder="Message" rows="4"></textarea>
								</div>
								<div class="col-md-8">
									<input type="submit" class="form-control text-uppercase"
										value="Send">
								</div>
							</form>
						</div>
					</div> -->
				</div>
			</div>
		</div>
	</section>
	<!-- end contact -->

	<!-- start footer -->
	<footer>
		<div class="container">
			<div class="row">
				<p>Kyushu University</p>
			</div>
		</div>
	</footer>
	<!-- end footer -->

</body>
</html>