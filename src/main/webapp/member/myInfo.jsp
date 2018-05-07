<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	
	var certifi = 0;
	var checkphone = 0;
	
	$(function(){
	
		$("#pwModifyBtn").click(function(){
			$("#pwForm p").show();
		});
		
		$("#pwModify").click(function(){
			var id = "${memberDTO.id}";
			var pw = $("#pw").val();
			var newPw1 = $("#newPw1").val();
			var newPw2 = $("#newPw2").val();
			var reg_pw = /^.*(?=.{8,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).*$/;
			
			if(pw!="" && newPw1==newPw2 && reg_pw.test(newPw1) && reg_pw.test(newPw2)){
				$.ajax({
					type : "post",
					data : {"id" : id,
							"pw" : pw,
							"newPw1" : newPw1},
					dataType : "json",
					url : "modifyPw.do",
					success : function(data){
						if(data.result=="1"){
							alert("비밀번호가 변경되었습니다.");
						}else{
							alert("비밀번호 변경에 실패했습니다.");
						}
					},error : function(){
						alert("error");
					}
				});
			}else if(newPw1!=newPw2){
				alert("비밀번호와 비밀번호 확인값이 다릅니다.");
				$("#newPw2").focus();
			}else if(newPw1==""){
				alert("변경할 비밀번호를 입력해주세요.");
				$("#newPw1").focus();
			}else if(newPw2==""){
				alert("비밀번호 확인값을 입력해주세요.");
				$("#newPw2").focus();
			}else if(pw==""){
				alert("현재 비밀번호를 입력해주세요.");
				$("#pw").focus();
			}else if(!reg_pw.test(newPw1)){
				alert("변경할 비밀번호 형식을 제대로 입력해주세요.");
				$("#newPw1").focus();
			}else if(!reg_pw.test(newPw2)){
				alert("비밀번호 확인값의 형식을 제대로 입력해주세요.");
				$("#newPw2").focus();
			}
			
		});
		
		$("#certifiBtn").click(function(){
			
			var id = "${memberDTO.id}";
			var phone = $("#phone").val();
			var reg_phone = /(01[016789])[-](\d{4}|\d{3})[-]\d{4}$/g; 
			
			$("#certifiP").show();
			
			if(phone!="" && reg_phone.test(phone)){
				checkphone = 1;
				certifi = 0;
				$("#code_confirm").attr("value", "인증");
				$("#code_confirm").removeAttr("disabled");
				$.ajax({
					type : "post",
					data : {"id" : id,
							"phone" : phone},
					dataType : "json",
					url : "certifi_request.do",
					success : function(data){
						if(data.result=="success"){
							
						}
					},error : function(){
						alert("sms전송실패");
					}
				});
			}else if(phone=="" || reg_phone.test(phone)){
				alert("휴대폰 번호를 정확히 입력해주세요.");
				checkphone = 0;
			}
			
		});
		
		$("#certifiConfirm").click(function(){
			var inputKey = $("#inputKey").val();
			
			if($("#inputKey").val()!=""){
				$.ajax({
					type : "post",
					data : {"inputKey" : inputKey},
					dataType : "json",
					url : "certifi_confirm.do",
					success : function(data){
						if(data.result=="success"){
							alert("인증에 성공했습니다.");
							certifi = 1;
							$("#certifiConfirm").attr({"value" : "인증성공", "disabled" : "true"});
							$("#certifiBtn").attr("value", "재전송");
						}else{
							alert("인증에 실패했습니다.");
							certifi = 0;
						}
					},error : function(){
						alert("error");
					}
				});
			}else{
				alert("인증번호를 입력해주세요.");
			}
		});
		
		$("#modifyPhoneBtn").click(function(){
			var id = "${memberDTO.id}";
			var phone = $("#newPhone").val();
			var reg_phone = /(01[016789])[-](\d{4}|\d{3})[-]\d{4}$/g;
			
			if(certifi==1 && reg_phone.test(phone)){
				$.ajax({
					type : "post",
					data : {"id" : id,
							"phone" : phone},
					dataType : "json",
					url : "modifyPhone.do",
					success : function(data){
						if(data.result=="1"){
							alert("휴대폰 번호가 변경되었습니다.");
						}else{
							alert("휴대폰 번호 변경에 실패했습니다.");
						}
					},error : function(){
						alert("error");
					}
				});
			}else if(certifi==0){
				alert("휴대폰 인증을 해주세요.");
			}else if(phone==""){
				alert("휴대폰 번호를 입력해주세요.");
			}else if(!reg_phone.test(phone)){
				alert("휴대폰 번호를 정확히 입력해주세요.");
			}
		});
		
		$("#modifyEmailBtn").click(function(){
			var id = "${memberDTO.id}";
			var email = $("#email").val();
			
			if(email!=""){
				$.ajax({
					type : "post",
					data : {"id" : id,
							"email" : email},
					dataType : "json",
					url : "modifyEmail.do",
					success : function(data){
						if(data.result=="1"){
							alert("이메일이 변경되었습니다.");
						}else{
							alert("이메일 변경이 실패했습니다.");
						}
					},error : function(){
						
					}
				});
			}else{
				
			}
		});
		
		$("#newPhone").click(function(){
			$(this).attr("placeholder", "");
		});
		
		$("#newPhone").blur(function(){
			$(this).attr("placeholder", "'-'를 포함하여 입력해주세요");
		});
		
		$("#leave").click(function(){	
			$("#leaveDiv").show();
		});
		
		$("input[value=탈퇴하기]").click(function(){
			var id = "${memberDTO.id}";
			var pw = $("#leavePw").val();
			var reg_pw = /^.*(?=.{8,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*?[#?!@$%^&*-]).*$/;
			
			if(pw!="" && reg_pw.test(pw)){
				$.ajax({
					type : "post",
					data : {"id" : id,
							"pw" : pw},
					dataType : "json",
					url : "deleteMember.do",
					success : function(data){
						if(data.result=="1"){
							alert("탈퇴하였습니다.");
							location.href = "../index.jsp";
						}else{
							alert("탈퇴에 실패했습니다.");
						}
					},error : function(){
						
					}
				});
			}
		});
		
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
	#title{
		margin:70px auto 30px auto;
		width:600px;
		text-align:center;
		font-size:25px;
		}
		
	#leave{float:right;}
	.form{
		width:630px;
		border:1px solid;
		border-bottom:none;
		margin:0 auto;
		font-size:15px;
	}
	
	.info{
		border:1px solid;
		border-top:none;
		border-left:none;
		border-right:none;
		padding-top:15px;
		padding-bottom:15px;
		padding-left:25px;
	}
	label{display:inline-block; width:110px;}
	input{margin-left:8px;}
	span{margin-left:8px;}
	input[type=button]{font-size:12px;}
	
	#pwFormDiv p{margin-top:10px;}
	#phoneDiv p{margin-top:10px; margin-left:105px;}
	input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button {
		-webkit-appearance: none;
		margin: 0;
	}
	::-webkit-input-placeholder{font-family:Jeju Gothic; font-size:11px;}
	
	input[type=password]{font-family:sans-serif;}
	
	li{list-style:none;}
	
	#leaveDiv{
		margin:10px auto;
		width:630px;
		text-align:center;
	}
	
	#leaveDiv p{margin-top:5px; margin-bottom:5px; color:red;}
	
	input[value=탈퇴하기]{vertical-align:middle;}
	input[value=메인으로]{height:30px; width:100px;}
	#mainBtnDiv{
			width:100px;
			margin:20px auto;	
	}
	
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
		background-color:#FAFAFA;
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
	<div class="header_left">
		<a href="#">카테고리</a>&nbsp;｜&nbsp;<a href="#">서비스</a>
	</div>
	<div class="header_right">
		<p>
			<a href="loginForm.do">로그인</a>&nbsp;｜&nbsp;
			<a href="joinForm.do">회원가입</a>&nbsp;｜&nbsp;
			<a href="#">장바구니</a>&nbsp;｜&nbsp;
			<a href="#">고객센터</a>
		</p>
	</div>
</div>
<div id="title"><p id="titleP">회원정보</p><input type="button" value="회원탈퇴" id="leave"></div>
<div class="form">
	<ul>
		<li>
			<div class="info">
				<label for="name">이름</label>
				<input type="text" id="name" value=${memberDTO.name}>
			</div>
		</li>
		<li>
			<div class="info">
				<label for="id">아이디</label>
				<span>${memberDTO.id}</span>
			</div>
		</li>
		<li>
			<div class="info" id="pwFormDiv">
				<label for="pwModifyBtn">비밀번호</label>
				<input type="button" id="pwModifyBtn" value="비밀번호 수정">
				<form action="modifyPw.do" method="post" id="pwForm">
				<p style="display:none;"><label for="pw">현재 비밀번호</label><input type="password" id="pw" name="pw"></p>
				<p style="display:none;"><label for="newPw1">새 비밀번호</label><input type="password" id="newPw1" name="newPw1"></p>
				<p style="display:none;"><label for="newPw2">새 비밀번호 확인</label><input type="password" id="newPw2" name="newPw2"><input type="button" value="수정하기" id="pwModify"></p>
				</form>
			</div>
		</li>
		<li>
			<div class="info" id="phoneDiv">
				<label for="phone">휴대폰</label>
				<input type="text" id="phone" value=${memberDTO.phone}><input type="button" value="수정하기" id="modifyPhoneBtn">
				<input type="button" value="인증번호받기" id="certifiBtn">
				<span style="font-size:10px;">수정하시려면 휴대폰 인증을 해주세요</span>
				<p id="certifiP" style="display:none;"><input type="text" id="newPhone" placeholder="'-'를 포함하여 입력해주세요"><input type="number" id="inputKey"><input type="button" value="인증하기" id="certifiConfirm"></p>
			</div>
		</li>
		<li>
			<div class="info">
				<label for="email">이메일</label>
				<input type="email" id="email" value=${memberDTO.email}><input type="button" value="수정하기" id="modifyEmailBtn">
			</div>
		</li>
		<li>
			<div class="info">
				<label for="branch">지점명</label>
				<span>종로점</span>
			</div>
		</li>
	</ul>
</div>
<div id="leaveDiv" style="display:none;">
	<p>정말 탈퇴 하시겠습니까?</p>
	<p>탈퇴하시려면 비밀번호를 입력해주세요.</p>
	<input type="password" id="leavePw"><input type="button" value="탈퇴하기">
</div>
<div id="mainBtnDiv"><input type="button" value="메인으로"></div>
<%@ include file="/template/footerMember.jsp" %>
</body>
</html>