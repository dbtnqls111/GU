<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GU</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

var id = "${memId}"
	
if(id=="admin"){
	location.href="admin/main.do";
}
	
	
function search(keyword){
	// http://mwultong.blogspot.com/2006/05/javascript-tools-decodeencode-uri.html 참고
	location.href = "/GU/item/search.do?keyword=" + encodeURIComponent(keyword);
}

$(function(){
	// 검색 처리
	$("#searchField > #searchIcon").click(function(){
		var keyword = $("#searchField > #search").val();
		search(keyword);
	});
	
	$("#searchField #search").keyup(function(event){
		if(event.keyCode == 13){ // 13 == enter
			$("#searchField > #searchIcon").click();
		}
	});
	
	// ---------------------------------------------------------------------------------
	
	var session = "${memName}";
	
	
	if(session!=""){
		$("#loginLi").css("display", "none");
		$("#joinLi").css("display", "none");
		$("#userLi").css("display", "block");
		$("#logoutLi").css("display", "block");
	}else{		
		$("#userLi").css("display", "none");
		$("#logoutLi").css("display", "none");	
		$("#loginLi").css("display", "block");	
		$("#joinLi").css("display", "block");	
	}
	
	$("#boardLi").click(function(){		
		location.href="${pageContext.request.contextPath}/boardList.do?pg=1";
	});
	
	$("#order").click(function(){
		if(session==""){
			alert("로그인 먼저 해주세요.");
			location.href="${pageContext.request.contextPath}/index.jsp";
		}else{
			location.href="${pageContext.request.contextPath}/orderList.do";
		}
	});
	
	$("#orderCurrent").click(function(){
		if(session==""){
			alert("로그인 먼저 해주세요.");
			location.href="${pageContext.request.contextPath}/index.jsp";
		}else{
			location.href="orderCurrent.do";
		}
	});
	
	document.getElementById("path_login").value = location.pathname + location.search;
	document.getElementById("path_logout").value = location.pathname + location.search;
	$("#login").click(function(){
		document.loginForm.submit();
	});
	
	$("#logout").click(function(){
		document.logoutForm.submit();
	});
});

</script>

</head>
<body>
<div id="wrap">
		<div id="top">
			<h1 id="mainLogo">
				<a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/img/GU로고1.jpg" id="GU_logo"></a>
			</h1>
			<fieldset id="searchField">
				<input type="text" id="search" />
				<img src="${pageContext.request.contextPath}/img/search_top.png" id="searchIcon">
			</fieldset>
		</div>
		<div id="menuWrap">
			<fieldset id="menuField">
				<ul id="menuUl">
					<li id="all"><a href="#" id="category">
					<img src="${pageContext.request.contextPath}/img/menu.png" id="menuIcon">전체 카테고리
					<img src="${pageContext.request.contextPath}/img/menuDownArrow.png" id="menuDownIcon"></a></li>
					<li><span id="boardLi">공지사항</span></li>
				</ul>

				<ul id="memberUl">
					<li id="userLi"><a href="member/myInfo.do"><img alt="user" src="${pageContext.request.contextPath}/img/user.png" id = "userIcon"><br>${memName}님</a></li>

					<li id="loginLi">
						<form action="/GU/member/loginForm.do" name="loginForm" method="post">
							<a href="#" id="login"><img alt="login" src="${pageContext.request.contextPath}/img/login.png" id="loginIcon" title="로그인"></a>
							<input type="hidden" name="path" id="path_login" />
						</form>
					</li>
					<li id="logoutLi">
						<form action="/GU/logout.do" name="logoutForm" method="post">
							<a href="#" id="logout"><img alt="logout" src="${pageContext.request.contextPath}/img/logout.png" id="logoutIcon"></a>
							<input type="hidden" name="path" id="path_logout" />
						</form>
					</li>					
					<li id="joinLi"><a href="member/agreeForm.do" id="join"><img alt="join" src="${pageContext.request.contextPath}/img/join.png" id="joinIcon" title="회원가입"></a></li>
					<li><a href="#" id="orderCurrent"><img alt="orderCurrent" src="${pageContext.request.contextPath}/img/orderCurrent.png" id="orderCurrentIcon" title="발주현황"></a></li>
					<li><a href="#" id="order"><img alt="order" src="${pageContext.request.contextPath}/img/order.png" id="orderIcon" title="발주대기목록"></a></li>				
				</ul>
			</fieldset>
		</div>
</div>
</body>
</html>