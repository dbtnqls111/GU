<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/list.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 새로고침시 캐시 사용 안함
		$.ajaxSetup({
			cache : false
		});
		
		$(".searchForm").submit(function() {
			$(this).parents(".content").load("searchedSalesCompleteList_admin.do?keyword=" + encodeURI($(".keyword").val()) + "&page=1");

			return false;
		});

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

			if (confirm("(" + checked + "건 선택)\n선택한 항목의 하위 항목들의 판매 처리가 모두 취소됩니다.\n정말로 판매 처리를 취소하시겠습니까?")) {
				$(".check_i:checked").each(function() {
					$(this).attr("value", $(this).parents(".trData").children("td:eq(1)").children("a").html());
				});
				$(".tableForm").submit();
			}
		});
	});

	function detail(code) {
		var cw = screen.availWidth;
		var ch = screen.availHeight;

		var width = 1100;
		var height = 600;

		var ml = (cw - width) / 2;
		var mt = (ch - height) / 2;

		window.open("salesComplete_admin.do?code=" + code, "", "width=" + width + ",height=" + height + ",top=" + mt + ",left=" + ml);
	}
	
	function paging(page) {
		$(".paging").parents(".content").load("searchedSalesCompleteList_admin.do?keyword=" + encodeURI($(".keyword").val()) + "&page=" + page);
	}
</script>
</head>
<body>
	<div class="topMenu">
		<p>☆ 판매 완료 목록</p>
		<div>
			<form class="searchForm" action="searchedSalesCompleteList_admin.do" method="post">
				<input type="text" class="keyword" value="${keyword}">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
	<div class="paging">
		<c:if test="${page > 1}">
			<span>
				<a href="#" class="otherPage" onclick="paging(1)"><img src="img/start_page.png"></a>
			</span>
		</c:if>
		<c:if test="${page == 1}">
			<span>
				<a href="#" class="disable"><img src="img/start_page_disable.png"></a>
			</span>
		</c:if>
		<c:if test="${startPage > 3}">
			<span>
				<a href="#" class="otherPage" onclick="paging(${startPage - 1})"><img src="img/pre_arrow.png"></a>
			</span>
		</c:if>
		<c:if test="${startPage <= 3}">
			<span>
				<a href="#" class="disable"><img src="img/pre_arrow_disable.png"></a>
			</span>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
			<c:if test="${i == page}">
				<span>
					<a href="#" class="currentPage" onclick="paging(${i})">${i}</a>
				</span>
			</c:if>
			<c:if test="${i != page}">
				<span>
					<a href="#" class="otherPage" onclick="paging(${i})">${i}</a>
				</span>
			</c:if>
		</c:forEach>
		<c:if test="${endPage < maxPage}">
			<span>
				<a href="#" class="otherPage" onclick="paging(${endPage + 1})"><img src="img/after_arrow.png"></a>
			</span>
		</c:if>
		<c:if test="${endPage >= maxPage}">
			<span>
				<a href="#" class="disable"><img src="img/after_arrow_disable.png"></a>
			</span>
		</c:if>
		<c:if test="${page < maxPage}">
			<span>
				<a href="#" class="otherPage" onclick="paging(${maxPage})"><img src="img/end_page.png"></a>
			</span>
		</c:if>
		<c:if test="${page >= maxPage}">
			<span>
				<a href="#" class="disable"><img src="img/end_page_disable.png"></a>
			</span>
		</c:if>
	</div>
	<div class="dataList">
		<form class="tableForm" action="salesCompleteToStandBy_admin.do" method="post">
			<table class="salesCompleteTable">
				<tr class="trLabel">
					<th>
						<input type="checkbox" class="check_all">
					</th>
					<th width="25%">발주 코드</th>
					<th width="50%">판매 내용</th>
					<th width="25%">지점명</th>
				</tr>
				<c:forEach var="salesComplete" items="${salesCompleteList}">
					<tr class="trData">
						<td>
							<input type="checkbox" name="check_i_code" class="check_i">
						</td>
						<td>
							<a href="#" onclick="detail('${salesComplete['salesCode']}')">${salesComplete['salesCode']}</a>
						</td>
						<td>${salesComplete['firstItemName']}
							<c:if test="${salesComplete['orderNumber'] > 0}">
								&nbsp;외&nbsp;${salesComplete['orderNumber']}건
							</c:if>
						</td>
						<td>${salesComplete['branchName']}</td>
					</tr>
				</c:forEach>
			</table>
		</form>
	</div>
	<div class="bottomMenu">
		<input type="button" value="선택 판매처리 취소" class="sales">
	</div>
</body>
</html>