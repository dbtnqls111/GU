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
			$(this).parents(".content").load("statsByBranch.do?year=" + year + "&month=" + month);

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

	function detail(branchName) {
		var year = $(".year option:selected").val();
		var month = $(".month option:selected").val();
		$(".statsResultTable").parents(".content").load("statsByBranchToItem.do?year=" + year + "&month=" + month + "&branchName=" + encodeURI(branchName));
	}

	//////////////// 여기부터는 그래프 관련 ////////////////

	// 년월 가감 계산
	function dateCalc(year, month, incDec) {
		var date = new Date(year + "/" + month + "/01");

		date.setMonth(date.getMonth()+ incDec);
		
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
			list0.push("${statsByBranchDTO.salesPrice}");
		</c:forEach>
			
		console.log(listItem);
		console.log(list0);
		
		var data = google.visualization.arrayToDataTable([ 
			listItem, list0, 
			[ dateCalc("${year}", "${month}", -4), 0, 0, 0, 0, 0 ], 
			[ dateCalc("${year}", "${month}", -3), 0, 0, 0, 0, 0 ], 
			[ dateCalc("${year}", "${month}", -2), 0, 0, 0, 0, 0 ], 
			[ dateCalc("${year}", "${month}", -1), ${statsByBranchListForGraph6[4][0].salesPrice}, ${statsByBranchListForGraph6[4][1].salesPrice}, ${statsByBranchListForGraph6[4][2].salesPrice}, ${statsByBranchListForGraph6[4][3].salesPrice}, ${statsByBranchListForGraph6[4][4].salesPrice} ], 
			[ dateCalc("${year}", "${month}", 0), ${statsByBranchListForGraph6[5][0].salesPrice}, ${statsByBranchListForGraph6[5][1].salesPrice}, ${statsByBranchListForGraph6[5][2].salesPrice}, ${statsByBranchListForGraph6[5][3].salesPrice}, ${statsByBranchListForGraph6[5][4].salesPrice} ] 
		]);

		// 그래프 옵션
		var options = {
			title : "${year}" + "년 " + "${month}" + "월 판매 추이",
			width : 800, 
			height : 500, 
			vAxis : { title : "판매액" },
			hAxis : { title : "년월" },
			seriesType : "bars",
			bar : { groupWidth : "50%" },
			legend : { position : "right" }
		};

		var chart = new google.visualization.ComboChart(document.getElementById("graph"));
		chart.draw(data, options);
	}
</script>
<style type="text/css">
.tab ul {
	list-style: none;
	width: 650px;
	display: inline-block;
	padding: 0;
	margin: 0;
	text-align: center;
	z-index: 100;
}

.tab ul li {
	width: 100px;
	height: 25px;
	float: left;
	line-height: 1.5;
	background: linear-gradient(to top, #66aaff, #c9e1ff 50%, #dbebff, white);
	border: 1px solid #aaaaaa;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	box-sizing: border-box;
	margin-left: 5px;
	border: 1px solid #aaaaaa;
}

.tab ul li:hover {
	cursor: pointer;
	font-weight: bold;
}

.tab ul li.selected {
	border-top: none;
	font-weight: bold;
}
</style>
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
				<th width="40%">지점명</th>
				<th width="25%">판매액</th>
				<th width="25%">점유율</th>
			</tr>
			<c:forEach var="statsByBranchDTO" items="${statsByBranchListForTable}">
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
				<th colspan="2">합계</th>
				<th>
					<fmt:formatNumber value="${totalSalesPrice}" />
				</th>
				<th></th>
			</tr>
		</table>
		<div class="chart"></div>
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