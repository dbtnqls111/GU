<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/board.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 새로고침시 캐시 사용 안함
		$.ajaxSetup({
			cache : false
		});

		$.ajax({
			url : '${pageContext.request.contextPath}/img/${boardDTO.img}',
			type : 'HEAD',
			success : function() {
				$(".image").append($('<img src="${pageContext.request.contextPath}/img/${boardDTO.img}">'));
				$(".image").css("padding", "5px");
				$(".image img").css("width", "600px");
				$(".image img").css("height", "auto");
			},
			error : function() {
			}
		});

		$(".update").click(function() {
			$(".noticeView").parents(".content").load("noticeUpdateForm_admin.do?seq=${boardDTO.seq}&page=${page}");
		});

		$(".delete").click(function() {
			if (confirm("정말 삭제하시겠습니까?")) {
				$(".noticeView").parents(".content").load("noticeDelete_admin.do?seq=${boardDTO.seq}");
			}
		});

		$(".list").click(function() {
			$(".noticeView").parents(".content").load("noticeList_admin.do?page=${page}");
		});
	});
</script>
</head>
<body>
	<div class="topMenu">
		<p>☆ 공지 내용</p>
	</div>
	<div class="noticeView">
		<table>
			<tr>
				<th class="tdLabel">제목</th>
				<td class="tdData">${boardDTO.subject}</td>
			</tr>
			<tr>
				<th class="tdLabel">작성일</th>
				<td class="tdData">${boardDTO.logtime}</td>
			</tr>
			<tr>
				<td colspan="2" class="tdData">
					<pre>${boardDTO.content}</pre>
					<span class="image"></span>
				</td>
			</tr>
		</table>
	</div>
	<div class="bottomMenu">
		<input type="button" value="공지 수정" class="update">
		<input type="button" value="공지 삭제" class="delete">
		<input type="button" value="목록으로" class="list">
	</div>
</body>
</html>