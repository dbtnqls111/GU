<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>발주 완료</title>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	// alert("${total}중 ${result}건 발주 완료");
	$("#home").click(function() {
		location.href = "${pageContext.request.contextPath}/index.jsp";
	});
	
	$("#homeButton").click(function(){
		location.href = "${pageContext.request.contextPath}/index.jsp";
	});
	
});

</script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderList.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderSuccess.css">

</head>
<body>
<div id="orderWrap">
	<div id="top">
		<div id="top_head"><span id="home">GU</span></div>
		<div id="top_body"><img src="${pageContext.request.contextPath}/img/top_body2.png" id="top_bodyImg"></div>
	</div>
	
	<div id="boxWrap">
		<div id="box">
			<div id="box_top">성공적으로 발주가 완료되었습니다</div>
			<div id="buttonDiv">
				<input type="button" id="homeButton" value="메인화면으로">				
			</div>
		</div>
	</div>
</div>
</body>
</html>