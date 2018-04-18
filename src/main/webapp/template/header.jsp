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
$(function(){
	var session = "${memName}";
	
	if(session!=""){
		$("#loginLi").css("display", "none");
		$("#userLi").css("display", "block");
		$("#logoutLi").css("display", "block");
	}else{		
		$("#userLi").css("display", "none");
		$("#logoutLi").css("display", "none");	
		$("#loginLi").css("display", "block");	
	}
	
	$("#boardLi").click(function(){
		location.href="boardList.do?pg=1";
	});
});
</script>

</head>
<body>
<div id="wrap">
		<div id="top">
			<h1 id="mainLogo">
				<a href="${pageContext.request.contextPath}/index.jsp">GU</a>
			</h1>
			<fieldset id="searchField">
				<input type="text" id="search" />
				<a href=""><img src="${pageContext.request.contextPath}/img/search_top.png" id="searchIcon"></a>
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
					<li id="userLi"><a href="#"><img alt="user" src="${pageContext.request.contextPath}/img/user.png" id = "userIcon"><br>${memName}님</a></li>
					<li id="loginLi"><a href="loginForm.do" id="login"><img alt="login" src="${pageContext.request.contextPath}/img/login.png" id="loginIcon" title="로그인"></a></li>
					<li id="logoutLi"><a href="logout.do" id="logout"><img alt="logout" src="${pageContext.request.contextPath}/img/logout.png" id="logoutIcon"></a></li>
					<li><a href="#" id="join"><img alt="join" src="${pageContext.request.contextPath}/img/join.png" id="joinIcon" title="회원가입"></a></li>
					<li><a href="#" id="order"><img alt="order" src="${pageContext.request.contextPath}/img/order.png" id="orderIcon" title="발주대기목록"></a></li>					
				</ul>
			</fieldset>
		</div>
		
</div>
</body>
</html>