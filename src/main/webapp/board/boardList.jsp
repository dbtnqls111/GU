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
					+ '<td id="subjectTd"><a href="boardView.do?seq=${boardDTO.seq}&pg=${pg}" class="aTag">' + "${boardDTO.subject}" + '</a></td>'
					+ '<td class="tableAlignCenter">' + "${boardDTO.logtime}" 
					+ '</td>' + '<td class="tableAlignCenter">' + "${boardDTO.hit}" + '</td></tr>'));
		</c:forEach>
		
		<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
			$("#pageSpan").append($('<a href="boardList.do?pg=${i}" class="aTag" id="pageLink">' + "${i}" + '</a>'));
		</c:forEach>
		
		$("#pageStart").click(function(){
			location.href="boardList.do?pg=${startPage}";
		});
		
		$("#pagePre").click(function(){
			<c:if test="${pg>1}">
				location.href="boardList.do?pg=${pg-1}";
			</c:if>
			<c:if test="${pg==1}">
				location.href="boardList.do?pg=${pg}";
			</c:if>
		});
		
		$("#pageAfter").click(function(){
			<c:if test="${pg<endPage}">
				location.href="boardList.do?pg=${pg+1}";
			</c:if>
			<c:if test="${pg==endPage}">
				location.href="boardList.do?pg=${pg}";
			</c:if>
		});
		
		$("#pageEnd").click(function(){
			location.href="boardList.do?pg=${endPage}";
		});
	});
</script>

<link rel="stylesheet" type="text/css" href="css/boardList.css">

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
	<img alt="맨 앞으로" src="${pageContext.request.contextPath}/img/start_page.png" class="pageNaviIcon" id="pageStart">
	<img alt="이전" src="${pageContext.request.contextPath}/img/pre_arrow.png" class="pageNaviIcon" id="pagePre"><span class="pageText">이전</span>
	<span id="pageSpan"></span>	
	<span class="pageText">다음</span><img alt="다음" src="${pageContext.request.contextPath}/img/after_arrow.png" class="pageNaviIcon" id="pageAfter">
	<img alt="맨 뒤로" src="${pageContext.request.contextPath}/img/end_page.png" class="pageNaviIcon" id="pageEnd">
</div>
</div>
</body>

</html>