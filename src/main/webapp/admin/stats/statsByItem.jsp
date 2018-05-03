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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
			$(".statsResultTable").css("display", "block");
			$(".tab").css("display", "block");
		}

		$(".statsOption").submit(function() {
			var year = $(".year option:selected").val();
			var month = $(".month option:selected").val();
			$(this).parents(".content").load("statsByItem.do?year=" + year + "&month=" + month);

			return false;
		});

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

	function detail(itemType1) {
		var year = $(".year option:selected").val();
		var month = $(".month option:selected").val();
		$(".statsResultTable").parents(".content").load("statsByItemToBranch.do?year=" + year + "&month=" + month + "&itemType1=" + encodeURI(itemType1));
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
		<c:forEach var="itemType1" items="${itemType1ListForGraph}">
		listItem.push("${itemType1}");
		</c:forEach>

		var list0 = new Array();
		list0.push(dateCalc("${year}", "${month}", -5));
		<c:forEach var="statsByItemDTO" items="${statsByItemListForGraph6[0]}">
		list0.push(Number("${statsByItemDTO.salesPrice}"));
		</c:forEach>

		var list1 = new Array();
		list1.push(dateCalc("${year}", "${month}", -4));
		<c:forEach var="statsByItemDTO" items="${statsByItemListForGraph6[1]}">
		list1.push(Number("${statsByItemDTO.salesPrice}"));
		</c:forEach>

		var list2 = new Array();
		list2.push(dateCalc("${year}", "${month}", -3));
		<c:forEach var="statsByItemDTO" items="${statsByItemListForGraph6[2]}">
		list2.push(Number("${statsByItemDTO.salesPrice}"));
		</c:forEach>

		var list3 = new Array();
		list3.push(dateCalc("${year}", "${month}", -2));
		<c:forEach var="statsByItemDTO" items="${statsByItemListForGraph6[3]}">
		list3.push(Number("${statsByItemDTO.salesPrice}"));
		</c:forEach>

		var list4 = new Array();
		list4.push(dateCalc("${year}", "${month}", -1));
		<c:forEach var="statsByItemDTO" items="${statsByItemListForGraph6[4]}">
		list4.push(Number("${statsByItemDTO.salesPrice}"));
		</c:forEach>

		var list5 = new Array();
		list5.push(dateCalc("${year}", "${month}", 0));
		<c:forEach var="statsByItemDTO" items="${statsByItemListForGraph6[5]}">
		list5.push(Number("${statsByItemDTO.salesPrice}"));
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
	<div class="statsResultTable">
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
			<c:forEach var="statsByItemDTO" items="${statsByItemListForTable}">
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
	<div class="statsResultGraph">
		<p class="statsP">${year}년&nbsp;${month}월&nbsp;판매&nbsp;통계</p>
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