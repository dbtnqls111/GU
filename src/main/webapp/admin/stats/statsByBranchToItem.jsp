<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

		// 년도와 월, 지점명 정보가 있어야만 통계자료 보임
		if ("${year}" != "" && "${month}" != "" && "${branchName}" != "") {
			$(".statsResultTable").css("display", "block");
		}
	});

	function back() {
		var year = "${year}";
		var month = "${month}";
		$(".statsResultTable").parents(".content").load("statsByBranch.do?year=" + year + "&month=" + month);
	}
</script>
</head>
<body>
	<div class="topMenu">
		<p>☆ 지점별 상세 통계</p>
		<div>
			<input type="button" value="뒤로" onclick="back()">
		</div>
	</div>
	<div class="statsResultTable">
		<p class="statsDetailP">${year}년&nbsp;${month}월&nbsp;판매&nbsp;상세&nbsp;통계&nbsp;-&nbsp;${branchName}</p>
		<table class="statsDetailTable">
			<tr class="trLabel">
				<th width="10%">순위</th>
				<th width="25%">품목 타입</th>
				<th width="10%">순위</th>
				<th width="25%">세부 타입</th>
				<th width="15%">판매액</th>
				<th width="15%">점유율</th>
			</tr>
			<c:forEach var="statsByItemDTO" items="${statsByItemList}">
				<c:set var="rowspan" value="true" />
				<c:forEach var="statsByItemDetailDTO" items="${statsByItemDTO.detailList}">
					<tr class="trData">
						<c:if test="${rowspan}">
							<td rowspan="${fn:length(statsByItemDTO.detailList) + 1}">${statsByItemDTO.rank}</td>
							<td rowspan="${fn:length(statsByItemDTO.detailList) + 1}">${statsByItemDTO.itemType1}</td>
							<c:set var="rowspan" value="false" />
						</c:if>
						<td>${statsByItemDetailDTO.rank}</td>
						<td>${statsByItemDetailDTO.itemType2}</td>
						<td>
							<fmt:formatNumber value="${statsByItemDetailDTO.salesPrice}" />
						</td>
						<td>${statsByItemDetailDTO.ratio}%</td>
					</tr>
				</c:forEach>
				<tr>
					<th colspan="2"></th>
					<th>
						<fmt:formatNumber value="${statsByItemDTO.salesPrice}" />
					</th>
					<th>${statsByItemDTO.ratio}%</th>
				</tr>
			</c:forEach>
			<tr>
				<th colspan="4">합계</th>
				<th>
					<fmt:formatNumber value="${totalSalesPrice}" />
				</th>
				<th></th>
			</tr>
		</table>
	</div>
</body>
</html>