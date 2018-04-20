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
			if (!$("input[name='code']").val()) {
				alert("품목 코드를 입력하세요.");
				return false;
			}

			if (!$("input[name='type1']").val()) {
				alert("품목 타입1을 입력하세요.");
				return false;
			}

			if (!$("input[name='type2']").val()) {
				alert("품목 타입2를 입력하세요.");
				return false;
			}

			if (!$("input[name='brand']").val()) {
				alert("품목 브랜드를 입력하세요.");
				return false;
			}

			if (!$("input[name='name']").val()) {
				alert("품목명을 입력하세요.");
				return false;
			}

			if (!$("input[name='wup']").val()) {
				alert("입고단가를 입력하세요.");
				return false;
			}

			if (!$("input[name='uup']").val()) {
				alert("출고단가를 입력하세요.");
				return false;
			}

			$(".itemInsertForm").submit();
		});

		$(".reset").click(function() {
			$(".itemInsertForm").each(function() {
				this.reset();
			})
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
			<form action="itemInsert_admin.do" method="post" class="itemInsertForm">
				<table>
					<tr>
						<td class="tdLabel">품목 코드</td>
						<td class="tdData">
							<input type="text" name="code">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">품목 타입1</td>
						<td class="tdData">
							<input type="text" name="type1">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">품목 타입2</td>
						<td class="tdData">
							<input type="text" name="type2">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">품목 브랜드</td>
						<td class="tdData">
							<input type="text" name="brand">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">품목명</td>
						<td class="tdData">
							<input type="text" name="name">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">입고단가</td>
						<td class="tdData">
							<input type="number" name="wup">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">출고단가</td>
						<td class="tdData">
							<input type="number" name="uup">
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