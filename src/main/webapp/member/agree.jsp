<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>약관동의</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#all_agree").click(function(){
			var chk = $(this).is(":checked");
			
			if(chk){
				$("input[type=checkbox]").prop("checked", true);
			}else{
				$("input[type=checkbox]").prop("checked", false);
			}
		});
		
		$(".header_left a:eq(0)").click(function(){
			$(".category").toggle();
		});
		
		var count = 0;
		
		$("#next").click(function(){
			$("input[name=agree]:checkbox").each(function(){
				if($(this).is(":checked")){
					count = count+1;
				}
			});
			

			if(count!=3){
				alert("GU 회원가입을 위해 필수 동의항목에 모두 동의해주시기 바랍니다.");		
				count=0;		
			}else{
				
				location.href="joinForm.do";
			}
		});
	});
</script>
<style type="text/css">
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	*{
		margin:0;
		padding:0;
		box-sizing:border-box;
	}
	body{
		background-color:#F2F2F2;
		font-family: 'Jeju Gothic', sans-serif;
	}
	.wrap{
		margin:80px auto;
	}
	div.top, div.middle{
		background-color:white;
		width:500px;
		margin:5px auto;
	}
	fieldset li{
		list-style:none;
		font-size:15px;
	}

	li a{
		font-size:10px;
		margin-left:10px;
		vertical-align:middle;
		color:#BDBDBD;
	}
	.header a{
		font-size:10px;
	}
	input[type=checkbox]{
		display:none;
	}
	input[type=checkbox] + label{
		display:inline-block;
		cursor:pointer;
		line-height:30px;
		padding-left:30px;
		margin-left:15px;
		background: url("../img/check.png") left/20px no-repeat;
	}
	input[type=checkbox]:checked + label{
		background-image:url("../img/checked.png");
	}
	fieldset{
		margin-bottom:15px;
		margin-left:10px;
		margin-right:10px;
		padding-top:15px;
		padding-bottom:15px;
		border:1px solid #BDBDBD;
	}
	legend{
		font-size:15px;
		font-weight:bold;
		color:#41d6f4;
	}
	.middle{
		margin-top:5px;
		padding-top:15px;
		padding-bottom:15px;
	}
	.header{
		height:30px;
		margin:0 auto;
		border-top:1px solid #D8D8D8;
		border-bottom:1px solid #D8D8D8;
		background-color:#FAFAFA;
		font-size:10px;
		width:100%;
		min-width:1200px;
	}
	.header_right{
		float:right;
		padding:10px;
		width:220px;
		margin-right:230px;
	}
	.header_left{
		float:left;
		padding:8px;
		margin-left:350px;
		width:100px;
	}
	.header a:link{color:black; text-decoration:none;}
	.header a:visited{color:black; text-decoration:none;}
	.header a:hover {color:blue; text-decoration:underline;}
	.category{
		border:1px solid black;
		width:310px;
		height:210px;
		position:absolute;
		top:30px;
		left:180px;
		background-color:white;
		z-index:100;
		display:none;
	}
	.category li{
		display:block;
		line-height:15px;
	}
	.category_top{
		border-bottom:1px solid #A4A4A4;
		padding:2px;
		font-size:20px;
		text-align:center;
	}
	.category_content{
		width:100px;
		text-align:center;
		padding:5px;
		float:left;
		font-size:11px;
	}
	.category_title{
		font-weight:bold;
		margin-top:3px;
		margin-bottom:3px;
		font-size:15px;
	}
	#category_center{
		border-right:1px solid #A4A4A4;
		border-left:1px solid #A4A4A4;
	}
	.wrap p{
		color:#A4A4A4;
		font-size:10px;
		text-indent:10px;
 	}
	.btn{
		margin:10px auto;
		width:500px;
	}
	.btn #cancel{
		float:left;
	}
	.btn #next{
		float:left;
	}
	div.btn a{
		text-decoration:none;
	}
	div#cancel input[type=button]{
		font-size:15px;
		text-align:center;
		margin-left:95px;
		width:120px;
		height:40px;
		background-color:#82c4ff;
		border-radius:4px;
		border:none;
		cursor:pointer;
		font-family: 'Jeju Gothic', sans-serif;
	}
	div#next input[type=button]{
		font-size:13px;
		text-align:center;
		margin-left:50px;
		width:120px;
		height:40px;
		background-color:#82c4ff;
		border-radius:4px;
		border:none;
		cursor:pointer;
		font-family: 'Jeju Gothic', sans-serif;
	}
	div.btn a:link{color:black; text-decoration:none;}
	div.btn a:visited{color:black; text-decoration:none;}
	
	a:link{color:black; text-decoration:none;}
	a:visited{color:black; text-decoration:none;}
	a:hover {color:blue; text-decoration:underline;}
	
	/* footer css */
	
	#footer_top_wrap ul li{
		list-style:none;
		display:inline;
	}

	.footer{
		width:900px;
		margin:0 auto;
	}
	.footer_top{
		border-top:1px solid #D8D8D8;
		border-bottom:1px solid #D8D8D8;
		height:50px;
		width:100%;
		margin-top:150px;
	}
	.footer_bottom{
		background-color:#f7f8f9;
		height:180px;
	}
	.footer_bottom p{
		line-height:30px;
		margin-left:10px;
		font-size:10px;
	}
	.footer_bottom1 a{
		font-weight:bold;
	}
	.footer_bottom1{
		float:left;
		margin-left:30px;
		margin-top:35px;
		width:410px;
	}
	.footer_bottom2{
		border-left:2px solid #D8D8D8;
		float:left;
		margin-top:30px;
		margin-left:50px;
		padding-left:50px;
	}
	.footer_bottom3{
		width:90px;
		margin-top:35px;
		margin-left:40px;
		float:left;
	}
	.footer_bottom1 .sns_div a{
		margin-left:9px;
	}
	.footer_bottom2_p{
		font-weight:bold;
	}
	.sns_div{
		margin-top:22px;
		width:300px;
	}
	#footer_top_wrap{width:900px; margin:0 auto;}
	.footer_top img{margin-left:40px; margin-top:10px;}
</style>
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
	<div class="header_right">
		<p>
			<a href="loginForm.do">로그인</a>&nbsp;｜&nbsp;
			<a href="#">회원가입</a>&nbsp;｜&nbsp;
			<a href="#">장바구니</a>&nbsp;｜&nbsp;
			<a href="#">고객센터</a>
		</p>
	</div>
	<div class="header_left">
		<a href="#">카테고리</a>&nbsp;｜&nbsp;<a href="#">서비스</a>
	</div>
</div>
<div class="wrap">
		<div style="width:500px; margin:20px auto 20px auto;"><h2 style="text-align:center;">약관동의</h2></div>
		<div style="width:500px; margin:5px auto;"><p style="text-align:center;">구매회원/전자금융서비스 이용약관과 개인정보 수집 및 이용에 동의를 하셔야 회원가입이 가능합니다.</p></div>
	<div class="top">
		<input type="checkbox" id="all_agree"><label for="all_agree">전체동의</label>
	</div>
	
	<div class="middle">
		<div>
			<fieldset>
				<legend>필수 동의항목</legend>
				<ul>
					<li><input type="checkbox" id="c1" name="agree"><label for="c1">GU 구매회원 이용약관</label><a href="#">약관 전체보기</a></li>
					<li><input type="checkbox" id="c2" name="agree"><label for="c2">전자금융서비스 이용약관</label><a href="#">약관 전체보기</a></li>
					<li><input type="checkbox" id="c3" name="agree"><label for="c3">개인정보 수집 및 이용</label><a href="#">내용보기</a></li>
				</ul>
			</fieldset>
		</div>
		
		<div>
			<fieldset>
				<legend>선택 동의항목</legend>
				<ul>
					<li><input type="checkbox" id="c4" name=""><label for="c4">구매회원 이용약관</label><a href="#">약관 전체보기</a></li>
					<li><input type="checkbox" id="c5" name=""><label for="c5">개인정보 제3자 제공동의</label><a href="#">내용보기</a></li>
					<li><input type="checkbox" id="c6" name=""><label for="c6">개인정보 수집 및 이용</label><a href="#">내용보기</a></li>
					<li><input type="checkbox" id="c7" name=""><label for="c7">이메일 수신 동의</label></li>
				</ul>
			</fieldset>
		</div>
		<p>- 할인쿠폰, 특가상품 이벤트 정보를 받아보실 수 있습니다.</p>
		<p style="line-height:20px;">- (단, 거래정보-결제/교환/환불 등과 관련된 내용은 거래안전을 위하여 수신동의 여부와 관계없이 발송됩니다.)</p>
	</div>
	<div style="width:500px; margin:5px auto;"><p style="text-align:center; margin-top:10px;">*선택 동의항목에 동의하지 않으셔도 상품검색 등 일반적인 서비스는 이용하실 수 있습니다.</p></div>
	<div class="btn">
		<div id="cancel"><input type="button" value="처음으로"></div>
		<div id="next"><input type="button" value="동의하고 다음으로"></div>
	</div>
</div>
<%@ include file="/template/footerMember.jsp" %>
</body>
</html>