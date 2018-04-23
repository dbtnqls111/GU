<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매 처리 취소 결과</title>
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		alert("${result}건 판매 처리 취소 완료!");
		opener.location.reload(true);
		window.close();
	});
</script>
</head>
<body>
</body>
</html>