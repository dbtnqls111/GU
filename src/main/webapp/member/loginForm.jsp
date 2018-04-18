<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인폼</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		var num = Math.ceil(Math.random()*3);
		
		$("#banner").attr("src", "./img/banner" + num + ".JPG");
		
		$(".header_left a:eq(0)").click(function(){
			$(".category").toggle();
		});	
	});
</script>
<link rel="stylesheet" type="text/css" href="css/loginForm.css"/>
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
			<a href="#">회원가입</a>&nbsp;｜&nbsp;
			<a href="#">장바구니</a>&nbsp;｜&nbsp;
			<a href="#">고객센터</a>
		</p>
	</div>
</div>
<div class="logo_div">
	<input type="image" src="./img/logo.PNG">
</div>
<div class="location_div">
	<a href="http://www.naver.com">홈</a> &gt; <strong>로그인</strong>
</div>
<div class="login_logo_div">
	<input type="image" src="./img/login_logo.PNG">
</div>
<div class="body">
<form method="post" action="login.do">
	<div class="loginBox">
		<div class="login_div">
			<label for="id"><img src="./img/id.PNG"></label><input type="text" name="id" id="id_input"><br>
			<label for="pwd"><img src="./img/pw.PNG"></label><input type="password" name="pw" id="pw_input" size="18px">
		</div>
		<div class="loginbt_div">
			<input type="image" src="./img/loginbt.PNG" id="loginbt" title="로그인">
		</div>
		<div class="option">
			<label for="saveid">
            	<input type="checkbox" class="checkbox" id="saveid" name="saveid" />아이디 저장
			</label>
		</div>
		<div class="menu">
			<p><a href="#">아이디찾기</a>&nbsp;｜&nbsp;<a href="#">비밀번호찾기</a>&nbsp;｜&nbsp;<a href="joinForm.do">회원가입</a>
		</div>
	</div>
</form>
	<div class="bannerBox">
		<a href="#"><input type="image" id="banner"></a>
	</div>
</div>

<div class="footer">
	<div class="footer_top">
		<ul>
			<li><img src=""></li>
			<li><img src=""></li>
			<li><img src=""></li>
			<li><img src=""></li>
		</ul>
	</div>
	<div class="footer_bottom">
		<div class="footer_bottom1">
			<p>
				<a href="#">STAFF 구인구직</a>&nbsp;｜&nbsp;
				<a href="#">거래상담</a>&nbsp;｜&nbsp;
				<a href="#">발주 및 배송데이터</a>&nbsp;｜&nbsp;
				<a href="#">전자세금계산서</a>&nbsp;｜&nbsp;
				<a href="#">개인정보처리방침</a>
			</p>
			<p>서울시 강남구 테헤란로 000동(ㅁㄴㅇ)&nbsp;｜&nbsp;TEL : 1234-1234</p>
			<p style="line-height:2px;">COPYRIGHT © BGFretail ALL RIGHT RESERVED.</p>
			<div class="sns_div">
				<a href="http://blog.bgfcu.com/"><img src="./img/footer_blog.gif"></a>
				<a href="https://www.facebook.com/CU.BGFretail.cvs/"><img src="./img/footer_facebook.gif"></a>
				<a href="https://twitter.com/BGFretail"><img src="./img/footer_twitter.gif"></a>
			</div>
		</div>
		<div class="footer_bottom2">
			<p class="footer_bottom2_p" style="color:green; font-size:20px;">고객센터</p>
			<p class="footer_bottom2_p" style="line-height:30px; font-size:30px;">1324-1234</p>
			<p class="footer_bottom2_p" style="line-height:50px; color:#848484; font-size:15px;">365일 24시간 연중무휴</p>
		</div>
		<div class="footer_bottom3">
				<a href="#"><img src="./img/footer_faq.gif" title="자주묻는질문"></a>
				<a href="#"><img src="./img/footer_1x1.gif" title="1:1문의"></a>
				<a href="#"><img src="./img/footer_notice.gif" title="공지사항"></a>
		</div>
	</div>
</div>
</body>
</html>