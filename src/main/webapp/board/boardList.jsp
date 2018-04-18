<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/template/header.jsp"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
	$(function(){
		<c:forEach var="boardDTO" items="${boardList}">			
			$("#boardTbody").append($('<tr><td class="tableAlignCenter">' + "${boardDTO.seq}" + '</td>' 
					+ '<td><a href="boardView.do?seq=${boardDTO.seq}&pg=${pg}">' + "${boardDTO.subject}" + '</a></td>'
					+ '<td class="tableAlignCenter">' + "${boardDTO.logtime}" 
					+ '</td>' + '<td class="tableAlignCenter">' + "${boardDTO.hit}" + '</td></tr>'));
		</c:forEach>
		
		<c:forEach var="i" begin="${startPage}" end="${endPage+1}" step="1">
			$("#pageSpan").append($('<a href="boardList.do?pg=${i}" class="pageLink">' + "${i}" + '</a>'));
		</c:forEach>
	});
</script>

<style type="text/css">
#wrapper{
	width:1050px;
	height:1500px;
	margin-left:250px;
}

#pageNavigator{
	text-align:center;
	padding-top:20px;
}

table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
 }
 
 #th_tr > th{
 	border-bottom: 4px double #444444;
 }
 
 th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
 }
 
 .tableAlignCenter{
 	text-align:center;
 }
 
 .pageNaviIcon{
 	width:20px;
 	height:20px;
 	vertical-align:middle;
 	cursor:pointer;
 }
 
 .pageText{
 	padding-left:8px;
 	padding-right:8px;
 }
 
.pageLink{
	padding-left:8px;
	padding-right:8px;
}
</style>

</head>

<body>
<div id = "wrapper">
<h2>공지사항</h2>
<table id="boardTable">
	<thead id="thead">
		<tr id="th_tr">
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>		
	</thead>
	
	<tbody id="boardTbody">
	</tbody>
</table>
<div id="pageNavigator">
	<img alt="맨 앞으로" src="${pageContext.request.contextPath}/img/start_page.png" class="pageNaviIcon">
	<img alt="이전" src="${pageContext.request.contextPath}/img/pre_arrow.png" class="pageNaviIcon"><span class="pageText">이전</span>
	<span id="pageSpan"></span>	
	<span class="pageText">다음</span><img alt="다음" src="${pageContext.request.contextPath}/img/after_arrow.png" class="pageNaviIcon">
	<img alt="맨 뒤로" src="${pageContext.request.contextPath}/img/end_page.png" class="pageNaviIcon">
</div>
</div>
</body>

</html>