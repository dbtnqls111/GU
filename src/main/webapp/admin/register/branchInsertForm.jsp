<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지점 등록</title>
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
<style type="text/css">
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

.header {
	height: 5%;
	background-color: #c4c4c4;
	border-bottom: 1px solid #aaaaaa;
	box-sizing: border-box;
}

.header p {
	display: inline;
	height: 100%;
	padding: 2px 5px;
	line-height: 2;
	font-weight: bold;
}

.body {
	height: 90%;
	background-color: #e2e2e2;
	padding: 10px 10px 0;
	margin-bottom: -10px;
}

.body table {
	width: 100%;
	margin: auto;
	border: 1px solid #aaaaaa;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #aaaaaa;
	padding: 5px;
	text-align: center;
	padding: 5px;
}

.tdLabel {
	background-color: #c4c4c4;
	font-weight: bold;
}

.tdData {
	background-color: white;
	padding: 0;
}

.tdData input {
	width: calc(100% - 10px);
	margin-left: 5px;
	margin-right: 5px;
	box-sizing: border-box;
	/* border-radius: 5px; */
}

.footer {
	height: 5%;
	background-color: #c4c4c4;
	border-top: 1px solid #aaaaaa;
	box-sizing: border-box;
	padding: 2px 5px;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<p>지점 등록</p>
		</div>
		<div class="body">
			<form action="../branch/branchInsert_admin.do" method="post" class="branchInsertForm">
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