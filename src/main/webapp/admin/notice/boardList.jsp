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
			$(this).parents(".content").load("searchedBoardList_admin.do?keyword=" + encodeURI($(".keyword").val()) + "&page=1");

			return false;
		});

		$(".insert").click(function() {
			$(".paging").parents(".content").load("boardInsertForm_admin.do");
		});
	});

	function boardView(seq) {
		$(".paging").parents(".content").load("boardView_admin.do?seq=" + seq);
	}
	
	function paging(page) {
		$(".paging").parents(".content").load("searchedBoardList_admin.do?keyword=" + encodeURI($(".keyword").val()) + "&page=" + page);
	}
</script>
</head>
<body>
	<div class="topMenu">
		<p>☆ 공지 사항</p>
		<div>
			<form class="searchForm" action="searchedBoardList_admin.do" method="post">
				<input type="text" class="keyword" value="${keyword}">
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
	<div class="paging">
		[<a class="otherPage" href="#" onclick="paging(1)">처음으로</a>]
		<c:if test="${startPage > 10}">
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
		<table class="boardTable">
			<tr class="trLabel">
				<th width="10%">번호</th>
				<th width="50%">제목</th>
				<th width="15%">작성자</th>
				<th width="15%">작성일</th>
				<th width="10%">조회</th>
			</tr>
			<c:forEach var="boardDTO" items="${boardList}">
				<tr class="trData">
					<td>${boardDTO.seq}</td>
					<td>
						<a href="#" onclick="boardView(${boardDTO.seq})">${boardDTO.subject}</a>
					</td>
					<td>${boardDTO.name}</td>
					<td>${boardDTO.logtime}</td>
					<td>${boardDTO.hit}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="bottomMenu">
		<input type="button" value="공지 등록" class="insert">
	</div>
</body>
</html>