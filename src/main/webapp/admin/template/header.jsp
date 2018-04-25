<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.header_wrapper {
	width: 100%;
	height: 100%;
	position: relative;
}

.home {
	position: absolute;
	left: 5px;
	top: 10px;
}

.home .logo {
	width: auto;
	height: 50px;
}

.account {
	position: absolute;
	right: 5px;
	bottom: 5px;
}

.account .myPage {
	width: auto;
	height: 30px;
	margin-right: 5px;
}

.account .logout {
	width: auto;
	height: 30px;
	margin-right: 5px;
}
</style>
<script type="text/javascript">
	$(function() {
		$(".logo").hover(function() {
			$(this).attr("src", "img/home_active.png");
			$(this).css("cursor", "pointer");
		}, function() {
			$(this).attr("src", "img/home_inactive.png");
		});

		$(".logo").click(function() {
			location.href = "main.do";
		});

		$(".myPage").hover(function() {
			$(this).attr("src", "img/user_active.png");
			$(this).css("cursor", "pointer");
		}, function() {
			$(this).attr("src", "img/user_inactive.png");
		});

		$(".logout").hover(function() {
			$(this).attr("src", "img/logout_active.png");
			$(this).css("cursor", "pointer");
		}, function() {
			$(this).attr("src", "img/logout_inactive.png");
		});

		$(".logout").click(function() {
			if (confirm("로그아웃하시겠습니까?")) {
				location.href = "../logout.do";
			}
		});
	});
</script>
</head>
<body>
	<div class="header_wrapper">
		<div class="home">
			<img src="img/home_inactive.png" class="logo">
		</div>
		<div class="account">
			<img src="img/user_inactive.png" class="myPage"> <img src="img/logout_inactive.png" class="logout">
		</div>
	</div>
</body>
</html>