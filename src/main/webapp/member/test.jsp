<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		var ph = null;
		$("input").focus(function(){
			var select = $(this).attr("id");
			if(select=='phone'){
				$("label[for="+select+"]").hide();
				$("div#phone_div span").html("&nbsp;&nbsp;-");
			}else if(select=='email'){
				$("label[for="+select+"]").hide();
				$("div#email_div span").html("&nbsp;&nbsp;@&nbsp;&nbsp;");
			}else{
				ph = $(this).attr("placeholder");
				$(this).attr("placeholder", "");
				$("label[for="+select+"]").hide();
				$(this).css("width", "400px");
			}
		});
		$("input").blur(function(){
			var select = $(this).attr("id");
			if(select=='phone'){
				$("label[for="+select+"]").show();
				$(this).css("width", "150px");
				$("div#phone_div span").html("");
				$("."+select+"_p").html("필수 입력 항목입니다").css("color", "red");
			}else if(select=='email'){
				$("label[for="+select+"]").show();
				$("div#email_div span").html("");
				$("."+select+"_p").html("필수 입력 항목입니다").css("color", "red");
			}else{
				if($(this).val()==""){
					$("."+select+"_p").html("필수 입력 항목입니다").css("color", "red");
					$("label[for="+select+"]").show();
					$(this).attr("placeholder", ph);
					$(this).css("width", "250px");
				}
			}
		});
		
	});
	
		function checkId(){
			var input =  $('#id').val();
			$.ajax({
				type : "post",
				data : {"id" : input},
				dataType:"json",
				url : "isExistId.do",
				success : function(data){
					if(input==""){
						$(".id_p").html();
					}else if(data.idChk=="true"){
						$(".id_p").html("사용가능한 아이디입니다").css("color", "blue");
					}else if(data.idChk=="false"){
						$(".id_p").html("이미 사용중인 아이디입니다").css("color", "red");
					}
				},error:function(){
				}
			});
		}
		
		function checkPw(){
			var pw = $("#pw1").val();
			var repw = $("#pw2").val();
			var reg_pw = /^.*(?=.{8,15})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
			if(pw==""){
				$(".pw1_p").html();
			}else if(!reg_pw.test(pw)){
				$(".pw1_p").html("8~15자, 특수문자를 사용하세요").css("color", "red");
			}else{
				$(".pw1_p").html("사용가능").css("color", "blue");
			}
			
			if(pw != repw && repw!=""){
				$(".pw2_p").html("비밀번호가 일치하지 않습니다").css("color", "red");
			}else if(pw == repw && repw!=""){
				$(".pw2_p").html("비밀번호가 일치합니다").css("color", "blue");
			}
		}
		
		function rePw(){
			var pw = $("#pw1").val();
			var repw = $("#pw2").val();
			
			if(pw != repw){
				$(".pw2_p").html("비밀번호가 일치하지 않습니다").css("color", "red");
			}else{
				$(".pw2_p").html("비밀번호가 일치합니다").css("color", "blue");
			}
		}
	
</script>
<style type="text/css">
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	*{
		margin:0;
		padding:0;
		font-family: 'Jeju Gothic', sans-serif;
		box-sizing:border-box;
	}
	body{background-color:#F2F2F2;}
	li{list-style:none;}
	.wrap{margin-top:50px;}
	.title_div{width:600px; margin:0 auto 40px auto; text-align:center; font-size:25px;}
	.joinForm{width:600px; margin:0 auto; background-color:white;}
	.input{padding:15px 10px 5px 10px; border:1px solid #cbccd6; border-bottom:none;}
	input#id, input#pw1, input#pw2{height:25px; width:250px; margin-left:10px; border:none;}
	input#pw1, input#pw2{font-family:sans-serif;}
	input#phone{height:25px; width:150px; margin-left:10px; border:none;}
	input#email{height:25px; width:150px; margin-left:10px; border:none;}
	label{color:#babec4;}
	select{height:25px; vertical-align:middle; margin-right:10px; margin-bottom:5px;}
	input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button {
		-webkit-appearance: none;
		margin: 0;
	}
	div.input p{font-size:10px; text-align:left; margin-top:10px;}
	::-webkit-input-placeholder{font-family:Jeju Gothic; font-size:11px;}
	#button{margin:30px auto; text-align:center;}
	#button input{height:40px; width:150px; background-color:#42bcf4; cursor:pointer; border-radius:4px; border:none;}
	
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
<div class="wrap">
	<div class="title_div"><p>회원가입</p></div>
	<div class="joinForm">
		<ul>
			<li>
				<div id="id_div" class="input">
					<label for="id">ID를 만들어주세요</label>
					<input type="text" id="id" placeholder="띄어쓰기 없이 영/숫자 6-10자" oninput="javascript:checkId()">
					<p class="id_p"></p>
				</div>
			</li>
			<li>
				<div id="pw1_div" class="input">
					<label for="pw1">비밀번호 입력</label>
					<input type="password" id="pw1" placeholder="6-15자의 영문 대소문자, 숫자 및 특수문자 조합" oninput="javascript:checkPw()">
					<p class="pw1_p"></p>
				</div>
			</li>
			<li>
				<div id="pw2_div" class="input">
					<label for="pw2">위의 비밀번호를 다시 입력해주세요</label>
					<input type="password" id="pw2" oninput="javascript:rePw()">
					<p class="pw2_p"></p>
				</div>
			</li>
			<li>
				<div id="phone_div" class="input">
					<select>
						<option value="010">010
						<option value="011">011
						<option value="016">016
						<option value="017">017
						<option value="018">018
					</select>
					<label for="phone">휴대폰번호 입력</label>
					<input type="number" pattern="[0-9]" id="phone"><span></span><input type="number" pattern="[0-9]" id="phone">
					<p class="phone_p"></p>
				</div>
			</li>
			<li>
				<div id="email_div" class="input">
					<label for="email">이메일</label>
					<input type="email" id="email" style="width:250px;"><span></span><input type="email" id="email" style="width:100px;">
					<select>
						<option value="">직접입력
						<option value="naver.com">naver.com
						<option value="daum.net">daum.net
						<option value="nate.com">nate.com
					</select>
					<p class="email_p"></p>
				</div>
			</li>
			<li>
				<div id="branch_div" class="input">
					<label for="branch">지점선택</label>
					<select>
						<option></option>
						<option></option>
						<option></option>
					</select>
					<p class="branch_p"></p>
				</div>
			</li>
		</ul>
	</div>
	<div id="button"><input type="button" value="처음으로" style="margin-right:10px;" onclick="location.href='../index.jsp'"><input type="button" value="가입하기"></div>
</div>
</body>
</html>