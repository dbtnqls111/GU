<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/list.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
 		$(".trData a").click(function(){
			var value = $(this).text();
			var code = $(this).closest("tr").find("td:eq(0)").text();
			$('span#branchSel', opener.document).text(value);
			$('input[name=branch]', opener.document).attr("value", code);
			window.close();
		});
	});
</script>
<style type="text/css">
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	
	*{font-family: 'Jeju Gothic', sans-serif;}
	
	.topMenu {
	width: 500px;
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
}

.topMenu>div {
	float: right;
	padding: 2px 5px;
}

.paging {
	width: 500px;
	height: 30px;
	line-height: 2;
	margin-left: 10px;
	margin-top:10px;
	margin-bottom:10px;
	text-align:center;
}

.paging .otherPage {
	color: blue;
	text-decoration: none;
}

.paging .currentPage {
	color: red;
	text-decoration: underline;
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
	margin-left: 0;
	margin-bottom: 50px;
	border: 1px solid #aaaaaa;
	border-collapse: collapse;
}

.dataList table.branchTable {
	width: 500px;
}

th, td {
	border: 1px solid #aaaaaa;
	padding: 5px;
	text-align: center;
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
</style>
</head>
<body>
	<div class="topMenu">
		<p>지점 목록</p>
		<div>
			<form class="searchForm" action="searchedBranchList.do?page=1" method="post">
				<input type="text" class="keyword" name="keyword" value="${keyword}">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
	<div class="paging">
		[<a class="otherPage" href="${type}.do?keyword=${keyword}&page=1">처음으로</a>]
		<c:if test="${startPage > 5}">
			[<a href="${type}.do?keyword=${keyword}&page=${startPage - 1}" class="otherPage">이전</a>]
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
				
			<c:if test="${i == page}">
				[<a href="${type}.do?keyword=${keyword}&page=${i}" class="currentPage">${i}</a>]
			</c:if>
			<c:if test="${i != page}">
				[<a href="${type}.do?keyword=${keyword}&page=${i}" class="otherPage">${i}</a>]
			</c:if>
		</c:forEach>
		<c:if test="${endPage < maxPage}">
			[<a href="${type}.do?keyword=${keyword}&page=${endPage + 1}" class="otherPage">다음</a>]
		</c:if>
		[<a class="otherPage" href="${type}.do?keyword=${keyword}&page=${maxPage}">끝으로</a>]
	</div>
	
	<div class="dataList">
		<form class="tableForm" action="branchDelete_admin.do" method="post">
			<table class="branchTable">
				<tr class="trLabel">
					<th width="15%">지점 코드</th>
					<th width="30%">지점명</th>
					<th width="40%">지점 주소</th>
				</tr>
				<c:forEach var="branchDTO" items="${branchList}">
					<tr class="trData">
						<td id="a">${branchDTO.code}</td>
						<td>
							<a href="#">${branchDTO.name}</a>
						</td>
						<td>${branchDTO.address}</td>
					</tr>
				</c:forEach>
			</table>
		</form>
	</div>
</body>
</html>