<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 성공 화면</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
	
	});
	function login(){
		window.open("loginForm.do");
		opener.close();
		window.close();
	}
</script>
<style type="text/css">
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	
	*{font-family: 'Jeju Gothic', sans-serif; margin:0; padding:0;box-sizing:border-box;}
	.wrap{margin:0 auto; width:300px; height:200px;}
	.wrap p{font-size:12px; width:150px; height:30px; margin-top:50px; margin-left:80px;}
	#p{font-size:12px; width:250px; height:30px; margin-top:20px; margin-left:23px; color:blue;}
	.wrap input[value=로그인하기]{width:100px; height:30px; margin-top:20px; margin-left:40px;}
	.wrap input[value=닫기]{width:100px; height:30px; margin-left:10px;}
</style>
</head>
<body>
<div class="wrap" id="wrap">
<p>비밀번호 : ${pw}</p>
<input type="button" value="로그인하기" onclick="login()">
<input type="button" value="닫기" onclick="window.close()">
</div>
</body>
</html>