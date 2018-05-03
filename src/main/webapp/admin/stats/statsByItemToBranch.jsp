<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/stats.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 새로고침시 캐시 사용 안함
		$.ajaxSetup({
			cache : false
		});

		// 년도와 월, 품목 타입 정보가 있어야만 통계자료 보임
		if ("${year}" != "" && "${month}" != "" && "${itemType1}" != "") {
			$(".statsResult").css("visibility", "visible");
		}
	});

	function back() {
		var year = "${year}";
		var month = "${month}";
		$(".statsResult").parents(".content").load("statsByItem.do?year=" + year + "&month=" + month);
	}
</script>
</head>
<body>
	<div class="topMenu">
		<p>☆ 품목별 상세 통계</p>
		<div>
			<input type="button" value="뒤로" onclick="back()">
		</div>
	</div>
	<div class="statsResult">
		<p class="statsDetailP">${year}년&nbsp;${month}월&nbsp;판매&nbsp;상세&nbsp;통계&nbsp;-&nbsp;${itemType1}</p>
		<table class="statsDetailTable">
			<tr class="trLabel">
				<th width="10%">순위</th>
				<th width="40%">지점명</th>
				<th width="25%">판매액</th>
				<th width="25%">점유율</th>
			</tr>
			<c:forEach var="statsByBranchDTO" items="${statsByBranchList}">
				<tr class="trData">
					<td>${statsByBranchDTO.rank}</td>
					<td>${statsByBranchDTO.branchName}</td>
					<td>
						<fmt:formatNumber value="${statsByBranchDTO.salesPrice}" />
					</td>
					<td>${statsByBranchDTO.ratio}%</td>
				</tr>
			</c:forEach>
			<tr class="trData">
				<th colspan="2">합계</th>
				<th>
					<fmt:formatNumber value="${totalSalesPrice}" />
				</th>
				<th></th>
			</tr>
		</table>
	</div>
</body>
</html>