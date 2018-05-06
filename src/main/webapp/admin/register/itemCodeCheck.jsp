<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 코드 중복 검사</title>
<link rel="stylesheet" type="text/css" href="css/list.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".useCode").click(function() {
			$(opener.document).find(".code").val("${code}");
			$(opener.document).find(".isValid").attr("value", "yes");
			$(opener.document).find(".duplCheck").attr("value", "검사 완료");
			$(opener.document).find(".duplCheck").css("background-color", "green");
			$(opener.document).find(".duplCheck").css("color", "white");
			$(opener.document).find(".duplCheck").attr("disabled", "disabled");
			window.close();
		});
	});
</script>
</head>
<body>
	<c:if test="${isExist == true}">
		${code}은(는) 사용 중입니다.
	</c:if>
	<c:if test="${isExist == false}">
		${code}은(는) 사용 가능합니다.
	</c:if>
	<form action="itemCodeCheck_admin.do" method="post">
		<input type="text" name="code" value="${code}">
		<input type="submit" value="중복 검사">
		<br> <br>
		<c:if test="${isExist == true}">
			<input type="button" value="닫기" onclick="window.close()">
		</c:if>
		<c:if test="${isExist == false}">
			<input type="button" value="사용" class="useCode">
			<input type="button" value="닫기" onclick="window.close()">
		</c:if>
	</form>
</body>
</html>