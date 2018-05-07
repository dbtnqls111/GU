<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/stats.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	$(function() {
		// 새로고침시 캐시 사용 안함
		$.ajaxSetup({
			cache : false
		});

		// 년도와 월, 품목 타입 정보가 있어야만 통계자료 보임
		if ("${year}" != "" && "${month}" != "" && "${itemType1}" != "") {
			$(".statsResultTable").css("display", "block");
			$(".tab").css("display", "block");
		}

		$(".tab ul li").click(function() {
			$(".tab ul li").not(this).removeClass("selected");
			$(this).addClass("selected");

			if ($(this).is(".tab ul li:eq(0)")) {
				$(".statsResultTable").css("display", "block");
				$(".statsResultGraph").css("display", "none");
			} else {
				$(".statsResultTable").css("display", "none");
				$(".statsResultGraph").css("display", "block");
			}
		});
	});

	function back() {
		var year = "${year}";
		var month = "${month}";
		$(".statsResultTable").parents(".content").load("statsByItem.do?year=" + year + "&month=" + month);
	}

	////////////////여기부터는 그래프 관련 ////////////////

	// 년월 가감 계산
	function dateCalc(year, month, incDec) {
		var date = new Date(year + "/" + month + "/01");

		date.setMonth(date.getMonth() + incDec);

		var monthString = (date.getMonth() + 1).toString();
		var month = "";

		for (var i = 0; i < 2 - monthString.length; i++) {
			month += "0";
		}
		month += monthString;

		return date.getFullYear() + "/" + month;
	}

	google.charts.load("current", {
		packages : [ "corechart" ]
	});

	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {
		// 차트 데이터 설정
		var listItem = new Array();
		listItem.push("Month");
		<c:forEach var="branchName" items="${branchNameListForGraph}">
		listItem.push("${branchName}");
		</c:forEach>

		var list0 = new Array();
		list0.push(dateCalc("${year}", "${month}", -5));
		<c:forEach var="statsByBranchDTO" items="${statsByBranchListForGraph6[0]}">
		list0.push(Number("${statsByBranchDTO.salesPrice}"));
		</c:forEach>

		var list1 = new Array();
		list1.push(dateCalc("${year}", "${month}", -4));
		<c:forEach var="statsByBranchDTO" items="${statsByBranchListForGraph6[1]}">
		list1.push(Number("${statsByBranchDTO.salesPrice}"));
		</c:forEach>

		var list2 = new Array();
		list2.push(dateCalc("${year}", "${month}", -3));
		<c:forEach var="statsByBranchDTO" items="${statsByBranchListForGraph6[2]}">
		list2.push(Number("${statsByBranchDTO.salesPrice}"));
		</c:forEach>

		var list3 = new Array();
		list3.push(dateCalc("${year}", "${month}", -2));
		<c:forEach var="statsByBranchDTO" items="${statsByBranchListForGraph6[3]}">
		list3.push(Number("${statsByBranchDTO.salesPrice}"));
		</c:forEach>

		var list4 = new Array();
		list4.push(dateCalc("${year}", "${month}", -1));
		<c:forEach var="statsByBranchDTO" items="${statsByBranchListForGraph6[4]}">
		list4.push(Number("${statsByBranchDTO.salesPrice}"));
		</c:forEach>

		var list5 = new Array();
		list5.push(dateCalc("${year}", "${month}", 0));
		<c:forEach var="statsByBranchDTO" items="${statsByBranchListForGraph6[5]}">
		list5.push(Number("${statsByBranchDTO.salesPrice}"));
		</c:forEach>

		var data = google.visualization.arrayToDataTable([ listItem, list0, list1, list2, list3, list4, list5 ]);

		// 그래프 옵션
		var options = {
			width : 1000,
			height : 500,
			vAxis : {
				title : "판매액"
			},
			hAxis : {
				title : "년월"
			},
			seriesType : "bars",
			bar : {
				groupWidth : "50%"
			},
			legend : {
				position : "right"
			}
		};

		var chart = new google.visualization.ComboChart(document.getElementById("graph"));
		chart.draw(data, options);
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
	<div class="statsResultTable">
		<p class="statsDetailP">${year}년&nbsp;${month}월&nbsp;판매&nbsp;상세&nbsp;통계&nbsp;-&nbsp;${itemType1}</p>
		<table class="statsDetailTable">
			<tr class="trLabel">
				<th width="10%">순위</th>
				<th width="40%">지점명</th>
				<th width="25%">판매액</th>
				<th width="25%">점유율</th>
			</tr>
			<c:forEach var="statsByBranchDTO" items="${statsByBranchListForTable}">
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
	<div class="statsResultGraph">
		<p class="statsDetailP">${year}년&nbsp;${month}월&nbsp;판매&nbsp;상세&nbsp;통계&nbsp;-&nbsp;${itemType1}</p>
		<div id="graph"></div>
	</div>
	<div class="tab">
		<ul>
			<li class="selected">표</li>
			<li>그래프</li>
		</ul>
	</div>
</body>
</html>