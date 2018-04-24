<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 화면 메인</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".wrapper").css("width", $(window).width());
		$(".wrapper").css("height", $(window).height());
	});
</script>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<%@ include file="template/header.jsp"%>
		</div>
		<div class="navigator">
			<%@ include file="template/navigator.jsp"%>
		</div>
		<div class="sub_nav"></div>
		<div class="body">새로운 소식 알림!</div>
	</div>
</body>
</html>