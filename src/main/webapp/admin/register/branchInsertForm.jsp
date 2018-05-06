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

		$(".duplCheck").click(function() {
			if (!$("input[name='code']").val()) {
				alert("지점 코드를 입력하세요.");
				return false;
			}
			var cw = screen.availWidth;
			var ml = (cw - 600) / 2 + 600;
			window.open("branchCodeCheck_admin.do?code=" + $(".code").val(), "", "width=300,height=120,left=" + ml);
		});

		$(".code").change(function() {
			$(".isValid").attr("value", "no");
			$(".duplCheck").attr("value", "중복 검사");
			$(".duplCheck").css("background-color", "#c9e1ff");
			$(".duplCheck").css("color", "black");
			$(".duplCheck").removeAttr("disabled");
			$(".duplCheck").hover(function() {
				$(this).css("background-color", "#66aaff");
				$(this).css("color", "white");
			}, function() {
				$(this).css("background-color", "#c9e1ff");
				$(this).css("color", "black");
			});
		});

		$(".submit").click(function() {
			if ($(".isValid").val() == "no") {
				alert("코드 중복 검사를 하세요.");
				return false;
			}

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
							<input type="text" name="code" class="code">
							<input type="button" value="중복 검사" class="duplCheck">
							<input type="hidden" class="isValid" value="no">
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