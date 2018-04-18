<%@page import="item.bean.ItemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<%
	ArrayList<ItemDTO> item_list = (ArrayList<ItemDTO>)request.getAttribute("item_list");
%>

<html>
<head>
	<title></title>
	<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js?v=1"></script>
	<script type="text/javascript" src="/GU/script/list.js?v=1" charset="UTF-8"></script>
	<script type="text/javascript">
		// type2 영역 관련 코드
		$(function(){
			// ----------------------------------------------------------------------------------------------------------
			
			var target = "." + '${ type1 }' + " a";
			
			$.ajax({
				url:"category/type2.html",
				type:"get",
				dataType:"html",
				timeout:10000,
				cache:false,
				
				success:function(data){
					var index = 1;
					
					$(data).find(target).each(function(){
						var type2 = $(this).html();
						
						$("#type2 > ul").append("<li id='type2-" + index + "' class='type2'><a href='#'>" + type2 + "</a></li>");
						index++;
					});
				},

				error:function(xhr, textStatus, errorThrown){
					alert("Error...");
				}
			});
			
			
			// 첫 화면 '전체'' 메뉴 출력
			$("#type2-0").trigger("click"); // trigger : 강제 이벤트 발생시키기
			
			
			// hot 메인 이미지 출력
			$("#hot img").attr("src", "../img/hot_img/" + "${ type1 }" + ".jpg");
		});
	</script>
	<link rel="stylesheet" type="text/css" href="/GU/css/list.css" />
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../template/header.jsp" />
		
		
		<div id="navigator">
			<ul>
				<li id="nav0" class="nav"><a href="#">^^</a></li>
				<li id="nav1" class="nav"><a href="#">^^</a></li>
				<li id="nav2" class="nav"><a href="#">^^</a></li>
				<li id="nav3" class="nav"><a href="#">^^</a></li>
				<li id="nav4" class="nav"><a href="#">^^</a></li>
			</ul>
		</div>
		
		
		<div id="hot">
			<img id="left" width="100%" height="100%">
			<div id="right">
				<table>
					<tr><td></td> <td></td></tr>
					<tr><td></td> <td></td></tr>
				</table>
			</div>
		</div>
		
		
		<div id="type2">
			<ul>
				<li id="type2-0" class="type2"><a href="#">전체</a></li>
			</ul>
		</div>
		
		<div id="mj_search">
			<div id="mj_input">
				<div id="mj_input01">
					<p id="mj_title01">가격대 검색</p>
					<ul>
						<li><input type="radio" name="price_range" id="price_range01">1500원 이하
						<li><input type="radio" name="price_range" id="price_range02">1500원 ~ 3000원
						<li><input type="radio" name="price_range" id="price_range03">5000원 이상
					</ul>
					<div id="input_priceRange">
						<input type="text" name="lowest" size="10">
						<label for="">원 ~</label> 
						<input type="text" name="highest" size="10">
						<label for="">원</label>
					</div>
				</div>
				
				<div id="mj_input02">
					<p id="mj_title02">검색</p>
					<input type="text" name="keyword" id="search_text">
				</div>
			</div>
			
			<div id="mj_searchBtn">
				<img src="../img/searchBtn_up.png" width="90px" height="90px">
			</div>
		</div>
		
		
		<div id="content">
			<ul>
			</ul>
		</div>
		
		
		<div id="viewMore">더 보기</div>
		 
		 
		<div id="list_footer">Copyright ⓒ</div>
		
		
		<jsp:include page="../template/footer.jsp" />
		
		
		<div id="moving_banner"></div>
	</div>
	
	<div id="loader_background"></div>
	<img id="loader" src="../img/loader.gif" />
</body>
</html>