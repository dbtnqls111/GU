﻿<%@page import="item.bean.ItemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
	<title></title>
	<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css"> <!-- jQuery UI CSS file load -->
    <link rel="stylesheet" href="/GU/css/normalize.css"> <!-- http://webdir.tistory.com/455 참고 -->
	<script type="text/javascript" src="/GU/script/list.js" charset="UTF-8"></script>
	<script type="text/javascript">
		$(function(){
			$("#type2-0").trigger("click"); // trigger : 강제 이벤트 발생시키기
			
			// 																		◆ type2 ◆
			// -------------------------------------------------------------------------------------------------------------
			var target = "." + '${ type1 }' + " a";
			$.ajax({
				url:"ajax/type2.html",
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
			// -------------------------------------------------------------------------------------------------------------

			
			// 																	  	   ◆ hot ◆
			// -------------------------------------------------------------------------------------------------------------
			$("#hot img").attr("src", "../img/hot/" + "${ type1 }" + ".jpg");
			// -------------------------------------------------------------------------------------------------------------
		});
	</script>
	<link rel="stylesheet" type="text/css" href="/GU/css/list.css" />
</head>
<body>
	<div id="wrapper" type1="${ type1 }">
		<jsp:include page="../template/header.jsp" />
		
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
						<li id="price_li01"><input type="radio" name="price_range" id="price_range01">1500원 이하
						<li id="price_li02"><input type="radio" name="price_range" id="price_range02">1500원 ~ 3000원
						<li id="price_li03"><input type="radio" name="price_range" id="price_range03">3000원 이상
					</ul>
					<div id="input_priceRange">
						<!--
							몇몇 브라우저에서는 input type="number"를 지원하지 않으므로 실제 서비스를 할 땐 다음 방법을 이용해야 한다.
							http://webskills.kr/archives/310 참고
						-->
						
						<!-- onpaste="javascript:return false" : 복사 방지 -->
						<input type="text" name="lowest_price" size="10" maxlength="9" onpaste="javascript:return false" onfocusout="removeChar(event)"
								  onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" style="ime-mode:disabled">
						<label for="">원 ~</label> 
						<input type="text" name="highest_price" size="10" maxlength="9" onpaste="javascript:return false" onfocusout="removeChar(event)"
								  onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" style="ime-mode:disabled">
						<label for="">원</label>
					</div>
				</div>
				
				<div id="mj_input02">
					<p id="mj_title02">검색</p>
					<input type="text" name="keyword" id="search_text">
				</div>
			</div>
			
			<div id="mj_btn_area">
				<img src="../img/searchBtn_up.png" width="80px" height="80px">
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
	
	<div id="dialog" title="상세보기" style="display:none;">
		<div id="detail">
			<div id="detail_left">
				<img src="" width="100%" height="100%">
			</div>
			<div id="detail_right">
				<h2 id="d_itemName"></h2>
				<p id="d_itemPrice"></p>
				<p id="d_itemDescription"></p>
				<p id="d_itemQuantity">수량 :
					<input type="text" size="3" maxlength="3" onpaste="javascript:return false" onfocusout="removeChar(event)"
							  onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" style="ime-mode:disabled">
				</p>
			</div>
			<div id="btn">
				<button>장바구니</button> &nbsp;
				<button>발주</button>
			</div>
		</div>
	</div>
	
	<div id="loader_background"></div>
	
	<img id="loader" src="../img/loader.gif" />
</body>
</html>