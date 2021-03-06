<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
var phoneChk1 = 0;
var phoneChk2 = 0;
var certifi = 0;
var selectValue = "phone";
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
		
		$("input[type=radio]").click(function(){
			var select = $(this).attr("value");
			selectValue = select;
			if(select=='phone'){
				$("div.email").hide();
				$("div.phone").show();
			}else{
				$("div.phone").hide();
				$("div.email").show();
			}	
		});
		
		$("#input_code").focus(function(){
			$("#input_code").attr("placeholder", "");
		});
		$("#input_code").blur(function(){
			$("#input_code").attr("placeholder", "인증번호를 입력해 주세요.");
		});
		
		$("#code").click(function(){
			var name = $("#certifiName").val();
			var phone1 = $("#tel4").val();
			var phone2 = $("#tel5").val();
			var phone3 = $("#tel6").val();
			var phone = phone1 + "-" + phone2 + "-" + phone3;
			
			$.ajax({
				type : "post",
				data : {"name" : name,
						"phone" : phone},
				dataType : "json",
				url : "certifiMemCheck.do",
				success : function(data){
					if(data.result=="true"){
						certifi = 0;
						alert("인증번호가 발송 되었습니다.");
						$("#code_confirm").attr("value", "인증");
						$("#code_confirm").removeAttr("disabled");
						$("#a").show();
						$.ajax({
							type : "post",
							data : {"phone" : phone},
							dataType : "json",
							url : "certifi_request.do",
							success : function(data){
								if(data.result=="success"){
									
								}
							},error : function(){
								alert("sms전송실패");
							}
						});
					}else if(data.result=="false"){
						alert("정보를 정확히 입력해주세요.");
					}else if(name==""){
						alert("이름을 입력해 주세요.");
						$("#certifiName").focus();
					}else if(phone1==""){
						alert("핸드폰 번호를 입력해주세요.");
						$("#tel4").focus();
					}else if(phone2==""){
						alert("핸드폰 번호를 입력해주세요.");
						$("#tel5").focus();
					}else if(phone3==""){
						alert("핸드폰 번호를 입력해주세요.");
						$("#tel6").focus();
					}
				},error : function(){
					alert("error");
				}
			});
		});
		
		$("#code_confirm").click(function(){
			var inputKey = $("#input_code").val();
			var name = $("#certifiName").val();
			
			if($("#input_code").val()!=""){
				$.ajax({
					type : "post",
					data : {"inputKey" : inputKey},
					dataType : "json",
					url : "certifi_confirm.do",
					success : function(data){
						if(data.result=="success"){
							alert("인증에 성공했습니다.");
							certifi = 1;
							$("#code_confirm").attr({"value" : "인증성공", "disabled" : "true"});
							$("#code").attr("value", "재전송");
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
	});
	
	function confirm(){
		var name;
		var phone;
		var email;
		var type;
		var reg_mail =/^[_a-zA-Z0-9-]+@[\._a-zA-Z0-9-]+\.[a-zA-Z]+$/;
		var reg_name = /^[가-힣]{2,5}/;
		var popupX = (window.screen.width / 2) - (300 / 2);
		var popupY = (window.screen.height / 2) - (300 / 2);
		
		if( $("#tab1").css("display") != "none" ) {
			
			if(selectValue=="phone"){
				type = "phone";
				var tel1 = $("select[id=tel1]").val();
				name = $("#phone_name").val();
				phone = tel1 + "-" + $("#tel2").val() + "-" + $("#tel3").val();
				
				if($("#tel2").val()!="" && $("#tel3").val()!="" && name!="" && reg_name.test(name)){
					$.ajax({
						type : "post",
						data : {"type" : type,
								"name" : name,
								"phone" : phone},
						dataType : "json",
						url : "findId.do",
						success : function(data){
							var id = data.result;
							if(data.result!="fail"){
								window.open("find_idSuccess.do?id="+id, "", "width=300, height=200, location=no, status=no, scrollbars=no, left="+popupX+", top="+popupY+", screenX="+popupX+", screenY="+popupY);
							}else{
								alert("일치하는 정보가 없습니다.");
							}	
						},error : function(){
							alert("error");
						}
					});
					
				}else if(name=="" || !reg_name.test(name)){
					alert("이름을 제대로 입력해주세요.");
					$("#phone_name").focus();
				}else if($("#tel2").val()==""){
					alert("휴대폰 번호를 입력해주세요.");
					$("#tel2").focus();
				}else if($("#tel3").val()==""){
					alert("휴대폰 번호를 입력해주세요.");
					$("#tel3").focus();
				}
				
			}else{
				type="email";
				name = $("#email_name").val();
				email = $("#email").val();
				
				if(name!="" && email!="" && reg_mail.test(email) && reg_name.test(name)){
					$.ajax({
						type : "post",
						data : {"type" : type,
								"name" : name,
								"email" : email},
						dataType : "json",
						url : "findId.do",
						success : function(data){
							var id = data.result;
							if(data.result!="fail"){
								window.open("find_idSuccess.do?id="+id, "", "width=300, height=200, location=no, status=no, scrollbars=no, left="+popupX+", top="+popupY+", screenX="+popupX+", screenY="+popupY);
							}else{
								alert("일치하는 정보가 없습니다.");
							}	
						},error : function(){
							alert("error");
						}
					});
				}else if(name=="" || !reg_name.test(name)){
					alert("이름을 제대로 입력해주세요.");
					$("#email_name").focus();
				}else if(email=="" || !reg_mail.test(email)){
					alert("이메일을 제대로 입력해주세요.");
					$("#email").focus();
				}
			}
		}else{
			if(certifi==1){
				var name = $("#certifiName").val();
				var phone1 = $("#tel4").val();
				var phone2 = $("#tel5").val();
				var phone3 = $("#tel6").val();
				var phone = phone1 + "-" + phone2 + "-" + phone3;
				
				window.open("findIdAll.do?&name="+name+"&phone="+phone, "", "width=300, height=200, location=no, status=no, scrollbars=no, left="+popupX+", top="+popupY+", screenX="+popupX+", screenY="+popupY);
			}else{
				alert("휴대폰 인증을 해주세요.");
			}
		}
	}
	
	function maxLengthCheck1(object){
		if(object.value.length < 3){
			phoneChk1 = 0;
		}else if(object.value.length > 2){
			phoneChk1 = 1;
		}
	    if (object.value.length > object.maxLength)
	      object.value = object.value.slice(0, object.maxLength);
	  }
	function maxLengthCheck2(object){
		if(object.value.length <= 3){
			phoneChk2 = 0;
		}else if(object.value.length > 3){
			phoneChk2 = 1;
		}
	    if (object.value.length > object.maxLength)
	      object.value = object.value.slice(0, object.maxLength);
	  }
</script>
<link rel="stylesheet" type="text/css" href="../css/find_id.css"/>
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

	<div class="logo_div_top"><img src="../img/find_id.PNG"></div>
	<div class="logo_div_bottom"><img src="../img/faq-icon.png"><img src="../img/txt_id_find.gif" id="txt_id_find"></div>
	<div class="tab_wrap">
			<ul class="tabs">
				<li class="active" type="tab1">등록된 정보로 찾기</li>
				<li type="tab2">휴대폰 인증</li>
			</ul>
			<div class="tab_container">
				<div id="tab1" class="tab_content">
					<p>회원정보에 등록되어있는 정보 중 1가지를 택하여 입력해 주세요.</p>
					<div class="radio"><input type="radio" name="info" value="phone" checked="checked">휴대폰<input type="radio" name="info" value="email">이메일<input type="radio" name="info" value="birth">외국인등록번호</div>
					<div class="phone">
						<div class="name1">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" size="15px" id="phone_name"></div>
						<div class="tel">휴대폰&nbsp; &nbsp;<select id="tel1">
							<option value="010" selected="selected">010
							<option value="011">011
							<option value="016">016
							<option value="017">017
							<option value="018">018
							<option value="019">019
						</select> - <input type="number" id="tel2" maxlength="4" oninput="maxLengthCheck1(this)"> - <input type="number" id="tel3" maxlength="4" oninput="maxLengthCheck2(this)"></div>
					</div>
					<div class="email">
						<div class="name2">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" size="15px" id="email_name"></div>
						<div class="input_email">이메일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="email" size="20px" id="email"></div>
					</div>
				</div>
				<div id="tab2" class="tab_content">
					<p>본인명의의 휴대폰 번호로 가입 여부 및 본인여부를 확인합니다.</p>
					<p>타인명의 휴대폰은 본인인증이 불가합니다.</p>
					<form action="certifi_request.do" method="post" id="certifiForm">
					<div class="phone2">
						<div class="name3">이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" size="15px" name="certifiName" id="certifiName"><input type="button" value="인증번호받기" id="code"></div>
						<div class="tel" style="font-size:12px;">휴대폰&nbsp; &nbsp;<select id="tel4" name="certifiPhone1">
							<option value="010" selected="selected">010
							<option value="011">011
							<option value="016">016
							<option value="017">017
							<option value="018">018
							<option value="019">019
						</select> - <input type="number" id="tel5" maxlength="4" size="10px" name="certifiPhone2" oninput="maxLengthCheck1(this)"> - <input type="number" id="tel6" maxlength="4" size="10px" name="certifiPhone3" oninput="maxLengthCheck2(this)"></div>
					</div>
					</form>
					<form action="certifi_confirm.do" method="post" id="certifiConfirm"><p id="a" style="display:none;"><input type="text" placeholder="인증번호를 입력해 주세요." id="input_code" name="inputKey"><input type="button" value="인증" id="code_confirm"></p></form>
				</div>
				<div class="next"><input type="image" src="../img/confirm.PNG" title="확인" onclick="javascript:confirm()"></div>
			</div>
	</div>
	<%@ include file="/template/footerMember.jsp" %>
</body>
</html>