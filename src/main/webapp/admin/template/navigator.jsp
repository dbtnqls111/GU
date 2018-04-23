<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<style type="text/css">
.navigator ul {
	margin: 0;
	padding: 0;
	height: 100%;
	background-color: #c9e1ff;
	overflow: hidden;
}

.navigator ul li {
	float: left;
	list-style: none;
	line-height: 2;
	width: 10%;
	height: 100%;
	text-align: center;
	border-right: 1px solid white;
}

.navigator ul li a {
	text-decoration: none;
	font-size: 18px;
	font-weight: bold;
	color: black;
	padding-top: 3px;
	width: 100%;
	height: 100%;
	display: block;
}

.navigator ul li a:hover {
	background-color: #66aaff;
	color: white;
}
</style>
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".navigator ul li a").click(function() {
			sessionStorage.setItem("menuIndex", 0);
		});
	});
</script>
</head>
<body>
	<ul>
		<li>
			<a href="notice.do" class="notice">공지 사항</a>
		</li>
		<li>
			<a href="register.do" class="register">기초 등록</a>
		</li>
		<li>
			<a href="order.do" class="order">발주 관리</a>
		</li>
		<li>
			<a href="statsByBranch.do" class="statsByBranch">지점별 통계</a>
		</li>
		<li>
			<a href="statsByItem.do" class="statsByItem">품목별 통계</a>
		</li>
	</ul>
</body>
</html>