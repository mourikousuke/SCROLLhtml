<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>ePub Viewer</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <meta name="apple-mobile-web-app-capable" content="yes">

        <style type="text/css">

          body { /* フレーム外*/
            overflow: auto;
            /*background: #eee;*/
           background-image: url("${baseURL}/images/ebook/wood.jpg");
          }

		  #main {
			/* フレーム周囲 */
		  }

          #wrapper { /* */
            width: 480px;
            height: 640px;
            overflow: hidden;
            border: 1px solid #ccc;
            margin: 28px auto;
            background: #fff;
            border-radius: 20px 5px 5px 20px; /*円形に削る(順に左上、右上、右下、左下)*/
          }

          #area { /* フレーム内 */
            /*background: #ccc;*/
            background-image: url("${baseURL}/images/ebook/book.jpg");
            width: 480px;
            height: 660px;
            margin: -30px auto;

            -moz-box-shadow:      inset 10px 0 20px rgba(0,0,0,.1);
            -webkit-box-shadow:   inset 10px 0 20px rgba(0,0,0,.1);
            box-shadow:           inset 10px 0 20px rgba(0,0,0,.1);

          }

          #area iframe {
            padding: 40px 40px;
          }

          body {
            font-size: 1em;
            line-height: 1.33em;
            font-family: serif;

          }
          h1 {
            text-align: center
            font-size: 1.5em;
            line-height: 1.33em;
            text-align: center;
            padding-bottom: 0em;
            text-align: center;
            text-transform: uppercase;
            font-weight: normal;
            letter-spacing: 4px;
            padding-top: 60px;
          }

          ol {
            width: 350px;
            margin: 50px auto;
            /*font-family: sans-serif;*/
          }

          a {
            font-size: 1.2em;
            line-height: 1.33em;
            color: #000;
          }
        </style>
    </head>
	<c:url value="/ebook" var="ebookPath" />
	<body>
		<div id="main">
			<div id="wrapper">
				<div id="area">
					<h1>ePub Viewer</h1>
					<form:form modelAttribute="eBookSearchForm" action="${ebookPath}/bookselect"><!-- eBookSearchFormを呼ぶ(下記でkeyword要素を更新するため) -->
						<p align="center">
							<form:input path="keyword" />
							<input type="submit" value="Search" />
						</p>
					</form:form>
				</div>
			</div>
		</div>
	</body>
</html>
