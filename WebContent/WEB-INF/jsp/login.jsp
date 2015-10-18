<%@page contentType="text/html" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!-- 
<!doctype html>
<html>

<link href="http://getbootstrap.com/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="http://getbootstrap.com/examples/cover/cover.css"
	rel="stylesheet">

<script
	src="http://getbootstrap.com/assets/js/ie-emulation-modes-warning.js"></script>

<script
	src="http://getbootstrap.com/assets/js/ie10-viewport-bug-workaround.js"></script>

<script>
	function auth() {
		alert("Your authentication is incorrent.If you use this system, please you contact to system administrator.");
	}
</script>
<style type="text/css">
.login-form {
	background: rgba(255, 255, 255, 0.1);
	padding: 2rem 6rem 2rem;
}

.site-wrapper {
	background-image:
		url('http://html5up.net/uploads/demos/overflow/images/bg.jpg');
}

.introduction {
	font-size: medium;
}

#login-form {
	padding-left: 20%;
	padding-right: 20%;
	width: 100%;
	bottom: 0;
}

.navbar-default {
 background-color: transparent; 
 border-color: transparent; 
width: 100%;
padding-left: 15%;
padding-right: 15%;
}

.navbar-default .navbar-toggle {
 border-color: transparent;
}

@media (min-width: 768px)
.site-wrapper-inner {
 vertical-align: top; 
}

.navbar-default .navbar-collapse, .navbar-default .navbar-form {
border-color: transparent;
}

.navbar-default .navbar-brand {
color: white;
}
.navbar-default .navbar-nav>li>a {
 color: white;
}

.tabbed{
	text-decoration: underline;
font-size: larger;
}
</style>


<body>

	<div class="site-wrapper">

		<div class="site-wrapper-inner">


			<nav class="navbar navbar-default" role="navigation">
				<div class="container-fluid">
					
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target="#bs-example-navbar-collapse-1">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#">SCROLL</a>
					</div>

				
					<div class="collapse navbar-collapse"
						id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav navbar-right">
							<li class="menutab tabbed"><a href="#">Home</a></li>
			                <li class="menutab"><a href="#">About</a></li>
			                <li class="menutab"><a href="#">Other</a></li>
			                <li><a href="http://ll.artsci.kyushu-u.ac.jp/learninglog/help">Help</a></li>
			                <li><a href="https://sites.google.com/site/learning64u/video">Videos</a></li>
							
						</ul>
					</div>
					
				</div>
				
			</nav>

			<div class="cover-container">

				<div id="home-panel" class="inner cover">
					<h1 class="cover-heading">Learning Log</h1>
					<p class="lead">"Let's learn more from what you have learned,
						and learn more where you have learned...."</p>
					<p class="lead video-lead">

							
					<iframe width="100%" height="450" src="https://www.youtube.com/embed/1ycPyiN5nBY" frameborder="0" allowfullscreen></iframe>
					</p>
					<p class="lead">
						<a href="<c:url value="/signup" />" class="btn btn-lg btn-default">Sign
							Up</a> <a href="http://ll.artsci.kyushu-u.ac.jp/LL5/"
							class="btn btn-lg btn-warning">Mobile Site</a>
					</p>
				</div>

				<div id="about-panel" class="inner cover row">
					<h1 class="cover-heading">Learning Log</h1>
					<div class="col-lg-6">
						<p class="lead introduction">Learning-Log means your record of
							what you have learned and this system makes it easy to remember
							new vocabularies for foreign language learners . It allows you to
							log, share and reuse your learning log with others. Also, you can
							receive personalized quizzes and answers for your questions, and
							navigate surrounding learning log supported by augmented reality
							view. Learning-Log system can be used on mobile phones or/and on
							PC using any web browser.</p>
					</div>
					<div class="col-lg-6">
						<img
							src="http://ll.artsci.kyushu-u.ac.jp/learninglog2/images/llcollect.jpg"
							width="300px" class="img-thumbnail" />
					</div>
				</div>

				<div id="other-panel" class="inner cover row">
					<div class="col-lg-4">
						<img class="img-circle"
							src="http://ll.artsci.kyushu-u.ac.jp/learninglog/images/skin_header_logo.jpg"
							alt="Generic placeholder image"
							style="width: 140px; height: 140px;">
						<h2>Learning Log</h2>
						<p>
							Ubiquitous Learning Log for You<br />Development of the
							Information Infrastructure for Collaborative Learning Using
							Learning Log
						</p>
						<p>
							<a class="btn btn-warning"
								href="https://sites.google.com/site/learning64u/" role="button">View
								details »</a>
						</p>
					</div>
					<div class="col-lg-4">
						<img class="img-circle"
							src="http://developer.android.com/images/brand/Android_Robot_200.png"
							alt="Generic placeholder image"
							style="width: 140px; height: 140px;">
						<h2>Android</h2>
						<p>
							Download LearningLog for Android<br />Those applications are free
							and available at Google Play.
						</p>
						<p>
							<a class="btn btn-success"
								href="http://ll.artsci.kyushu-u.ac.jp/learninglog/download/apk"
								role="button">View details »</a>
						</p>
					</div>
					<div class="col-lg-4">
						<img class="img-circle" src="<c:url value="/images/SISL.png"/>"
							alt="Generic placeholder image"
							style="width: 140px; height: 140px;">
						<h2>SISL</h2>
						<p>SISL,Seamless Inquiry Learning in Science.Let's join and
							log our seamless inquiry-based learning experience!</p>
						<p>
							<a class="btn btn-default" href="http://amaze-dev.com/demo3/"
								role="button">View details »</a>
						</p>
					</div>

				</div>

			</div>

			<form class="form-inline login-form" role="form" id="login-form"
				action="<c:url value="/signin" />" method="post">
				<div class="form-group">
					<label class="sr-only" for="exampleInputEmail2">Email
						address</label> <input type="email" name="username" id="mailAddr"
						class="form-control" placeholder="Enter email">
				</div>
				<div class="form-group">
					<label class="sr-only" for="exampleInputPassword2">Password</label>
					<input type="password" class="form-control" name="password"
						id="password" placeholder="Password">
				</div>
				<div class="checkbox">
					<label> <input type="checkbox" name="remember"
						id="remember_me"> Remember me
					</label>
				</div>
				<input type="submit" id="submit-button" class="btn btn-primary"
					value="Sign in" /> <a
					href="<c:url value="/signup/resetpassword" />">Forgot password?</a>
			</form>
		</div>


		<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
		<script src="http://getbootstrap.com/dist/js/bootstrap.min.js"></script>
		<script src="http://getbootstrap.com/assets/js/docs.min.js"></script>



		<script type="text/javascript">
			$(document).ready(function() {
				$('#about-panel').hide();
				$('#other-panel').hide();
				$('.menutab').click(function() {
					var menus = $('.menutab');
					for ( var i = 0; i < menus.length; i++) {
						if ($(menus[i]).html() == $(this).html()) {
							$(menus[i]).addClass('tabbed');
							if (i == 0) {
								$('#home-panel').show();
								$('#about-panel').hide();
								$('#other-panel').hide();
							} else if (i == 1) {
								$('#about-panel').show();
								$('#home-panel').hide();
								$('#other-panel').hide();
							} else if (i == 2) {
								$('#other-panel').show();
								$('#about-panel').hide();
								$('#home-panel').hide();
							}
						} else {
							$(menus[i]).removeClass('active');
						}
					}
				});

			});
		</script>
</body>
</html>-->







<!DOCTYPE html>
<html lang="en">
<head>
<!-- 
    	Boxer Template
    	http://www.templatemo.com/preview/templatemo_446_boxer
    	-->
<meta charset="utf-8">
<title>SCORLL</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords" content="">
<meta name="description" content="">

<!-- animate css -->
<link rel="stylesheet"
	href="http://ll.artsci.kyushu-u.ac.jp/learninglog/css/vascorll/css/animate.min.css">
<!-- bootstrap css -->
<link rel="stylesheet"
	href="http://ll.artsci.kyushu-u.ac.jp/learninglog/css/vascorll/css/bootstrap.min.css">
<!-- font-awesome -->
<link rel="stylesheet"
	href="http://ll.artsci.kyushu-u.ac.jp/learninglog/css/vascorll/css/font-awesome.min.css">
<!-- google font -->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,700,800'
	rel='stylesheet' type='text/css'>

<!-- custom css -->
<link rel="stylesheet"
	href="http://ll.artsci.kyushu-u.ac.jp/learninglog/css/vascorll/css/templatemo-style.css">

</head>
<script src="http://ll.artsci.kyushu-u.ac.jp/learninglog/css/vascorll/js/jquery.js"></script>
<script src="http://ll.artsci.kyushu-u.ac.jp/learninglog/css/vascorll/js/bootstrap.min.js"></script>
<script src="http://ll.artsci.kyushu-u.ac.jp/learninglog/css/vascorll/js/wow.min.js"></script>
<script src="http://ll.artsci.kyushu-u.ac.jp/learninglog/css/vascorll/js/jquery.singlePageNav.min.js"></script>
<script src="http://ll.artsci.kyushu-u.ac.jp/learninglog/css/vascorll/js/custom.js"></script>
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
				<a href="#" class="navbar-brand">SCORLL</a>
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
						<h1 class="text-upper">SCROLL</h1>
									</div>
					<div id="timemapBox" class="parts memberImageBox"
									style="text-align: center">
								</div>
									<p class="lead">
						<a href="<c:url value="/signup" />" class="btn btn-lg btn-default">Create your account</a>
					</p>
						<p class="tm-white">Learning-Log means your record of
							what you have learned and this system makes it easy to remember
							new vocabularies for foreign language learners . It allows you to
							log, share and reuse your learning log with others. Also, you can
							receive personalized quizzes and answers for your questions, and
							navigate surrounding learning log supported by augmented reality
							view. Learning-Log system can be used on mobile phones or/and on
							PC using any web browser.</p>
							
							
									<form class="form-inline login-form" role="form" id="login-form"
				action="<c:url value="/signin" />" method="post">
				<div class="form-group">
					<label class="sr-only" for="exampleInputEmail2">Email
						address</label> <input type="email" name="username" id="mailAddr"
						class="form-control" placeholder="Enter email">
				</div>
				<div class="form-group">
					<label class="sr-only" for="exampleInputPassword2">Password</label>
					<input type="password" class="form-control" name="password"
						id="password" placeholder="Password">
				</div>
				<div class="checkbox">
					<label> <input type="checkbox" name="remember"
						id="remember_me"> Remember me
					</label>
				</div>
				<input type="submit" id="submit-button" class="btn btn-primary"
					value="Sign in" /> <a
					href="<c:url value="/signup/resetpassword" />"><font color="red">Forgot password?</font></a>
			</form>
						
							
						<img src="http://ll.artsci.kyushu-u.ac.jp/learninglog/css/vascorll/images/software-img.png"
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











