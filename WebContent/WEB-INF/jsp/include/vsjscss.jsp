<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="projectName" value="${propertyService.projectName}" scope="application" />
<c:set var="staticserverUrl" value="${propertyService.staticserverUrl}" scope="application" />
<c:set var="url">${pageContext.request.requestURL}</c:set>
<c:set var="baseURL" value="${fn:replace(url, pageContext.request.requestURI, pageContext.request.contextPath)}" scope="application" />
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

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/css/learninglog/jquery-ui.css"/>" />
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->



<!-- jQuery -->


<script src="${baseURL}/css/vascorll/top/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="${baseURL}/css/vascorll/top/js/bootstrap.min.js"></script>

<!-- Morris Charts JavaScript -->

<script
	src="${baseURL}/css/vascorll/top/js/plugins/morris/raphael.min.js"></script><!--  
<script
	src="${baseURL}/css/vascorll/top/js/plugins/morris/morris.min.js"></script>
<script
	src="${baseURL}/css/vascorll/top/js/plugins/morris/morris-data.js"></script>-->
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>



<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>

<script type="text/javascript"
	src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.10.0/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.10.0/additional-methods.min.js"></script>

<script type="text/javascript"
	src="<c:url value="/js/jquery/jquery.contextMenu.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/js/jquery/jquery.form.js"/>"></script>
	<script src="${baseURL}/js/highchart/spider/highcharts.js"></script>
<script src="${baseURL}/js/highchart/spider/highcharts-more.js"></script>
<script src="${baseURL}/js/highchart/spider/modules/exporting.js"></script>

</head>
