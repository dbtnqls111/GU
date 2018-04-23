<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지점 등록</title>
<link rel="stylesheet" type="text/css" href="css/register_form.css">
<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".wrapper").css("width", $(window).width());
		$(".wrapper").css("height", $(window).height());

		$(".submit").click(function() {
			if (!$("input[name='code']").val()) {
				alert("지점 코드를 입력하세요.");
				return false;
			}

			if (!$("input[name='name']").val()) {
				alert("지점명을 입력하세요.");
				return false;
			}

			if (!$("input[name='address']").val()) {
				alert("지점 주소를 입력하세요.");
				return false;
			}

			$(".branchInsertForm").submit();
		});
		
		$(".reset").click(function() {
			$(".branchInsertForm").each(function() {
				this.reset();
			})
		});
	});
</script>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<p>지점 등록</p>
		</div>
		<div class="body">
			<form action="branchInsert_admin.do" method="post" class="branchInsertForm">
				<table>
					<tr>
						<td class="tdLabel">지점 코드</td>
						<td class="tdData">
							<input type="text" name="code">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">지점명</td>
						<td class="tdData">
							<input type="text" name="name">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">지점 주소</td>
						<td class="tdData">
							<input type="text" name="address">
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="footer">
			<input type="button" value="저장" class="submit">
			<input type="button" value="다시작성" class="reset">
			<input type="button" value="닫기" onclick="window.close()">
		</div>
	</div>
</body>
</html>