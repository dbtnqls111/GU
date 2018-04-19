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
	<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css"> <!-- jQuery UI CSS file load -->
	<script type="text/javascript" src="/GU/script/list.js" charset="UTF-8"></script>
	<script type="text/javascript">
		$(function(){
			// 																		◆ type2 ◆
			// -------------------------------------------------------------------------------------------------------------
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
			alert("test");
			$("#type2-0").trigger("click"); // trigger : 강제 이벤트 발생시키기	
			// -------------------------------------------------------------------------------------------------------------

			
			// 																	  	   ◆ hot ◆
			// -------------------------------------------------------------------------------------------------------------
			$("#hot img").attr("src", "../img/hot_img/" + "${ type1 }" + ".jpg");
			// -------------------------------------------------------------------------------------------------------------
			
			
			//																             ◆ search ◆
			// -------------------------------------------------------------------------------------------------------------
			$(document).on("click", "#mj_btn_area > img", function(){
				var url = "ajax/search.jsp";
				var keyword = $("#mj_input02 #search_text").val();
				var type2 = $("#type2 li[class='type2 selected'] > a").text();
				
				var lowest_price = $("#mj_input01 input[name='lowest']").val();
				var highest_price = $("#mj_input01 input[name='highest']").val();
				
				if(lowest_price != ""){
					if(isNaN(parseInt(lowest_price))){
						alert("숫자만 입력해주세요.");
						return;
					}
				}else{
					lowest_price = -1;
				}
				
				if(highest_price != ""){
					if(isNaN(parseInt(highest_price))){
						alert("숫자만 입력해주세요.")
						return;
					}
				}else{
					highest_price = -1;
				}
		
				var param = { "keyword":keyword, "type2":type2, "lowest_price":lowest_price, "highest_price":highest_price };
				content_revalidate(url, param);
				
				return false;
			});
			// -------------------------------------------------------------------------------------------------------------
		});
	</script>
	<link rel="stylesheet" type="text/css" href="/GU/css/list.css" />
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../template/header.jsp" />
		
		<!-- ================================================================ -->
		
		<div id="navigator">
			<ul>
				<li id="nav0" class="nav"><a href="#">^^</a></li>
				<li id="nav1" class="nav"><a href="#">^^</a></li>
				<li id="nav2" class="nav"><a href="#">^^</a></li>
				<li id="nav3" class="nav"><a href="#">^^</a></li>
				<li id="nav4" class="nav"><a href="#">^^</a></li>
			</ul>
		</div>
		
		<!-- ================================================================ -->
		
		<div id="hot">
			<img id="left" width="100%" height="100%">
			<div id="right">
				<table>
					<tr><td></td> <td></td></tr>
					<tr><td></td> <td></td></tr>
				</table>
			</div>
		</div>
		
		<!-- ================================================================ -->
		
		<div id="type2">
			<ul>
				<li id="type2-0" class="type2"><a href="#">전체</a></li>
			</ul>
		</div>
		
		<!-- ================================================================ -->
		
		<div id="mj_search">
			<div id="mj_input_area">
				<div id="mj_input01">
					<p id="mj_title01">가격대 검색</p>
					<ul>
						<li><input type="radio" name="price_range" id="price_range01">1500원 이하
						<li><input type="radio" name="price_range" id="price_range02">1500원 ~ 3000원
						<li><input type="radio" name="price_range" id="price_range03">3000원 이상
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
			
			<div id="mj_btn_area">
				<img src="../img/searchBtn_up.png" width="90px" height="90px">
			</div>
		</div>
		
		<!-- ================================================================ -->
		
		<div id="content">
			<ul>
			</ul>
		</div>
		
		<!-- ================================================================ -->
		
		<div id="viewMore">더 보기</div>
		 
		 <!-- ================================================================ -->
		 
		<div id="list_footer">Copyright ⓒ</div>
		
		<!-- ================================================================ -->
		
		<jsp:include page="../template/footer.jsp" />
		
		<!-- ================================================================ -->
		
		<div id="moving_banner"></div>
	</div>
	
	<div id="dialog" title="상세보기">
		<div id="detail_main">
			<div id="detail_img">
				<img src="../img/백종원 달콤 통돈까스 삼각김밥.jpg" width="100%" height="100%">
			</div>
			<div id="detail_description">
				<h2>백종원 달콤 통돈까스 삼각김밥</h2>
				<p>가격 : 1600원</p>
				<p>상품 설명 : 맛있다.</p>
			</div>
		</div>
		
		<div id="detail_commnet">
			<div id="comment_img"><img src="../img/comment_img.png" width="100%" height="100%"></div>
			<div id="comment_input"><textarea style="width:100%; height:100%; resize:none;"></textarea></div>
			<div id="comment_btn"><button id="comment_regist_btn" style="width:100%; height:100%;">등록</button></div>
		</div>
	</div>
	
	<div id="loader_background"></div>
	
	<img id="loader" src="../img/loader.gif" />
</body>
</html>