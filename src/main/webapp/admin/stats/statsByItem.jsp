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

		// 선택된 년도와 월 표시
		$(".year option[value='" + "${year}" + "']").prop("selected", true);
		$(".month option[value='" + "${month}" + "']").prop("selected", true);

		// 년도와 월 정보가 있어야만 통계자료 보임
		if ("${year}" != "" && "${month}" != "") {
			$(".statsResult").css("visibility", "visible");
		}

		$(".statsOption").submit(function() {
			var year = $(".year option:selected").val();
			var month = $(".month option:selected").val();
			$(this).parents(".content").load("statsByItem.do?year=" + year + "&month=" + month);

			return false;
		});
	});

	function detail(itemType1) {
		var year = $(".year option:selected").val();
		var month = $(".month option:selected").val();
		$(".statsResult").parents(".content").load("statsByItemToBranch.do?year=" + year + "&month=" + month + "&itemType1=" + encodeURI(itemType1));
	}
</script>
</head>
<body>
	<div class="topMenu">
		<p>☆ 품목별 통계</p>
		<div>
			<form class="statsOption" action="statsByItem.do" method="post">
				<select class="year">
					<option value="2018" selected>2018</option>
					<option value="2019">2019</option>
					<option value="2020">2020</option>
				</select>
				년
				<select class="month">
					<option value="01" selected>01</option>
					<option value="02">02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select>
				월
				<input type="submit" value="확인">
			</form>
		</div>
	</div>
	<div class="statsResult">
		<p class="statsP">${year}년&nbsp;${month}월&nbsp;판매&nbsp;통계</p>
		<table class="statsTable">
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
							<td rowspan="${fn:length(statsByItemDTO.detailList) + 1}">
								<a href="#" onclick="detail('${statsByItemDTO.itemType1}')">${statsByItemDTO.itemType1}</a>
							</td>
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