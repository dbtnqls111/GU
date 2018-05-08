<%@page import="item.bean.ItemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/template/header.jsp"%>
<!DOCTYPE html>

<html>
<head>
	<title></title>
	
	<!-- jQuery UI -->
	<script type="text/javascript" src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css">
	
    <link rel="stylesheet" href="/GU/css/normalize.css"> <!-- http://webdir.tistory.com/455 참고 -->
    
    <!-- Swiper Slider Plugins -->
    <script src="/GU/js//swiper.min.js"></script>
    <link rel="stylesheet" href="/GU/css/swiper.min.css">
    
    <script type="text/javascript" src="/GU/script/list_function.js" charset="UTF-8"></script>
	<script type="text/javascript" src="/GU/script/list.js" charset="UTF-8"></script>
	<script type="text/javascript">
		$(function(){
			//																		◆ hot ◆
			// -------------------------------------------------------------------------------------------------------------
			var type1 = '${ type1 }';
			$.get("ajax/getNewItemList.jsp", { 'type1':type1 }, function(data){
				$(data).find("item").each(function(){
					var code = $(this).find("code").text();
					
					var realName = $(this).find("name").text();
					var name = realName;
					if(realName.length > 8){ name = realName.substring(0, 8) + "..."; }
					
					var price = $(this).find("price").text();

					$("#hot #title").html("오늘의 " + type1 + " 추천 상품!");
					$("#b_item" + $(this).index()).attr("code", code);
					$("#b_item" + $(this).index()).append("<div class='b_itemImg'><img src='../img/item/" + code + ".PNG' class='img' width='100%' height='90%'></div>" +
																		"<div class='b_itemDescription'>" +
																			"<div class='name'><span realName='" + realName + "' style='font-size:14px;'>" + name + "</span></div><br>" +
																			"<div class='price' style='font-size:18px; font-weight:bold;'><span>" + price + "</span>원</div>" +
																		"<div>");
					
					// "오늘의 ~ 추천 상품!" 반짝임 효과
					var flag = 0;
					window.setInterval(function(){
						if(flag == 0){
							$("#hot #title").css("color", "black");
							flag = 1;
						}else if(flag == 1){
							$("#hot #title").css("color", "red");
							flag = 0;
						}
					}, 250);
				});
			});
			// -------------------------------------------------------------------------------------------------------------
			
			
			// 																		◆ type2 ◆
			// -------------------------------------------------------------------------------------------------------------
			var target = "div[type1='${ type1 }'] .type2";

			$.ajax({
				url:"ajax/type2.html",
				type:"get",
				dataType:"html",
				timeout:10000,
				cache:false,
				
				success:function(data){
					var index = 1;
					/* 
						type2.html 파일을 보면 html 기본 태그들(html, body)을 주석 처리 해놓은 것을 볼 수가 있는데,
						그 이유는 type2.html의 내용을 ajax를 통해서 불러올 때는 html 기본 태그들(html, body 등)을 포함하여 있는 그대로를 불러오긴 하지만
						$(data)  ←  이와 같이 'jQuery 객체로 변환하는 과정'에서 문제가 발생하기 때문이다.(jQuery는 'html' 기본 태그들을 걷어낸다.')
						※실제로 ($(data))를 출력해보면 undefined가 출력된다.
					*/ 
					
					$(data).find(target).each(function(){
						var type2 = $(this).html();
						
						$("#type2 > ul").append("<li id='type2-" + index + "' class='type2'><a href='#'>" + type2 + "</a></li>");
						index++;
					});
					
					var type2_num = ${ type2 };
					$("#type2-" + type2_num).trigger("click"); // trigger : 강제 이벤트 발생시키기
				},

				error:function(xhr, textStatus, errorThrown){
					alert("Error...");
				}
			});
			// -------------------------------------------------------------------------------------------------------------

			
			// 																	  	   ◆ hot ◆
			// -------------------------------------------------------------------------------------------------------------
			$("#hot > #left").attr("src", "../img/hot/" + "${ type1 }" + ".jpg");
			// -------------------------------------------------------------------------------------------------------------
		});
	</script>
	<script>
		$(function(){
			var swiper = new Swiper(".swiper-container", {
				pagination:{ el:".swiper-pagination", clickable:true }
			});
			
			
			var index = 0;
			$(".swiper-pagination-bullet").each(function(){
				$(this).addClass("bullet" + index);
				index++;
			});
			index = index - 1; // 마지막 슬라이드의 index
			
			
			// 자동 슬라이드 기능
			window.setInterval(function(){
				$(".swiper-pagination-bullet").each(function(){
					if($(this).hasClass("swiper-pagination-bullet-active")){
						var cur_index = $(this).index();
						if(cur_index == index){ // 마지막 슬라이드라면 처음으로 다시 이동
							$(".bullet" + 0).trigger("click");
						}else{
							$(".bullet" + (cur_index + 1)).trigger("click");
						}
						return false;
					}
				});
			}, 3000);
		});
	</script>
	<link rel="stylesheet" type="text/css" href="/GU/css/list.css" />
	<link rel="stylesheet" type="text/css" href="/GU/css/index_and_list_public.css" />
</head>
<body>
	<div id="wrapper" type1="${ type1 }">
		
		
		<!-- ================================================================ -->
		
		<div id="hot">
			<img id="left" width="100%" height="100%">
			<div id="right">
				<div id="title"></div>
				<div id="list">
					<ul>
						<li id="b_item0"></li>
						<li id="b_item1"></li>
						<li id="b_item2"></li>
						<li id="b_item3"></li>
					</ul>
				</div>
			</div>
		</div>
		<div id="underline"><img src="../img/hot/hot_underline.png" width="100%"></div>
		
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
		
		<jsp:include page="../template/footer.jsp" />
		
		<!-- ================================================================ -->
		
		<!-- swiper로 시작되는 class들은 이름이 정해져 있는 것이므로 이름을 변경하면 안 된다. -->
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide"><img src="/GU/img/slider/img01.png" style="width:100%; height:100%;"></div>
				<div class="swiper-slide"><img src="/GU/img/slider/img02.png" style="width:100%; height:100%;"></div>
				<div class="swiper-slide"><img src="/GU/img/slider/img03.png" style="width:100%; height:100%;"></div>
			</div>
			<div class="swiper-pagination"></div>
		</div>
	</div>
	
	
	<!-- 상세보기 창 -->
	<div id="detail_dialog" title="상세보기" style="display:none;">
		<div id="detail">
			<div id="detail_left">
				<img src="" width="100%" height="100%">
			</div>
			<div id="detail_right">
				<h2 id="d_itemName"></h2>
				<div id="d_itemPrice">
					<strong>가격</strong> : <span style="font-family:-webkit-body;"></span>
				</div><br>
				<div id="d_itemDescription">
					<strong>설명</strong> : <span style="font-family:-webkit-body;"></span>
				</div><br>
				<div id="d_itemQuantity">
					<strong>수량</strong> :
					<input type="text" size="3" maxlength="3" onpaste="javascript:return false" onfocusout="removeChar(event)"
							  onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" style="ime-mode:disabled">
				</div><br>
			</div>
			<div class="btn">
				<button id="basket">장바구니</button> &nbsp;
				<button id="order">발주</button>
				<span id="hiddenInfo" memId=<%= session.getAttribute("memId") %>></span>
			</div>
		</div>
	</div>
	
	
	<!-- 장바구니 알림창 -->
	<div id="basket_alert_dialog" title="장바구니" style="display:none;">
		<div class="text">
			<span>
				해당 상품이 정상적으로 장바구니에 담겼습니다.<br>
				장바구니로 이동하시겠습니까?
			</span>
		</div>
		
		<div class="btn">
			<button id="moveBtn">장바구니 이동</button> &nbsp;
			<button id="continueBtn">쇼핑 계속</button>
		</div>
	</div>
	
	
	<div id="loader_background"></div>
	
	
	<img id="loader" src="../img/loader.gif" />
</body>
</html>