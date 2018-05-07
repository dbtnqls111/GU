<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/template/header.jsp" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
	function check(){
		var width = $(this).height(); 		
    	var padding = (1050-width)/2;
    	var paddingSize = parseInt(Math.abs(padding))-40;   	
		return paddingSize;
	}

	function boardView(){
		$("#subject").text("${boardDTO.subject}");
		$("#logtime").text("${boardDTO.logtime}");
		$("#hit").text("${boardDTO.hit}");
		
		$.ajax({
		     url: '${pageContext.request.contextPath}/img/${boardDTO.img}',
		     type: 'HEAD',
		     success: function () {
		    	$("#contentImg").append($('<img id="boardImg" src="${pageContext.request.contextPath}/img/${boardDTO.img}" onload="javascript:check()">'));
		    			    	
		    	var width = check();
		    	
		    	$("#contentTd").css("text-align", "center");
		    	$("#contentDiv").css("text-align", "left");
		    	$("#contentDiv").css("padding-left", width+"px");
		    	$("#contentImg").after($("<br>"));
		    	},
		     error: function () {
		     }
		});
	}

	$(function(){
		boardView();
		
		$("#boardListButton").click(function(){
			var pg = "${pg}";
			location.href="boardList.do?pg="+pg;
		});
	});
</script>

<link rel="stylesheet" type="text/css" href="css/boardView.css">

</head>
<body>
<div id="boardViewWrap">
	<table id="board">
		<thead>
			<tr>
				<td class="right" width="60px">제목
				<td id="subject" colspan="3">			
			</tr>
			<tr id="bottom">
				<td  class="right" >작성일
				<td id="logtime"  class="right">
				<td  class="right" width="60px">조회수
				<td id="hit">
			</tr>
		</thead>
		<tbody>
			<tr>
				<td id="contentTd" colspan="4" align="center">
					<div id="contentDiv"><pre id="content">${boardDTO.content}</pre></div>
					<span id="contentImg"></span>								
				</td>
			</tr>
		</tbody>
	</table>
	
	<div id="boardListButtonWrap">
		<input type="button" id="boardListButton" value="목록">
	</div>
</div>
</body>
</html>