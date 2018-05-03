<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		
	});
</script>
<style type="text/css">
	/* body css */
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	*{
		margin:0;
		padding:0;
		font-family: 'Jeju Gothic', sans-serif;
		box-sizing:border-box;
	}
	.form{
		width:800px;
		border:1px solid;
		margin:0 auto;
	}
	li{list-style:none;}
	
	/* header css */
	.header{
		height:30px;
		margin:0 auto;
		border-top:1px solid #D8D8D8;
		border-bottom:1px solid #D8D8D8;
		background-color:#FAFAFA;
		font-size:10px;
		width:100%;
		min-width:1300px;
	}
	.header_right{
		float:right;
		padding:10px;
		width:220px;
		margin-right:230px;
	}
	.header_left{
		float:right;
		padding:8px;
		margin-right:600px;
		width:100px;
	}
	.header a:link{color:black; text-decoration:none;}
	.header a:visited{color:black; text-decoration:none;}
	.header a:hover {color:blue; text-decoration:underline;}
	
</style>
</head>
<body>
<div class="header">
	<div class="header_right">
		<p>
			<a href="loginForm.do">로그인</a>&nbsp;｜&nbsp;
			<a href="joinForm.do">회원가입</a>&nbsp;｜&nbsp;
			<a href="#">장바구니</a>&nbsp;｜&nbsp;
			<a href="#">고객센터</a>
		</p>
	</div>
	<div class="header_left">
		<a href="#">카테고리</a>&nbsp;｜&nbsp;<a href="#">서비스</a>
	</div>
</div>
<div class="form">
	<ul>
		<li>
			<div>
				<label for="name">이름</label>
				<input type="text" id="name">
			</div>
		</li>
		<li>
			<div>
				<label for="id">아이디</label>
				<input type="text" id="id">
			</div>
		</li>
		<li>
			<div>
				<label for="pw">비밀번호</label>
				<input type="text" id="pw">
			</div>
		</li>
	</ul>
</div>
</body>
</html>