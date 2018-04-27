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
			$(this).parents(".content").load("statsByBranch.do?year=" + year + "&month=" + month);

			return false;
		});
	});

	function detail(branchName) {
		var year = $(".year option:selected").val();
		var month = $(".month option:selected").val();
		$(".statsResult").parents(".content").load("statsByBranch_itemType1.do?year=" + year + "&month=" + month + "&branchName=" + encodeURI(branchName));
	}
</script>
</head>
<body>
	<div class="topMenu">
		<p>☆ 지점별 통계</p>
		<div>
			<form class="statsOption" action="statsByBranch.do" method="post">
				<select class="year">
					<option value="2018" selected>2018</option>
					<option value="2019">2019</option>
					<option value="2020">2020</option>
				</select>
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
				<input type="submit" value="확인">
			</form>
		</div>
	</div>
	<div class="statsResult">
		<table class="statsTable">
			<tr class="trLabel">
				<th width="10%">순위</th>
				<th width="40%">지점명</th>
				<th width="25%">매출액</th>
				<th width="25%">점유율</th>
			</tr>
			<c:forEach var="statsByBranchDTO" items="${statsByBranchList}">
				<tr class="trData">
					<td>${statsByBranchDTO.rank}</td>
					<td>
						<a href="#" onclick="detail('${statsByBranchDTO.branchName}')">${statsByBranchDTO.branchName}</a>
					</td>
					<td>
						<fmt:formatNumber value="${statsByBranchDTO.salesPrice}" />
					</td>
					<td>${statsByBranchDTO.ratio}%</td>
				</tr>
			</c:forEach>
			<tr class="trData">
				<td></td>
				<td></td>
				<td>
					<b><fmt:formatNumber value="${totalSalesPrice}" /></b>
				</td>
				<td></td>
			</tr>
		</table>
	</div>
</body>
</html>