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

		$(".submit").click(function() {
			if (!$("input[name='subject']").val()) {
				alert("제목을 입력하세요.");
				return false;
			}

			var fileName = $("input[name='img']").val();

			if (fileName) {
				if (!(fileName.substr(fileName.length - 4) == ".jpg") && !(fileName.substr(fileName.length - 4) == ".png")) {
					alert(".jpg 파일 또는 .png 파일만 업로드할 수 있습니다.");
					return false;
				}
			}

			if (!$("textarea").val()) {
				alert("내용을 입력하세요.");
				return false;
			}

			$(".noticeInsertForm").submit();
		});

		$(".list").click(function() {
			$(".insertForm").parents(".content").load("noticeList_admin.do?page=1");
		});
	});
</script>
</head>
<body>
	<div class="topMenu">
		<p>☆ 공지 등록</p>
	</div>
	<div class="insertForm">
		<form action="noticeInsert_admin.do" method="post" enctype="multipart/form-data" class="noticeInsertForm">
			<table>
				<tr>
					<th class="tdLabel">제목</th>
					<td class="tdData">
						<input type="text" name="subject">
					</td>
				</tr>
				<tr>
					<th class="tdLabel">이미지 등록</th>
					<td class="tdData">
						<input type="file" name="img">
					</td>
				</tr>
				<tr>
					<td colspan="2" class="tdData">
						<textarea name="content" rows="10" cols="45"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="bottomMenu">
		<input type="button" value="등록" class="submit">
		<input type="button" value="목록으로" class="list">
	</div>
</body>
</html>