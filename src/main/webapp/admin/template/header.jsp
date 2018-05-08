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

.leftMenu {
	position: absolute;
	left: 5px;
	bottom: 10px;
}

.leftMenu>span.logo {
	position: relative;
}

.leftMenu>span:hover .tooltip_logo {
	visibility: visible;
}

.leftMenu .img_logo {
	width: auto;
	height: 50px;
}

.leftMenu .tooltip_logo {
	visibility: hidden;
	background-color: black;
	color: white;
	text-align: center;
	border-radius: 5px;
	padding: 5px 10px;
	position: absolute;
	left: 120%;
	top: -50%;
	margin-top: -15px;
}

.leftMenu .tooltip_logo::after {
	content: "";
	position: absolute;
	bottom: 0;
	left: -50%;
	margin-left: 3px;
	margin-bottom: 6px;
	border-width: 8px;
	border-style: solid;
	border-color: transparent black transparent transparent;
}

.rightMenu {
	position: absolute;
	right: 5px;
	bottom: 5px;
}

.rightMenu>span.myPage {
	position: relative;
}

.rightMenu>span:hover .tooltip_myPage {
	visibility: visible;
}

.rightMenu .img_myPage {
	width: auto;
	height: 30px;
	margin-right: 5px;
}

.rightMenu .tooltip_myPage {
	visibility: hidden;
	width: 80px;
	background-color: black;
	color: white;
	text-align: center;
	border-radius: 5px;
	padding: 5px 10px;
	position: absolute;
	right: 120%;
	top: -50%;
	margin-top: -5px;
}

.rightMenu .tooltip_myPage::after {
	content: "";
	position: absolute;
	bottom: 0;
	left: 100%;
	margin-bottom: 6px;
	border-width: 8px;
	border-style: solid;
	border-color: transparent transparent transparent black;
}

.rightMenu>span.logout {
	position: relative;
}

.rightMenu>span:hover .tooltip_logout {
	visibility: visible;
}

.rightMenu .img_logout {
	width: auto;
	height: 30px;
	margin-left: 5px;
	margin-right: 5px;
}

.rightMenu .tooltip_logout {
	visibility: hidden;
	width: 80px;
	background-color: black;
	color: white;
	text-align: center;
	border-radius: 5px;
	padding: 5px 10px;
	position: absolute;
	right: 120%;
	top: -50%;
	margin-top: -5px;
}

.rightMenu .tooltip_logout::after {
	content: "";
	position: absolute;
	bottom: 0;
	left: 100%;
	margin-bottom: 6px;
	border-width: 8px;
	border-style: solid;
	border-color: transparent transparent transparent black;
}
</style>
<script type="text/javascript">
	$(function() {
		$(".img_logo").hover(function() {
			$(this).attr("src", "img/GU로고2.jpg");
			$(this).css("cursor", "pointer");
		}, function() {
			$(this).attr("src", "img/GU로고1.jpg");
		});

		$(".img_logo").click(function() {
			sessionStorage.setItem("menuIndex", 0);
			location.href = "main.do";
		});

		$(".img_myPage").hover(function() {
			$(this).attr("src", "img/user_active.png");
			$(this).css("cursor", "pointer");
		}, function() {
			$(this).attr("src", "img/user_inactive.png");
		});

		$(".img_logout").hover(function() {
			$(this).attr("src", "img/logout_active.png");
			$(this).css("cursor", "pointer");
		}, function() {
			$(this).attr("src", "img/logout_inactive.png");
		});

		$(".img_logout").click(function() {
			if (confirm("로그아웃하시겠습니까?")) {
				location.href = "../logout.do";
			}
		});
	});
</script>
</head>
<body>
	<div class="header_wrapper">
		<div class="leftMenu">
			<span class="logo">
				<img src="img/GU로고1.jpg" class="img_logo">
				<span class="tooltip_logo">홈</span>
			</span>
		</div>
		<div class="rightMenu">
			<span class="myPage">
				<img src="img/user_inactive.png" class="img_myPage">
				<span class="tooltip_myPage">마이페이지</span>
			</span>
			<span class="logout">
				<img src="img/logout_inactive.png" class="img_logout">
				<span class="tooltip_logout">로그아웃</span>
			</span>
		</div>
	</div>
</body>
</html>