<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.header_wrapper {
	width: 100%;
	height: 100%;
}

.home {
	float: left;
	width: 20%;
	height: 100%;
	border: 1px solid blue;
	box-sizing: border-box;
}

.home .logo {
	width: auto;
	height: 90%;
	border: 1px solid red;
	box-sizing: border-box;
}

.account {
	float: right;
	width: 30%;
	height: 100%;
	border: 1px solid blue;
	box-sizing: border-box;
}

.account .myPage {
	display: inline;
	width: auto;
	height: 90%;
	border: 1px solid red;
	box-sizing: border-box;
}

.account .logout {
	width: auto;
	height: 90%;
	border: 1px solid red;
	box-sizing: border-box;
}
</style>
<script type="text/javascript">
	$(function() {
		$(".logo").click(function() {
			location.href = "main.do";
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
			<img src="img/home.png" class="logo">
		</div>
		<div class="account">
			<img src="img/user.png" class="myPage"> <img src="img/logout.png" class="logout">
		</div>
	</div>
</body>
</html>