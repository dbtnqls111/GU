<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 수정</title>
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
				alert("품목 타입을 입력하세요.");
				return false;
			}

			if (!$("input[name='type2']").val()) {
				alert("세부 타입을 입력하세요.");
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

			$(".itemUpdateForm").submit();
		});

		$(".reset").click(function() {
			$(".itemUpdateForm").each(function() {
				this.reset();
			})
		});
	});
</script>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<p>품목 수정</p>
		</div>
		<div class="body">
			<form action="itemUpdate_admin.do" method="post" class="itemUpdateForm">
				<table>
					<tr>
						<td class="tdLabel">품목 코드</td>
						<td class="tdData">
							<input type="text" name="code" value="${itemDTO.code}" disabled="disabled">
							<input type="hidden" name="code" value="${itemDTO.code}">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">품목 타입</td>
						<td class="tdData">
							<input type="text" name="type1" value="${itemDTO.type1}">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">세부 타입</td>
						<td class="tdData">
							<input type="text" name="type2" value="${itemDTO.type2}">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">품목 브랜드</td>
						<td class="tdData">
							<input type="text" name="brand" value="${itemDTO.brand}">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">품목명</td>
						<td class="tdData">
							<input type="text" name="name" value="${itemDTO.name}">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">입고단가</td>
						<td class="tdData">
							<input type="number" name="wup" value="${itemDTO.wup}">
						</td>
					</tr>
					<tr>
						<td class="tdLabel">출고단가</td>
						<td class="tdData">
							<input type="number" name="uup" value="${itemDTO.uup}">
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