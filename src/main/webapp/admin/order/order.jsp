<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 관리</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".wrapper").css("width", $(window).width());
		$(".wrapper").css("height", $(window).height());

		$(".navigator ul li a.order").css("background-color", "#66aaff");
		$(".navigator ul li a.order").css("color", "white");

		$(".order_menu:eq(0) a").addClass("selected");

		$(".order_menu a").click(function() {
			$(this).addClass("selected");

			$(".order_menu a").not(this).removeClass("selected");
		});
	});
</script>
<style type="text/css">
</style>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<%@ include file="../template/header.jsp"%>
		</div>
		<div class="navigator">
			<%@ include file="../template/navigator.jsp"%>
		</div>
		<div class="body">
			<div class="menu">
				<ul>
					<li class="order_menu">
						<a href="#">메뉴1</a>
					</li>
					<li class="order_menu">
						<a href="#">메뉴2</a>
					</li>
					<li class="order_menu">
						<a href="#">메뉴3</a>
					</li>
				</ul>
			</div>
			<div class="content">발주 관리</div>
		</div>
	</div>
</body>
</html>