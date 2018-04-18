<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지점 등록 결과</title>
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		if ("${result > 0}") {
			alert("지점 등록 성공!");
		} else {
			alert("지점 등록 실패...");
		}
		opener.location.reload(true);
		window.close();
	});
</script>
</head>
<body>
</body>
</html>