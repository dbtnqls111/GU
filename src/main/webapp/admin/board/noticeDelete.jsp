<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		if ("${result > 0}") {
			alert("공지 삭제 성공!");
		} else {
			alert("공지 삭제 실패...");
		}
		sessionStorage.setItem("menuIndex", 0);
		location.href = "board.do";
	});
</script>
</head>
<body>
</body>
</html>