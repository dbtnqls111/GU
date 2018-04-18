<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".tab_content").hide();
		$(".tab_content:first").show();
		
		$("ul.tabs li").click(function(){
			$("ul.tabs li").removeClass("active").css({"color" : "#333"});
			$(this).addClass("active").css("color", "darkred");
			$("ul.tabs li").css("border-bottom", "1px solid #41d0f4");
			$(this).css("border-bottom", "1px solid #ffffff");
			$(".tab_content").hide();
			var num = $(this).attr("type");
			$("#" + num).show();
		});
		
		$("#input_code").focus(function(){
			$("#input_code").attr("placeholder", "");
		});
		$("#input_code").blur(function(){
			$("#input_code").attr("placeholder", "인증번호를 입력해 주세요.");
		});
		
		$("#code").click(function(){
			alert("인증번호가 발송되었습니다. 인증번호를 입력해 주세요.");
			$("#a").show();
		});
	});
</script>
<style type="text/css">
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	
	*{
		margin:0;
		padding:0;
		font-family: 'Jeju Gothic', sans-serif;
		box-sizing:border-box;
	}
	.tab_wrap{
		margin:100px auto;
		width:600px;
	}
	ul.tabs{
		margin:0;
		padding:0;
		float:left;
		list-style:none;
		height:31px;
		width:600px;
		font-size:17px;
		box-sizing:content-box
	}
	ul.tabs li{
		float:left;
		text-align:center;
		cursor:pointer;
		width:300px;
		height:31px;
		line-height:31px;
		border:1px solid #eee;
	}
	.tab_container{
		border:1px solid #41d0f4;
		border-top:none;
		clear:both;
		float:left;
		width:600px;
		background:#ffffff;
	}

	.tab_content{
		padding:5px;
	}
	ul.tabs li.active{
		background:#ffffff;
		border:1px solid #41d0f4;
		border-bottom:1px solid #ffffff;
		color:darkred;
	}
	
	/* content css */
	
	#tab1 {
		font-size:10px;
		text-align:center;
		margin-left:0;
	}
	.radio{
		padding-top:5px;
		padding-right:40px;
		text-align:center;
		margin-bottom:10px;
		margin-top:10px;
	}
	input[type=radio]{
		vertical-align:middle;
		margin:5px 5px 5px 50px;
	}
	.name1{
		margin-bottom:10px;
		margin-left:143px;
		width:200px;
	}
	.name2{
		margin-bottom:10px;
		margin-left:150px;
		width:210px;
	}
	.tel{
		width:300px;
		margin-left:148px;
	}
	.input_email{
		width:300px;
		margin-left:120px;
	}
	.next{
		margin:20px auto;
		width:119px;
	}
	#tab2 p, #tab1 p{
		text-align:center;
		font-size:12px;
		line-height:35px;
	}
	#tab2 div.phone{
		font-size:12px;
	}
	.name3{
		margin-left:150px;
		margin-bottom:10px;
	}
	#code{
		margin-left:10px;
		font-size:11px;
	}
	#input_code{
		 font-size:10px;
		 width:160px;
		 height:20px;
		 margin-top:15px;
		 margin-left:0px;
	}
	#code_confirm{
		font-size:11px;
		height:20px;
		width:50px;
		margin-left:10px;
	}
	/* header css */
	}
	.header a{
		font-size:10px;
	}
	.header{
		height:30px;
		margin:0 auto;
		border-top:1px solid #D8D8D8;
		border-bottom:1px solid #D8D8D8;
		background-color:#FAFAFA;
		font-size:10px;
	}
	.header_left{
		float:left;
		padding:10px;
		margin-left:180px;
	}
	.header_right{
		float:right;
		padding:8px;
		margin-right:20px;
	}
	a:link{color:black; text-decoration:none;}
	a:visited{color:black; text-decoration:none;}
	a:hover {color:blue; text-decoration:underline;}
	
	/* logo css */
	.logo_div_top{
		border-bottom:2px solid black;
		width:600px;
		margin:50px auto 0 auto;
		padding-bottom:10px;
	}
	.logo_div_bottom{
		width:600px;
		margin:15px auto;
	}
	.logo_div_bottom img{
		float:left;
	}
	#txt_id_find{
		margin-top:10px;
		margin-left:10px;
	}
	/* footer css */
	a{
		text-decoration:none;
	}
	li{
		list-style:none;
		display:inline;
	}
	.footer{
		width:100%;
		margin:400px auto 0 auto;
	}
	.footer_top{
		border-top:1px solid #D8D8D8;
		border-bottom:1px solid #D8D8D8;
		height:50px;
		width:100%;
		margin:0 auto;
	}
	.footer_bottom{
		background-color:#F2F2F2;
		height:180px;
		width:100%;
		margin:0 auto;
	}
	.footer_bottom p{
		line-height:30px;
		margin-left:10px;
		font-size:12px;
	}
	.footer_bottom1 a{
		font-weight:bold;
	}
	.footer_bottom1{
		float:left;
		margin-left:100px;
		margin-top:40px;
		width:50%;
	}
	.footer_bottom2{
		border-left:2px solid #D8D8D8;
		float:left;
		margin-top:30px;
		margin-left:60px;
		padding-left:5%;
		width:30%;
	}
	.footer_bottom3{
		width:20%;
		margin-top:35px;
		margin-left:60px;
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
</style>
</head>
<body>
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
<div class="logo_div_top"><img src="../img/find_id.PNG"></div>
<div class="logo_div_bottom"><img src="../img/faq-icon.png"><img src="../img/txt_id_find.gif" id="txt_id_find"></div>
<div class="tab_wrap">
		<ul class="tabs">
			<li class="active" type="tab1">이메일 본인인증</li>
			<li type="tab2">휴대폰 인증</li>
		</ul>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<p>회원님이 가입하신 이메일주소를 통해 비밀번호를 찾을 수 있습니다.</p>
				<div class="name2">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" size="15px"></div>
				<div class="input_email">이메일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="email" size="20px"></div>
			</div>
			<div id="tab2" class="tab_content">
				<p>본인명의의 휴대폰 번호로 가입 여부 및 본인여부를 확인합니다.</p>
				<p>타인명의 휴대폰은 본인인증이 불가합니다.</p>
				<div class="phone">
					<div class="name3">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" size="15px"><input type="button" value="인증번호받기" id="code"></div>
					<div class="tel">휴대폰&nbsp; &nbsp;<select>
						<option value="010">010
						<option value="011">011
						<option value="016">016
						<option value="017">017
						<option value="018">018
						<option value="019">019
					</select> - <input type="text" size="10px"> - <input type="text" size="10px"></div>
				</div>
				<p id="a" style="display:none;"><input type="text" placeholder="인증번호를 입력해 주세요." id="input_code"><input type="button" value="인증" id="code_confirm"></p>
			</div>
			<div class="next"><input type="image" src="../img/confirm.PNG"></div>
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
				<a href="http://blog.bgfcu.com/"><img src="../img/footer_blog.gif"></a>
				<a href="https://www.facebook.com/CU.BGFretail.cvs/"><img src="../img/footer_facebook.gif"></a>
				<a href="https://twitter.com/BGFretail"><img src="../img/footer_twitter.gif"></a>
			</div>
		</div>
		<div class="footer_bottom2">
			<p class="footer_bottom2_p" style="color:green; font-size:20px;">고객센터</p>
			<p class="footer_bottom2_p" style="line-height:30px; font-size:30px;">1324-1234</p>
			<p class="footer_bottom2_p" style="line-height:50px; color:#848484; font-size:15px;">365일 24시간 연중무휴</p>
		</div>
		<div class="footer_bottom3">
				<a href="#"><img src="../img/footer_faq.gif" title="자주묻는질문"></a>
				<a href="#"><img src="../img/footer_1x1.gif" title="1:1문의"></a>
				<a href="#"><img src="../img/footer_notice.gif" title="공지사항"></a>
		</div>
	</div>
</div>
</body>
</html>