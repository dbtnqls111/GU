<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	var idChk = 0;
	var pwChk1 = 0;
	var pwChk2 = 0;
	var phoneChk1 = 0;
	var phoneChk2 = 0;
	var emailChk1 = 0;
	var emailChk2 = 0;
	var nameChk = 0;
	var branchChk = 0;
	$(function(){
		
		var ph = null;
		
		$("div.input input").focus(function(){
			var select = $(this).attr("id");
			if(select=='phone'){
				/* $("label[for="+select+"]").hide(); */
				$("div#phone_div span").html("&nbsp;&nbsp;-");
				$("input#phone").css("width", "70px");
			}else if(select=='email1' || select=='email2'){
				/* $("label[for=email]").hide(); */
				$(this).css("width", "120px");
			}else{
				ph = $(this).attr("placeholder");
				$(this).attr("placeholder", "");
				$("label[for="+select+"]").hide();
				$(this).css("width", "400px");
			}
		});
		$("div.input input").blur(function(){
			var select = $(this).attr("id");
			if(select=='phone'){
				if($(this).val()==""){
					$("label[for="+select+"]").show();
					$(this).css("width", "150px");
					$("div#phone_div span").html("");
					$("."+select+"_p").html("필수 입력 항목입니다").css("color", "red");	
				}else{
					$(this).css("width", "150px");
					$("."+select+"_p").html("");
				}
			}else if(select=='email1'){
				if($(this).val()=="" || !(/^[\w]{6,12}$/.test($(this).val()))){
					$("label[for=email]").show();
					$(this).css("width", "120px");
					$(".email_p").html("영문자, 숫자, _, 6~12자").css("color", "red");
					emailChk1 = 0;
				}
			}else if(select=='email2'){
				if($(this).val()==""){
					$("label[for=email]").show();
					$(this).css("width", "120px");
					$(".email_p").html("이메일을 입력해주세요").css("color", "red");
					emailChk1 = 0;
				}
			}else if(select=='name'){
				if($(this).val()==""){
					$("label[for="+select+"]").show();
					$(this).attr("placeholder", ph);
					$(this).css("width", "250px");
					$("."+select+"_p").html("필수 입력 항목입니다").css("color", "red");
				}else{
					$("."+select+"_p").html("");
				}
			}else if(select=='id'){
				if($(this).val()==""){
					$("label[for="+select+"]").show();
					$(this).attr("placeholder", ph);
					$(this).css("width", "250px");
					$("."+select+"_p").html("필수 입력 항목입니다").css("color", "red");
				}
			}else if(select=='pw1' || select=='pw2'){
				if($(this).val()==""){
					$("label[for="+select+"]").show();
					$(this).attr("placeholder", ph);
					$(this).css("width", "250px");
					$("."+select+"_p").html("필수 입력 항목입니다").css("color", "red");
				}
			}
		});
		$("#select_email").change(function(){
			var select = $(this).val();
			var email1 = $("#email1").val();
			
			var reg_mail =/^[_a-zA-Z0-9-]+@[\._a-zA-Z0-9-]+\.[a-zA-Z]+$/;
			
			if(select==""){
				$(".email2").val(select);
				$(".email_p").html("필수 입력 항목입니다").css("color", "red");
				emailChk1 = 0;
				emailChk2 = 0;
			}else{
				$(".email2").val(select);
				var email = email1 + "@" + $("#email2").val();
				$.ajax({
					type : "post",
					data : {"email" : email},
					dataType:"json",
					url : "isExistEmail.do",
					success : function(data){
						if(email1!="" && $("email2").val()!="" && !reg_mail.test(email)){
							$(".email_p").html("이메일 형식을 정확히 입력해주세요").css("color", "red");
							emailChk1 = 0;
						}else if(email1!="" && $("email2").val()!="" && data.emailChk=="true"){
								$(".email_p").html("사용가능한 이메일 입니다").css("color", "blue");
								emailChk1 = 1;
								emailChk2 = 1;
						}else if(email1!="" && $("email2").val()!="" && data.emailChk=="false"){
							$(".email_p").html("이미 사용중인 이메일입니다").css("color", "red");
							emailChk1 = 0;
							emailChk2 = 0;
						}
					},error:function(){
					}
				});
			}	
		});
		
		$("input[value=가입하기]").click(function(){			
			if($("input[name=name]").val()==""||!(/^[가-힣]{2,5}/.test($("input[name=name]").val()))){
				nameChk = 0;
			}else{
				nameChk = 1;
			}
			if($("span#branchSel").text()==""){
				branchChk = 0;
			}else{
				branchChk = 1;
			}
			
			if(idChk==1 && pwChk1==1 && pwChk2==1 && nameChk==1 && phoneChk1==1 && phoneChk2==1 && emailChk1==1 && emailChk2==1 && branchChk==1){
				alert("가입완료");
				$("#form").submit();
			}else if(idChk==0){
				alert("아이디를 정확히 입력해 주세요");
				$("input#id").focus();
			}else if(pwChk1==0){
				alert("비밀번호를 정확히 입력해주세요");
				$("input#pw1").focus();
			}else if(pwChk2==0){
				alert("비밀번호가 같지 않습니다");
				$("input#pw2").focus();
			}else if(nameChk==0){
				alert("이름은 2~5자, 한글로 입력해 주세요");
				$("input[name=name]").focus();
			}else if(phoneChk1==0){
				alert("핸드폰번호를 정확히 입력해주세요");
				$("input[name=phone2]").focus();
			}else if(phoneChk2==0){
				alert("핸드폰번호를 정확히 입력해주세요");
				$("input[name=phone3]").focus();
			}else if(emailChk1==0){
				alert("이메일을 정확히 입력해주세요");
				$("input[name=email1]").focus();
			}else if(emailChk2==0){
				alert("이메일을 정확히 입력해주세요");
				$("input[name=email2]").focus();
			}else if(branchChk==0){
				alert("지점을 선택해 주세요");
				$("input[value=지점찾기]").focus();
			}
		});
		
	});
	
		function checkId(){
			var input =  $('#id').val();
			var reg_id = /^.*(?=.*[0-9])(?=.*[a-z]).*$/;
			$.ajax({
				type : "post",
				data : {"id" : input},
				dataType:"json",
				url : "isExistId.do",
				success : function(data){
					if(input==""){
						$(".id_p").html();
					}else if(input=="">0){
						$(".id_p").html("공백문자는 사용할 수 없습니다").css("color", "red");
						idChk = 0;
					}else if(!(/^[\w]{6,12}$/.test(input)) && !reg_id.test(input)){
						$(".id_p").html("영문자, 숫자, 6자리 이상 12자리 이하").css("color", "red");
						idChk = 0;
					}else if(data.idChk=="true" && reg_id.test(input)){
						$(".id_p").html("사용가능한 아이디입니다").css("color", "blue");
						idChk = 1;
					}else if(data.idChk=="false"){
						$(".id_p").html("이미 사용중인 아이디입니다").css("color", "red");
						idChk = 0;
					}
				},error:function(){
				}
			});
		}
		
		function checkPw(){
			var pw = $("#pw1").val();
			var repw = $("#pw2").val();
			var reg_pw = /^.*(?=.{8,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).*$/;
			if(pw==""){
				$(".pw1_p").html();
			}else if(!reg_pw.test(pw)){
				$(".pw1_p").html("8~15자, 숫자, 특수문자 1개이상이 조합되어야합니다").css("color", "red");
				pwChk1 = 0;
			}else{
				$(".pw1_p").html("사용가능합니다").css("color", "blue");
				pwChk1 = 1;
			}
			
			if(pw != repw && repw!=""){
				$(".pw2_p").html("비밀번호가 일치하지 않습니다").css("color", "red");
				pwChk2 = 0;
			}else if(pw == repw && repw!=""){
				$(".pw2_p").html("비밀번호가 일치합니다").css("color", "blue");	
				pwChk2 = 1;
			}
		}
		
		function rePw(){
			var pw = $("#pw1").val();
			var repw = $("#pw2").val();
			
			if(pw != repw){
				$(".pw2_p").html("비밀번호가 일치하지 않습니다").css("color", "red");
				pwChk2 = 0;
			}else{
				$(".pw2_p").html("비밀번호가 일치합니다").css("color", "blue");
				pwChk2 = 1;
			}
		}
		
		function maxLengthCheck1(object){
			if(object.value.length < 3){
				$(".phone_p").html("3자이상").css("color", "red");
				phoneChk1 = 0;
			}else if(object.value.length > 2){
				$(".phone_p").html(" ");
				phoneChk1 = 1;
			}
		    if (object.value.length > object.maxLength)
		      object.value = object.value.slice(0, object.maxLength);
		  }
		function maxLengthCheck2(object){
			if(object.value.length <= 3){
				$(".phone_p").html("휴대폰 정보를 정확히 입력해주세요").css("color", "red");
				phoneChk2 = 0;
			}else if(object.value.length > 3){
				$(".phone_p").html(" ");
				phoneChk2 = 1;
			}
		    if (object.value.length > object.maxLength)
		      object.value = object.value.slice(0, object.maxLength);
		  }
		
		function checkEmail(){
			var email1 = $("#email1").val();
			var email2 = $("#email2").val();
			var email = email1 + "@" + email2;
			var reg_mail =/^[_a-zA-Z0-9-]+@[\._a-zA-Z0-9-]+\.[a-zA-Z]+$/;
			
			$.ajax({
				type : "post",
				data : {"email" : email},
				dataType:"json",
				url : "isExistEmail.do",
				success : function(data){
					if(email1!="" && email2!="" && !reg_mail.test(email)){
						$(".email_p").html("이메일 형식을 정확히 입력해주세요").css("color", "red");
						emailChk1 = 0;
					}else if(email1!="" && email2!="" && reg_mail.test(email) && data.emailChk=="true"){
							$(".email_p").html("사용가능한 이메일 입니다").css("color", "blue");
							emailChk1 = 1;
							emailChk2 = 1;
					}else if(email1!="" && email2!="" && reg_mail.test(email) && data.emailChk=="false"){
						$(".email_p").html("이미 사용중인 이메일 입니다").css("color", "red");
						emailChk1 = 0;
						emailChk2 = 0;
					}
				},error:function(){
				}
			});
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
	.input_branch{padding:15px 10px 5px 10px; border:1px solid #cbccd6; border-bottom:none;}
	input#id, input#pw1, input#pw2, input#name{height:25px; width:250px; margin-left:10px; border:none;}
	input#pw1, input#pw2{font-family:sans-serif;}
	input#phone{height:25px; width:150px; margin-left:10px; border:none; text-align:center;}
	input#email1, input#email2{height:25px; width:120px; margin-left:10px; border:none;}
	label{color:#babec4;}
	div.phone_div select{height:25px; vertical-align:middle; margin-right:10px; margin-bottom:5px;}
	input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button {
		-webkit-appearance: none;
		margin: 0;
	}
	div.input p, div.input_branch p{font-size:10px; text-align:left; margin-top:10px;}
	::-webkit-input-placeholder{font-family:Jeju Gothic; font-size:11px;}
	#button{margin:30px auto; text-align:center;}
	#button input{height:40px; width:150px; background-color:#42bcf4; cursor:pointer; border-radius:4px; border:none;}
	div#branch_div input{height:30px; width:100px; text-align:center; margin-left:15px;}
	#branchSel{margin-left:15px; border:none;}
	
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
		float:left;
		padding:8px;
		margin-left:350px;
		width:100px;
	}
	a:link{color:black; text-decoration:none;}
	a:visited{color:black; text-decoration:none;}
	a:hover {color:blue; text-decoration:underline;}
		/* footer css */
	a{
		text-decoration:none;
	}
	li{
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
		margin-top:100px;
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
	<form method="post" action="insertMember.do" id="form">
		<div class="joinForm">
		<input type="hidden" value="남" name="gender">
			<ul>
				<li>
					<div id="id_div" class="input">
						<label for="id">ID를 만들어주세요</label>
						<input type="text" id="id" name="id" placeholder="띄어쓰기 없이 영/숫자 8-12자" maxlength="12" oninput="javascript:checkId()">
						<p class="id_p"></p>
					</div>
				</li>
				<li>
					<div id="pw1_div" class="input">
						<label for="pw1">비밀번호 입력</label>
						<input type="password" id="pw1" name="pw" placeholder="8-15자의 숫자 및 특수문자 조합" oninput="javascript:checkPw()">
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
					<div id="name_div" class="input">
						<label for="name">이름</label>
						<input type="text" id="name" name="name" maxlength="12">
						<p class="name_p"></p>
					</div>
				</li>
				<li>
					<div id="phone_div" class="input">
						<label for="phone">휴대폰번호 입력</label>
						<select name="phone1">
							<option value="010" selected="selected">010
							<option value="011">011
							<option value="016">016
							<option value="017">017
							<option value="018">018
						</select>
						<input type="number" id="phone" name="phone2" maxlength="4" oninput="maxLengthCheck1(this)"><span></span>
						<input type="number" id="phone" name="phone3" maxlength="4" oninput="maxLengthCheck2(this)">
						<p class="phone_p"></p>
					</div>
				</li>
				<li>
					<div id="email_div" class="input">
						<label for="email">이메일</label>
						<input type="text" id="email1" name="email1" oninput="checkEmail()"><span>@</span><input type="text" class="email2" id="email2" name="email2" oninput="checkEmail()">
						<select id="select_email" style="margin-left:15px;">
							<option value="">직접입력
							<option value="naver.com">naver.com
							<option value="daum.net">daum.net
							<option value="nate.com">nate.com
						</select>
						<p class="email_p"></p>
					</div>
				</li>
				<li>
					<div id="branch_div" class="input_branch" style="border-bottom:1px solid #cbccd6;">
						<label for="branch">지점선택</label>
						<span id="branchSel"></span><input type="hidden" name="branch">
						<input type="button" value="지점찾기" onclick="window.open('branchList.do?page=1', '지점 목록', 'width=550, height=550, location=no, status=no, scrollbars=no');">
						<p class="branch_p"></p>
					</div>
				</li>
			</ul>
		</div>
	</form>
	<div id="button"><input type="button" value="처음으로" style="margin-right:10px;"
						onclick="location.href='../index.jsp'"><input type="button" value="가입하기" id="join"></div>
</div>
<%@ include file="/template/footerMember.jsp" %>
</body>
</html>