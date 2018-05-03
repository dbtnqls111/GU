<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		
		sessionStorage.setItem("menuIndex", 0);

		// 새로고침시 캐시 사용 안함
		$.ajaxSetup({
			cache : false
		});
	});
</script>
<style type="text/css">
.body {
	background-color: #e0e0e0;
}

.news_board, .news_order {
	display: inline-block;
	width: 250px;
	height: 350px;
	background-color: white;
	margin: 10px 0 10px 10px;
	padding: 10px 5px;
	text-align: center;
	overflow: hidden;
}

.news_board:hover, .news_order:hover {
	box-shadow: 5px 5px 20px #666;
}

.news_order a:link {
	color: blue;
	text-decoration: none;
}

.news_order a:visited {
	color: blue;
	text-decoration: none;
}

.news_order a:hover {
	color: blue;
	text-decoration: underline;
}

.news_order a:active {
	color: blue;
	text-decoration: underline;
}
</style>
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
		<div class="body">
			<div class="news_board">
				<b>건의 사항 신규 내역</b>
			</div>
			<div class="news_order">
				<b>발주 대기 신규 내역</b>
				<c:forEach var="salesStandBy" items="${salesStandByList}">
					<br>
					<br>
					<a href="order.do">${salesStandBy['salesCode']} : ${salesStandBy['branchName']}</a>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>