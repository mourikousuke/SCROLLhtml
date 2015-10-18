<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>


<c:import url="../include/vsjscss.jsp">
</c:import>
<c:import url="../include/head.jsp">
	<c:param name="javascript">

		<script type="text/javascript"
			src="<c:url value="/js/jquery/fancyzoom/js/fancyzoom.min.js" />"></script>
		<script type="text/javascript">
			$(function() {
				$('a.zoom').fancyZoom({
					directory : '<c:url value="/js/jquery/fancyzoom/images" />'
				});
			});
		</script>


		<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
		<script
			src="<c:url value="/js/jQuery.jPlayer.2.0.0/jquery.jplayer.min.js" />"></script>
		<script src="<c:url value="/js/jquery/jquery.linkify-1.0-min.js"/>"></script>
		<script
			src="<c:url value='/js/mediaelement/mediaelement-and-player.min.js' />"></script>
		<script type="text/javascript"
			src="http://connect.facebook.net/en_US/all.js"></script>
		<script type="text/javascript">
        $(function(){
        	var map = new google.maps.Map(document.getElementById("searchMap"), {
                disableDefaultUI: true,
                scaleControl: true,
                navigationControl: true,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
            });
            
            var bounds = new google.maps.LatLngBounds();
            var marker;
            <c:forEach items="${quizzes}" var="item" varStatus="sta">
                <c:if test="${(!empty item.item_lat) and (!empty item.item_lng)}">
                    marker = new google.maps.Marker({position:new google.maps.LatLng(${item.item_lat}, ${item.item_lng}), map:map});
                    bounds.extend(marker.getPosition());
                </c:if>
            </c:forEach>
           map.fitBounds(bounds);
           google.maps.event.addListener(map, "bounds_changed", function(){
               $('#x1').val(map.getBounds().getNorthEast().lat());
               $('#y1').val(map.getBounds().getNorthEast().lng());
               $('#x2').val(map.getBounds().getSouthWest().lat());
               $('#y2').val(map.getBounds().getSouthWest().lng());
               //$('#mapenabled').attr("checked", "checked");
           });
        });
            </script>

		<script>
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
	</c:param>
</c:import>
<script type="text/javascript">
	function ans() {
		val1 = $("input[name='answer']:checked").val();
		if (val1 == "1") {

			document.getElementById("q1").style.display = "none";
			document.getElementById("correct").style.display = "block";
			
			//document.getElementById("gname").innerHTML = id;
			//getauthor
			//<c:url value="/quiz/mysave" var="quiz" />
			//$.ajax({
			//	type : "POST",
			//	url : "${quiz}",
			//	data : {
			//		groupid : groupid
			//	},
			//	success : function(msg) {

//				},
	//			error : function() {
		//			alert("failure");
			//	}
			//});
			
			
			//document.getElementById("Center").style.display = "block";
		} else {
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss").style.display = "block";
			//document.getElementById("Center").style.display = "block";
		}
	}
	
	//Too easy selection
	function anstate1() {
		val1 = $("input[name='answer']:checked").val();
		if (val1 == "1") {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("correct").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"0",
					answertype:"0"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		} else {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"0",
					answertype:"1"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		}
	}
	
	//easy selection
	function anstate2() {
		val1 = $("input[name='answer']:checked").val();
		if (val1 == "1") {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("correct").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"1",
					answertype:"0"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		} else {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"1",
					answertype:"1"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		}
	}
	
	//General selection
	function anstate3() {
		val1 = $("input[name='answer']:checked").val();
		if (val1 == "1") {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("correct").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"2",
					answertype:"0"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		} else {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"2",
					answertype:"1"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		}
	}
	
	//Difficult selection
	function anstate4() {
		val1 = $("input[name='answer']:checked").val();
		if (val1 == "1") {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("correct").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"3",
					answertype:"0"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		} else {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"3",
					answertype:"1"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		}
	}
	
	//Too difficult selection
	function anstate5() {
		val1 = $("input[name='answer']:checked").val();
		if (val1 == "1") {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("correct").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"4",
					answertype:"0"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		} else {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"4",
					answertype:"1"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		}
	}
	
	function ans2state1() {
		val1 = $("input[name='answer']:checked").val();
		
		if (val1 == "1") {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("correct2").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"0",
					answertype:"0"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		} else {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss2").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"0",
					answertype:"1"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		}
		

	}
	
	function ans2state2() {
		val1 = $("input[name='answer']:checked").val();
		
		if (val1 == "1") {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("correct2").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"1",
					answertype:"0"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		} else {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss2").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"1",
					answertype:"1"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		}
		

	}
	
	
	function ans2state3() {
		val1 = $("input[name='answer']:checked").val();
		
		if (val1 == "1") {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("correct2").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"2",
					answertype:"0"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		} else {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss2").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"2",
					answertype:"1"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		}
		

	}
	
	
	function ans2state4() {
		val1 = $("input[name='answer']:checked").val();
		
		if (val1 == "1") {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("correct2").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"3",
					answertype:"0"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		} else {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss2").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"3",
					answertype:"1"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		}
		

	}
	
	
	function ans2state5() {
		val1 = $("input[name='answer']:checked").val();
		
		if (val1 == "1") {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("correct2").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"4",
					answertype:"0"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		} else {
			var itemid;
			var authorid;
			var place;
			var placeattribute;
			var answerstate;
			var answertype;
			var quizid;
			document.getElementById("q1").style.display = "none";
			document.getElementById("miss2").style.display = "block";
			<c:forEach items="${quizzes}" var="choice" varStatus="status">
			<c:if test="${choice.answer==1}">
			quizid="${choice.id}";
			itemid="${choice.itemid}";
			authorid="${choice.authorid}";
			</c:if>
		    </c:forEach>
			console.log(itemid);
			
			<c:url value="/quiz/mysave" var="quiz" />
			$.ajax({
				type : "POST",
				url : "${quiz}",
				data : {
					quizid : quizid,
					itemid : itemid,
					place : "${place}",
					answerstate:"4",
					answertype:"1"
				},
				success : function(msg) {

				},
				error : function() {
					alert("failure");
				}
			});

		}
		

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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
<script type="text/javascript">
			$(document).ready(function() {
				document.getElementById("quiz").className = "active";
				document.getElementById("correct").style.display = "none";
				document.getElementById("miss").style.display = "none";
				document.getElementById("correct2").style.display = "none";
				document.getElementById("miss2").style.display = "none";
				//document.getElementById("Center").style.display = "block";
			});
		</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Quiz</title>
</head>




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
					<h1 class="page-header">Question</h1>

				</div>
			</div>



			<div class="row">
				<div class="col-lg-5">
					<div id="q1">
						<c:if test="${mqtype==1}">

							<div
								style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-bottom: 10px;">
								<img src="<c:url value='/images/system-help.png' />" alt="●" />&nbsp;Do
								you remember ?
							</div>
							<div id="ttsTitleArea" style="height: 0; width: 0"></div>
							<div id="ttsTitle" style="height: 0; width: 0"></div>
							<c:forEach items="${quizzes}" var="choice" varStatus="status">

								<c:choose>
									<c:when test="${not empty choice.image}">
										<center>
											<img alt=""
												src="${staticserverUrl}/${projectName}/${choice.image}_320x240.png"
												style="width: 200; height: 200px;" />&nbsp;
										</center>
									</c:when>
									<c:otherwise>
										<center>
											<img style="width: 200; height: 200px;" alt=""
												src="<c:url value="/images/no_image.gif" />" /> &nbsp;
										</center>
									</c:otherwise>
								</c:choose>
								<br>
								<br><center>
								<button
									onclick="speak('${choice.content}','${choice.lan_code}');return false;">
									<img src="<c:url value='/images/speaker.png' />" />
								</button>&nbsp;Study
											&nbsp;&nbsp;${choice.content}

											&nbsp;
												<button
									onclick="speak('${title.content}','${title.language.code}');return false;">
									<img src="<c:url value='/images/speaker.png' />" />
								</button>&nbsp;Native
											&nbsp;&nbsp;<a href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a></center>
							</c:forEach>
							<br>
							<div
								style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-top: 10px;">
								<img src="<c:url value='/images/system-help.png' />" alt="●" />&nbsp;Do
								you remember learning location?
							</div>
							<center>
								<div id="searchMap" style="width: 70%; height: 250px;"></div>
							</center>
							<br>
							<div style="margin-top: 10px; text-align: center">
								<input type="submit" class="btn btn-primary" value="Yes"
									onclick="location.href='<c:url value="/quiz/myquiz?lat=${lat}&lng=${lng}&season=${season}&timezone=${timezone}&place=${place}" />'" /> <input
									type="submit" class="btn btn-warning" value="No"
									onclick="location.href='<c:url value="/quiz/myquiz?lat=${lat}&lng=${lng}&season=${season}&timezone=${timezone}&place=${place}" />'" />
							</div>
							<br>
							<br>
						</c:if>
						<c:if test="${mqtype==2}">

							<div
								style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-bottom: 10px;">
								<img src="<c:url value='/images/system-help.png' />" alt="●" />Select
								the right word
								<c:forEach items="${quizzes}" var="choice" varStatus="status">
									<c:if test="${choice.answer==1}">
										<font color="red"><u>${choice.mycontent}</u></font>
									</c:if>
								</c:forEach>
								?
							</div>

							<table style="border-style: none;">
								<c:forEach items="${quizzes}" var="choice" varStatus="status">
									<ul
										style="list-style-image:url('<c:url value='/images/icon_arrow_2.gif' />');margin: 3px 20px; line-height: 30px;font-family: arial,meiryo,simsun,sans-serif; font-weight:bold; font-size: 18px; overflow: visible; color: green; vertical-align: baseline">
										<li><input type="radio" name="answer"
											value="${choice.answer}" />&nbsp;&nbsp;${choice.content}</li>
										<br>
									</ul>
								</c:forEach>
							</table>


							<div id="quizselect">
								<br /> 
								    <input type="button" class="btn btn-primary"
									value="Too easy" onClick="anstate1()" /> 
									<input type="button"
									class="btn btn-success" value="Easy" onclick="anstate2()" /> 
									<input type="button" class="btn btn-warning" value="General"
									onclick="anstate3()" /> 
									<input type="button" class="btn btn-defalt" value="difficult"
									onclick="anstate4()" /> 
									<input type="button" class="btn btn-danger"
									value="Too difficult" onclick="anstate5()" />
							</div>
							<br>
							<br>
						</c:if>
						<c:if test="${mqtype==3}">

							<div
								style="font-family: arial, meiryo, simsun, sans-serif; font-size: 22px; font-weight: bold; color: gray; margin-bottom: 10px;">
								<img src="<c:url value='/images/system-help.png' />" alt="●" />Which
								image can be linked to
								<c:forEach items="${quizzes}" var="choice" varStatus="status">
									<c:if test="${choice.answer==1}">
										<font color="red"><u>${choice.content}</u></font>
									</c:if>
								</c:forEach>
								?
							</div>


							<div style="display: table; width: 100%;">
								<c:forEach items="${quizzes}" var="choice" varStatus="status">
									<c:if test="${status.index==0}">


										<div
											style="display: table-cell; width: 50% px; margin-bottom: 0px;">
											<input type="radio" name="answer" value="${choice.answer}" />&nbsp;&nbsp;<img
												alt=""
												src="${staticserverUrl}/${projectName}/${choice.image}_320x240.png"
												style="width: 80%; height: 200px; margin-left: 10px" />
										</div>
									</c:if>
									<c:if test="${status.index==1}">

										<div
											style="display: table-cell; width: 50% px; margin-bottom: 0px;">
											<input type="radio" name="answer" value="${choice.answer}" />&nbsp;&nbsp;<img
												alt=""
												src="${staticserverUrl}/${projectName}/${choice.image}_320x240.png"
												style="width: 80%; height: 200px; margin-left: 10px" />
										</div>
									</c:if>
							
								<c:if test="${status.index==2}">
								</div>
								<br>
							<div style="display: table; width: 100%;">

									<div style="display: table-cell; width: 50%">
										<input type="radio" name="answer" value="${choice.answer}" />&nbsp;&nbsp;<img
											alt=""
											src="${staticserverUrl}/${projectName}/${choice.image}_320x240.png"
											style="width: 80%; height: 200px; margin-left: 10px" />
									</div>


								</c:if>
								<c:if test="${status.index==3}">

									<div style="display: table-cell; width:50%">
										<input type="radio" name="answer" value="${choice.answer}" />&nbsp;&nbsp;<img
											alt=""
											src="${staticserverUrl}/${projectName}/${choice.image}_320x240.png"
											style="width: 80%; height: 200px; margin-left: 10px" />
									</div>


								</c:if>

								</c:forEach>
							</div>
							<div id="quizselect">
								<br /> <input type="button" class="btn btn-primary"
									value="Too easy" onClick="ans2state1()" /> <input type="button"
									class="btn btn-success" value="Easy" onclick="ans2state2()" /> 
									<input
									type="button" class="btn btn-default" value="General"
									onclick="ans2state3()" />
									<input
									type="button" class="btn btn-warning" value="Difficult"
									onclick="ans2state4()" /> <input type="button"
									class="btn btn-danger" value="Too difficult"
									onclick="ans2state5()" />
							</div>
							<br>
							<br>
						</c:if>
						<c:if test="${mqtype==4}">
							<div class="moreInfo">
								<ul style="margin-top: 40px">
									<li><font size="4"><b>You have finished all the
												quizzes. Please upload more! or Let's play tommorow!</b></font></li>
								</ul>
							</div>
						</c:if>
					</div>


					<div id="correct" style="display: none">
						<br> <span
							style="word-break: normal; color: green; font-size: 17px">
							<img src="<c:url value='/images/quiz_rabit/rabit/blush.png' />"
							alt="" /><b>Very good!! Your answer is right! You can
								challenge more! </b>
						</span> <br> <br> <br>
						
						<c:forEach items="${quizzes}" var="choice" varStatus="status">
							<table style="line-height: 1.33em; border-collapse: collapse;"
								cellspacing="1″ cellpadding="5″>
								<tbody>
									<tr>
										<c:choose>
											<c:when test="${choice.answer==1}">
												<td rowspan="3"><img alt=""
													src="<c:url value='/images/cans.png' />"
													style="width: 100px; height: 100px; margin-left: 10px" />&nbsp;</td>
											</c:when>
											<c:otherwise>
												<td rowspan="3"><img alt=""
													src="<c:url value='/images/fans.png' />"
													style="width: 100px; height: 100px; margin-left: 10px" />&nbsp;</td>
											</c:otherwise>
										</c:choose>


									</tr>
									<tr>
										<td>Study</td>
										<td>&nbsp;
											<button
												onclick="speak('${choice.content}','${choice.lan_code}');return false;">
												<img src="<c:url value='/images/speaker.png' />" />
											</button>&nbsp;${choice.content}
										</td>

									</tr>
									<tr>

										<td>Native</td>
										<td>&nbsp;
											<button
												onclick="speak('${choice.content}','${choice.lan_code}');return false;">
												<img src="<c:url value='/images/speaker.png' />" />
											</button>&nbsp;<a href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
										</td>

									</tr>



								</tbody>
							</table>
							<br>
						</c:forEach>
						<div style="margin-top: 10px;">
							<a href="<c:url value="/quiz/myquiz" />"> </a>
						</div>
						<div style="text-align: center">
							<input type="button" class="btn-primary" value="More Quiz"
								onclick="location.href='<c:url value="/quiz/myquiz?lat=${lat}&lng=${lng}&season=${season}&timezone=${timezone}&place=${place}" />'" />
						</div>
						<br> <br>
					</div>

					<div id=miss style="display: none">
						<br> <span
							style="word-break: normal; color: green; font-size: 18px">
							<img src="<c:url value='/images/quiz_rabit/rabit/scared.png' />"
							alt="" /><b>Sorry, your answer is not right.The right answer
								is:<c:forEach items="${quizzes}" var="choice" varStatus="status">
									<c:choose>
										<c:when test="${choice.answer==1}">${status.index+1}</c:when>
									</c:choose>
								</c:forEach>
						</b>
						</span> <br> <br> <br>
						<c:forEach items="${quizzes}" var="choice" varStatus="status">
							<table style="line-height: 1.33em; border-collapse: collapse;"
								cellspacing="1″ cellpadding="5″>
								<tbody>
									<tr>
										<c:choose>
											<c:when test="${choice.answer==1}">
												<td rowspan="3"><img alt=""
													src="<c:url value='/images/cans.png' />"
													style="width: 100px; height: 100px;" />&nbsp;</td>
											</c:when>
											<c:otherwise>
												<td rowspan="3"><img alt=""
													src="<c:url value='/images/fans.png' />"
													style="width: 100px; height: 100px;" />&nbsp;</td>
											</c:otherwise>
										</c:choose>


									</tr>
									<tr>
										<td>Study</td>
										<td>&nbsp;
											<button
												onclick="speak('${choice.content}','${choice.lan_code}');return false;">
												<img src="<c:url value='/images/speaker.png' />" />
											</button>&nbsp;${choice.content}
										</td>

									</tr>
									<tr>

										<td>Native</td>
										<td>&nbsp;
											<button
												onclick="speak('${choice.content}','${choice.lan_code}');return false;">
												<img src="<c:url value='/images/speaker.png' />" />
											</button>&nbsp;<a href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
										</td>

									</tr>



								</tbody>
							</table>
							<br>
						</c:forEach>
						<div style="margin-top: 10px;">
							<a href="<c:url value="/quiz/myquiz" />"> </a>
						</div>
						<div style="text-align: center">
							<input type="button" class="btn-primary" value="More Quiz"
								onclick="location.href='<c:url value="/quiz/myquiz?lat=${lat}&lng=${lng}&season=${season}&timezone=${timezone}&place=${place}" />'" />
						</div>
						<br> <br>
					</div>

					<div id="correct2" style="display: none">
						<br> <span
							style="word-break: normal; color: green; font-size: 17px">
							<img src="<c:url value='/images/quiz_rabit/rabit/happy.png' />"
							alt="" /><b>Very good!! Your answer is right! You can
								challenge more! </b>
						</span> <br> <br> <br>
						<c:forEach items="${quizzes}" var="choice" varStatus="status">
							<table style="line-height: 1.33em; border-collapse: collapse;"
								cellspacing="1″ cellpadding="5″>
								<tbody>
									<tr>
										<c:choose>
											<c:when test="${choice.answer==1}">
												<td rowspan="3"><img alt=""
													src="<c:url value='/images/cans.png' />"
													style="width: 100px; height: 100px;" />&nbsp;</td>
											</c:when>
											<c:otherwise>
												<td rowspan="3"><img alt=""
													src="<c:url value='/images/fans.png' />"
													style="width: 100px; height: 100px;" />&nbsp;</td>
											</c:otherwise>
										</c:choose><c:if test="${not empty choice.image}">
										<td rowspan="3"><img alt=""
											src="${staticserverUrl}/${projectName}/${choice.image}_320x240.png"
											style="width: 100px; height: 100px" />&nbsp;</td></c:if>

									</tr>
									<tr>
										<td>Study</td>
										<td>&nbsp;
											<button
												onclick="speak('${choice.content}','${choice.lan_code}');return false;">
												<img src="<c:url value='/images/speaker.png' />" />
											</button>&nbsp;${choice.content}
										</td>

									</tr>
									<tr>

										<td>Native</td>
										<td>&nbsp;
											<button
												onclick="speak('${choice.content}','${choice.lan_code}');return false;">
												<img src="<c:url value='/images/speaker.png' />" />
											</button>&nbsp;<a href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
										</td>

									</tr>



								</tbody>
							</table>
							<br>
						</c:forEach>
						<div style="margin-top: 10px;">
							<a href="<c:url value="/quiz/myquiz" />"> </a>
						</div>
						<div style="text-align: center">
							<input type="button" class="btn-primary" value="More Quiz"
								onclick="location.href='<c:url value="/quiz/myquiz?lat=${lat}&lng=${lng}&season=${season}&timezone=${timezone}&place=${place}" />'" />
						</div>
						<br> <br>
					</div>

					<div id=miss2 style="display: none">
						<br> <span
							style="word-break: normal; color: green; font-size: 18px">
							<img src="<c:url value='/images/quiz_rabit/rabit/sad.png' />"
							alt="" /><b>Sorry, your answer is not right.The right answer
								is:<c:forEach items="${quizzes}" var="choice" varStatus="status">
									<c:choose>
										<c:when test="${choice.answer==1}">${status.index+1}</c:when>
									</c:choose>
								</c:forEach>
						</b>
						</span> <br> <br> <br>
						<c:forEach items="${quizzes}" var="choice" varStatus="status">
							<table style="line-height: 1.33em; border-collapse: collapse;"
								cellspacing="1″ cellpadding="5″>
								<tbody>
									<tr>
										<c:choose>
											<c:when test="${choice.answer==1}">
												<td rowspan="3"><img alt=""
													src="<c:url value='/images/cans.png' />"
													style="width: 100px; height: 100px;" />&nbsp;</td>
											</c:when>
											<c:otherwise>
												<td rowspan="3"><img alt=""
													src="<c:url value='/images/fans.png' />"
													style="width: 100px; height: 100px" />&nbsp;</td>
											</c:otherwise>
										</c:choose>
<c:if test="${not empty choice.image}">
										<td rowspan="3"><img alt=""
											src="${staticserverUrl}/${projectName}/${choice.image}_320x240.png"
											style="width: 100px; height: 100px" />&nbsp;</td></c:if>
									</tr>
									<tr>
										<td>Study</td>
										<td>&nbsp;
											<button
												onclick="speak('${choice.content}','${choice.lan_code}');return false;">
												<img src="<c:url value='/images/speaker.png' />" />
											</button>&nbsp;${choice.content}
										</td>

									</tr>
									<tr>

										<td>Native</td>
										<td>&nbsp;
											<button
												onclick="speak('${choice.content}','${choice.lan_code}');return false;">
												<img src="<c:url value='/images/speaker.png' />" />
											</button>&nbsp;<a href="<c:url value="/item/${choice.itemid}"/>">${choice.mycontent}</a>
										</td>

									</tr>



								</tbody>
							</table>
							<br>
						</c:forEach>
						<div style="margin-top: 10px;">
							<a href="<c:url value="/quiz/myquiz" />"> </a>
						</div>
						<div style="text-align: center">
							<input type="button" class="btn-primary" value="More Quiz"
								onclick="location.href='<c:url value="/quiz/myquiz?lat=${lat}&lng=${lng}&season=${season}&timezone=${timezone}&place=${place}" />'" />
						</div>
						<br> <br>

					</div>


				</div>

				<!-- 
				<div class="navbar navbar-inner" style="position: static;">
					<div class="navbar-primary">
						<h3
							style="font-size: 14px; font-weight: bolder; line-height: 150%">Ancillary
							Material</h3>

					</div>
				</div>
				<c:forEach items="${materials}" var="sentence" varStatus="status">

					<li><font size="4">${sentence.def}</font></li>
				</c:forEach>
-->
			</div>


			<!-- /.row -->

		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- /#page-wrapper -->

</div>



</html>