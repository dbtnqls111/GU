<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.topMenu {
	width: 850px;
	height: 30px;
	background-color: #c4c4c4;
	border-bottom: 1px solid #aaaaaa;
	border-right: 1px solid #aaaaaa;
	box-sizing: border-box;
}

.topMenu p {
	display: inline;
	height: 100%;
	padding: 2px 5px;
	line-height: 2;
	font-weight: bold;
}

.topMenu>div {
	float: right;
	padding: 2px 5px;
}

.paging {
	width: 800px;
	height: 30px;
	line-height: 1.5;
	margin-left: 10px;
}

.dataList {
	width: 100%;
	height: calc(100% - 60px);
	margin: 0;
	padding-left: 10px;
	box-sizing: border-box;
	overflow: auto;
	margin: 0;
}

.dataList table {
	width: 800px;
	margin-left: 0;
	margin-bottom: 50px;
	border: 1px solid #aaaaaa;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #aaaaaa;
	padding: 5px;
	text-align: center;
	padding: 5px;
}

.trLabel {
	background-color: #c4c4c4;
}

.trData {
	background-color: white;
}

.trData:hover {
	background-color: #e2e2e2;
}

.bottomMenu {
	position: fixed;
	background-color: #c4c4c4;
	border-top: 1px solid #aaaaaa;
	border-right: 1px solid #aaaaaa;
	border-bottom: 1px solid #aaaaaa;
	box-sizing: border-box;
	bottom: 10px;
	width: 850px;
	height: 30px;
	padding: 2px 5px;
}
</style>
<script type="text/javascript">
	$(function() {
		$(".searchForm").submit(function() {
			$(this).parents(".content").load("../branch/searchedBranchList_admin.do?keyword=" + $(".keyword").val());

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

			window.open("../branch/branchInsertForm_admin.do", "", "width=" + width + ",height=" + height + ",top=" + mt + ",left=" + ml);
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
</script>
</head>
<body>
	<div class="topMenu">
		<p>☆ 지점 목록</p>
		<div>
			<form class="searchForm" action="../branch/searchedBranchList_admin.do" method="post">
				<input type="text" class="keyword" value="${keyword}">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
	<div class="paging">[1][2][3]</div>
	<div class="dataList">
		<form class="tableForm" action="../branch/branchDelete_admin.do" method="post">
			<table>
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
							<a href="#">${branchDTO.code}</a>
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