<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 판매 완료 목록</title>
<link rel="stylesheet" type="text/css" href="css/order_form.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".wrapper").css("width", $(window).width());
		$(".wrapper").css("height", $(window).height());

		$(".check_all").change(function() {
			var is_check = $(this).is(":checked");

			$(".check_i").prop("checked", is_check);
			$(".check_i").trigger("change");
		});

		$(".check_i").change(function() {
			if ($(this).is(":checked")) {
				$(this).parents(".trData").css("background-color", "#e2e2e2");
			} else {
				$(this).parents(".trData").css("background-color", "white");
			}
		});

		$(".sales").click(function() {
			var checked = $(".check_i:checked").length;

			if (checked < 1) {
				alert("판매 처리를 취소할 항목을 선택하세요.");
				return false;
			}

			if (confirm("(" + checked + "건 선택)\n정말로 판매 처리를 취소하시겠습니까?")) {
				$(".check_i:checked").each(function() {
					$(this).attr("value", $(this).parents(".trData").children("td:eq(0)").children("input[type='hidden']").val());
				});
				$(".tableForm").submit();
			}
		});
	});
</script>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<p>상세 판매 완료 목록</p>
		</div>
		<div class="body">
			<form class="tableForm" action="salesCompleteToStandBy_admin.do" method="post">
				<table class="etcInfo">
					<tr>
						<th width="20%" class="tdLabel">발주 코드</th>
						<td width="30%" class="tdData">${salesCode}</td>
						<th width="20%" class="tdLabel">지점명</th>
						<td width="30%" class="tdData">${branchName}</td>
					</tr>
				</table>
				<table class="orderItem">
					<tr class="trLabel">
						<th>
							<input type="checkbox" class="check_all">
						</th>
						<th width="12%">품목 타입1</th>
						<th width="12%">품목 타입2</th>
						<th width="12%">품목 브랜드</th>
						<th width="20%">품목명</th>
						<th width="10%">수량</th>
						<th width="10%">판매 단가</th>
						<th width="10%">총액</th>
						<th width="14%">판매처리 날짜</th>
					</tr>
					<c:forEach var="map" items="${salesCompleteMap}">
						<tr class="trData">
							<td>
								<input type="checkbox" name="check_i_seq" class="check_i">
								<input type="hidden" value="${map['salesSeq']}">
							</td>
							<td>${map['itemType1']}</td>
							<td>${map['itemType2']}</td>
							<td>${map['itemBrand']}</td>
							<td>${map['itemName']}</td>
							<td>${map['salesQuantity']}</td>
							<td>
								<fmt:formatNumber value="${map['itemUup']}" />
							</td>
							<td>
								<fmt:formatNumber value="${map['salesPrice']}" />
							</td>
							<td>${map['salesDate']}</td>
						</tr>
					</c:forEach>
					<tr class="trData">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<th>
							<fmt:formatNumber value="${totalSalesPrice}" />
						</th>
						<td></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="footer">
			<input type="button" value="선택 판매처리 취소" class="sales">
			<input type="button" value="닫기" onclick="window.close()">
		</div>
	</div>
</body>
</html>