<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 등록</title>
</head>
<body>
	<form name="fileUpload" action="itemExcelInsert_admin.do" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>
					<input type="file" name="upload" required="required">
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="저장">
					<input type="button" value="닫기" onclick="window.close()">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>