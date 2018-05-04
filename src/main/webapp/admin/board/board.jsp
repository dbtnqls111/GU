<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".wrapper").css("width", $(window).width());
		$(".wrapper").css("height", $(window).height());

		// 새로고침시 캐시 사용 안함
		$.ajaxSetup({
			cache : false
		});

		$(".navigator ul li a.board").css("background-color", "#66aaff");
		$(".navigator ul li a.board").css("color", "white");

		var menuIndex = sessionStorage.getItem("menuIndex");

		$(".board_menu:eq(" + menuIndex + ") a").addClass("selected");
		$(".content").load($(".board_menu:eq(" + menuIndex + ") a").attr("href"));

		$(".board_menu a").click(function() {
			$(this).addClass("selected");
			// 현재 페이지의 메뉴 인덱스 저장(새로고침 시 메뉴가 초기화되지 않도록)
			sessionStorage.setItem("menuIndex", $(this).parent(".board_menu").index());

			$(".board_menu a").not(this).removeClass("selected");

			$(".content").load($(this).attr("href"));

			return false;
		});
	});
</script>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<%@ include file="../template/header.jsp"%>
		</div>
		<div class="navigator">
			<%@ include file="../template/navigator.jsp"%>
		</div>
		<div class="sub_nav"></div>
		<div class="body">
			<div class="menu">
				<ul>
					<li class="board_menu">
						<a href="noticeList_admin.do?page=1">공지 사항</a>
					</li>
					<li class="board_menu">
						<a href="boardList_admin.do?page=1">건의 사항</a>
					</li>
				</ul>
			</div>
			<div class="content"></div>
		</div>
	</div>
</body>
</html>