<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	function checkLogout() {
		if (confirm("로그아웃하시겠습니까?")) {
			location.href = "../member/logout.do";
		}
	}
</script>
<style type="text/css">
.header_wrapper {
	width: 100%;
	height: 100%;
}

.home {
	float: left;
	height: 100%;
}

.account {
	float: right;
	height: 100%;
}

.account a {
	margin-top: 50px;
}
</style>
</head>
<body>
	<div class="header_wrapper">
		<div class="home">
			<a href="main.do">홈</a>
		</div>
		<div class="account">
			<a href="#">내 정보</a> <a href="#" onclick="checkLogout()">로그아웃</a>
		</div>
	</div>
</body>
</html>