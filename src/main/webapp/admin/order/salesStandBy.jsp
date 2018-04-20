<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 발주 대기 목록</title>
<link rel="stylesheet" type="text/css" href="css/order_form.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".wrapper").css("width", $(window).width());
		$(".wrapper").css("height", $(window).height());
	});
</script>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<p>상세 발주 대기 목록</p>
		</div>
		<div class="body">
			<table>
				<tr class="trLabel">
					<th>
						<input type="checkbox" class="check_all">
					</th>
					<th width="20%">발주 코드</th>
					<th width="20%">품목 코드</th>
					<th width="20%">수량</th>
					<th width="20%">합계</th>
					<th width="20%">지점 코드</th>
				</tr>
				<c:forEach var="salesDTO" items="${salesStandBy}">
					<tr class="trData">
						<td>
							<input type="checkbox" name="check_i" class="check_i">
						</td>
						<td>${salesDTO.code}</td>
						<td>${salesDTO.itemCode}</td>
						<td>${salesDTO.quantity}</td>
						<td>${salesDTO.price}</td>
						<td>${salesDTO.branchCode}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="footer">
			<input type="button" value="저장" class="submit">
			<input type="button" value="다시작성" class="reset">
			<input type="button" value="닫기" onclick="window.close()">
		</div>
	</div>
</body>
</html>