<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 수정 결과</title>
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		if ("${result > 0}") {
			alert("품목 수정 성공!");
		} else {
			alert("품목 수정 실패...");
		}
		opener.location.reload(true);
		window.close();
	});
</script>
</head>
<body>
</body>
</html>