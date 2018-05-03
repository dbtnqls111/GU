<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 등록</title>
<link rel="stylesheet" type="text/css" href="css/register_form.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".wrapper").css("width", $(window).width());
		$(".wrapper").css("height", $(window).height());

		$(".submit").click(function() {
			var fileName = $("input[name='upload']").val();

			if (!fileName) {
				alert("파일을 선택하세요.");
				return false;
			} else if (!(fileName.substr(fileName.length - 4) == ".xls") && !(fileName.substr(fileName.length - 5) == ".xlsx")) {
				alert(".xls 파일 또는 .xlsx 파일만 업로드할 수 있습니다.");
				return false;
			}

			$(".fileUploadForm").submit();
		});
	});
</script>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<p>품목 등록</p>
		</div>
		<div class="body">
			<form action="itemExcelInsert_admin.do" method="post" enctype="multipart/form-data" class="fileUploadForm">
				<table>
					<tr>
						<td class="tdLabel">Excel 파일 선택</td>
						<td class="tdData">
							<input type="file" name="upload">
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="footer">
			<input type="button" value="저장" class="submit">
			<input type="button" value="닫기" onclick="window.close()">
		</div>
	</div>
</body>
</html>