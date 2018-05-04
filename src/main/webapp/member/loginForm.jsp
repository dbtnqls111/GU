<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>로그인폼</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		var num = Math.ceil(Math.random()*3);
		
		$("#banner").attr("src", "../img/banner" + num + ".JPG");
		
		$(".header_left a:eq(0)").click(function(){
			$(".category").toggle();
		});	
		
		document.getElementById("path").value = "${path}";
	});
</script>
<link rel="stylesheet" type="text/css" href="../css/loginForm.css"/>
</head>
<body>
<div class="category">
	<div class="category_top">GU 전체 카테고리</div>
	<div class="category_content">
		<ul>
			<li class="category_title">간편식사</li>
			<li>도시락</li>
			<li>샌드위치/햄버거</li>
			<li>주먹밥/김밥</li>
		</ul>
	</div>
	<div class="category_content" id="category_center">
		<ul>
			<li class="category_title">즉석조리</li>
			<li>튀김류</li>
			<li>베이커리</li>
			<li>즉석커피</li>
		</ul>
	</div>
	<div class="category_content">
		<ul>
			<li class="category_title">과자류</li>
			<li>스낵/비스켓</li>
			<li>빵/디저트</li>
			<li>껌/초콜릿/캔디</li>
		</ul>
	</div>
	<div class="category_content">
		<ul>
			<li class="category_title">음료</li>
			<li>음료</li>
			<li>아이스드링크</li>
			<li>유제품</li>
		</ul>
	</div>
	<div class="category_content" id="category_center">
		<ul>
			<li class="category_title">식품</li>
			<li>가공식사</li>
			<li>안주류</li>
			<li>식재료</li>
		</ul>
	</div>
	<div class="category_content">
		<ul>
			<li class="category_title">생활용품</li>
			<li>취미/레저</li>
			<li>의약외품</li>
			<li>생활잡화</li>
		</ul>
	</div>
	<div class="category_content">
		<ul>
			<li class="category_title">아이스크림</li>
		</ul>
	</div>
	<div class="category_content" id="category_center" style="height:36px;"></div>
</div>
<div class="header">
	<div class="header_left">
		<a href="#">카테고리</a>&nbsp;｜&nbsp;<a href="#">서비스</a>
	</div>
	<div class="header_right">
		<p>
			<a href="#">로그인</a>&nbsp;｜&nbsp;
			<a href="joinForm.do">회원가입</a>&nbsp;｜&nbsp;
			<a href="#">장바구니</a>&nbsp;｜&nbsp;
			<a href="#">고객센터</a>
		</p>
	</div>
</div>
<div class="logo_div">
	<input type="image" src="../img/logo.PNG" onclick="javascript:location.href=/GU/">
</div>
<div class="location_div">
	<a href="../index.jsp">홈</a> &gt; <strong>로그인</strong>
</div>
<div class="login_logo_div">
	<input type="image" src="../img/login_logo.PNG">
</div>
<div class="body">
<form method="post" action="login.do">
	<div class="loginBox">
		<div class="login_div">
			<label for="id"><img src="../img/id.PNG"></label><input type="text" name="id" id="id_input" style="width:153px;"><br>
			<label for="pwd"><img src="../img/pw.PNG"></label><input type="password" name="pw" id="pw_input" size="18px">
		</div>
		<div class="loginbt_div">
			<input type="image" src="../img/loginbt.PNG" id="loginbt" title="로그인">
		</div>
		<div class="option">
			<label for="saveid">
            	<input type="checkbox" class="checkbox" id="saveid" name="saveid" />아이디 저장
			</label>
		</div>
		<div class="menu">
			<p><a href="find_id.jsp">아이디찾기</a>&nbsp;｜&nbsp;<a href="find_pw.jsp">비밀번호찾기</a>&nbsp;｜&nbsp;<a href="joinForm.do">회원가입</a>
		</div>
	</div>	
	<input type="hidden" name="path" id="path" />
</form>
	<div class="bannerBox">
		<a href="#"><img src="../img/banner1.JPG" id="banner"></a>
	</div>
</div>
<%@ include file="/template/footerMember.jsp" %>
</body>
</html>