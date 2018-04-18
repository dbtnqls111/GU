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
			$(this).parents(".content").load("searchedBranchList_admin.do?keyword=" + $(".keyword").val() + "&page=1");

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

		$(".insert").click(function() {
			var cw = screen.availWidth;
			var ch = screen.availHeight;

			var width = 600;
			var height = 600;

			var ml = (cw - width) / 2;
			var mt = (ch - height) / 2;

			window.open("branchInsertForm_admin.do", "", "width=" + width + ",height=" + height + ",top=" + mt + ",left=" + ml);
		});

		$(".delete").click(function() {
			var checked = $(".check_i:checked").length;

			if (checked < 1) {
				alert("삭제할 항목을 선택하세요.");
				return false;
			}

			if (confirm("정말로 삭제하시겠습니까?")) {
				$(".check_i:checked").each(function() {
					$(this).attr("value", $(this).parents(".trData").children("td:eq(1)").children("a").html());
				});
				$(".tableForm").submit();
			}
		});
	});

	function update(code) {
		var cw = screen.availWidth;
		var ch = screen.availHeight;

		var width = 600;
		var height = 600;

		var ml = (cw - width) / 2;
		var mt = (ch - height) / 2;

		window.open("branchUpdateForm_admin.do?code=" + code, "", "width=" + width + ",height=" + height + ",top=" + mt + ",left=" + ml);
	}
	
	function paging(page) {
		$(".paging").parents(".content").load("searchedBranchList_admin.do?keyword=" + $(".keyword").val() + "&page=" + page);
	}
</script>
</head>
<body>
	<div class="topMenu">
		<p>☆ 지점 목록</p>
		<div>
			<form class="searchForm" action="searchedBranchList_admin.do" method="post">
				<input type="text" class="keyword" value="${keyword}">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
	<div class="paging">
		[<a class="otherPage" href="#" onclick="paging(1)">처음으로</a>]
		<c:if test="${startPage > 5}">
			[<a href="#" class="otherPage" onclick="paging(${startPage - 1})">이전</a>]
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
			<c:if test="${i == page}">
					[<a href="#" class="currentPage" onclick="paging(${i})">${i}</a>]
				</c:if>
			<c:if test="${i != page}">
					[<a href="#" class="otherPage" onclick="paging(${i})">${i}</a>]
				</c:if>
		</c:forEach>
		<c:if test="${endPage < maxPage}">
			[<a href="#" class="otherPage" onclick="paging(${endPage + 1})">다음</a>]
		</c:if>
		[<a class="otherPage" href="#" onclick="paging(${maxPage})">끝으로</a>]
	</div>
	<div class="dataList">
		<form class="tableForm" action="branchDelete_admin.do" method="post">
			<table class="branchTable">
				<tr class="trLabel">
					<th>
						<input type="checkbox" class="check_all">
					</th>
					<th width="15%">지점 코드</th>
					<th width="30%">지점명</th>
					<th width="40%">지점 주소</th>
					<th width="15%">지점주 ID</th>
				</tr>
				<c:forEach var="branchDTO" items="${branchList}">
					<tr class="trData">
						<td>
							<input type="checkbox" name="check_i" class="check_i">
						</td>
						<td>
							<a href="#" onclick="update('${branchDTO.code}')">${branchDTO.code}</a>
						</td>
						<td>${branchDTO.name}</td>
						<td>${branchDTO.address}</td>
						<td>${branchDTO.ownerId}</td>
					</tr>
				</c:forEach>
			</table>
		</form>
	</div>
	<div class="bottomMenu">
		<input type="button" value="신규입력" class="insert">
		<input type="button" value="Excel입력">
		<input type="button" value="선택삭제" class="delete">
	</div>
</body>
</html>