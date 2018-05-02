<%@page import="item.bean.ItemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/template/header.jsp"%>
<!DOCTYPE html>

<%
	HashMap<String, ArrayList<String>> searchedResult = (HashMap<String, ArrayList<String>>)request.getAttribute("searchedResult");
	ArrayList<String> type1_disabled_list = new ArrayList<>();
	ArrayList<String> type2_disabled_list = new ArrayList<>();
	
	HashMap<String, String[]> type2_name_list = new HashMap<>();
	type2_name_list.put("간편식사", new String[]{"도시락", "샌드위치/햄버거", "주먹밥/김밥"});
	type2_name_list.put("즉석조리", new String[]{"튀김", "베이커리", "즉석커피"});
	type2_name_list.put("과자류", new String[]{"스낵", "빵", "껌/캔디"});
	type2_name_list.put("아이스크림", new String[]{"아이스크림"});
	type2_name_list.put("식품", new String[]{"가공식사", "안주", "식재료"});
	type2_name_list.put("음료", new String[]{"일반음료", "아이스드링크", "유제품"});
	type2_name_list.put("생활용품", new String[]{"취미/레저", "의약외품", "잡화"});

	if(searchedResult != null){
		for(String type1_name : searchedResult.keySet()){
			if(searchedResult.get(type1_name).size() == 0){
				type1_disabled_list.add(type1_name);
			}else{
				for(String type2_name01 : type2_name_list.get(type1_name)){
					int count = 0;
					for(String type2_name02 : searchedResult.get(type1_name)){
						if(type2_name02.equals(type2_name01)){
							count++;
							break;
						}
					}
					if(count == 0){ type2_disabled_list.add(type2_name01); }
				}
			}
		}
	}
%>

<html>
<head>
	<title></title>
	<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
	
	<script type="text/javascript" src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css">
	<!-- <script type="text/javascript" src="/GU/js/jquery-ui.js"></script> -->
	<!-- <link rel="stylesheet" href="/GU/css/searchedResult/jquery-ui.css" /> --> <!-- jquery-ui.css : jquery-ui.theme.css + jquery-ui.structure.css -->
	<!-- <link rel="stylesheet" href="/GU/css/searchedResult/jquery-ui.theme.css" /> -->
	<!-- <link rel="stylesheet" href="/GU/css/searchedResult/jquery-ui.structure.css" /> -->
    
    <script type="text/javascript" src="/GU/script/list_function.js"></script>
    <script type="text/javascript" src="/GU/script/searchedResult.js"></script>
	<link rel="stylesheet" href="/GU/css/searchedResult/searchedResult.css">
	<link rel="stylesheet" type="text/css" href="/GU/css/index_and_list_public.css">
	
	<script type="text/javascript">
		$(function(){
		<% if(searchedResult != null){ %>
				$(".type1 > span, .type2 > li").click(function(){
					var keyword = "${ keyword }";
					var type1;
					var type2;
					
					if($(this).attr("type1_check") != undefined){ // type1 유형의 메뉴를 클릭한 경우
						type1 = $(this).text();
						type2 = "%";
					}else{ // type2 유형의 메뉴를 클릭한 경우
						type1 = $(this).parents(".type1").find("span").html();
						type2 = $(this).text();
					}
					
					// [콘텐츠 구성]
					$.get("ajax/search.jsp", { "keyword":keyword, "type1":type1, "type2":type2 }, function(data){
						$("#content_area > ul").empty(); // ul 태그 내의 모든 내용 제거
						
						var itemBox_count = parseInt($(data).find("itemBox_count").text());
	
						for(var i = 0; i < itemBox_count; i++){
							$("#content_area > ul").append("<span id='itemBox" + i + "' class='itemBoxes'>");
							
							$(data).find("divide" + i + " > .item").each(function(){
								var code = $(this).find("code").text();
								
								var realName = $(this).find("name").text();
								var convertedName = realName;
								if(realName.length > 14){ convertedName = realName.substring(0, 14) + "..."; }
								
								var price = $(this).find("price").text();
	
								$("#itemBox" + i).append("<li code='" + code + "'>" +
																		"<p class='img'><img src='/GU/img/item/" + code + ".PNG' width='100%' height='230px'></p>" +
																		"<p class='name'><span realName='" + realName + "'>" + convertedName + "</span></p>" +
																		"<p class='price'><span>" + price + "</span>원</p>" +
																  "</li>");
							});
							
							$("#content_area > ul").append("</span>");
						}
						
						// itemBox1이 존재한다는 것은 itemBox가 2개 이상이라는 의미이므로 viewMore를 생성
						if($("#content_area #itemBox1").attr("class") != undefined){
							$("#content_area > ul").append("<div id='viewMore'>더 보기</div>");
						}
						
						
						// 첫 번째 itemBox만 출력
						$("#content_area .itemBoxes").not("#itemBox0").hide();
						
						
						// viewMore 이벤트 처리
						$("#viewMore").hover(function(){
							$("#viewMore").css({ "cursor":"pointer", "text-decoration":"underline" });
						}, function(){
							$("#viewMore").css("text-decoration", "none");
						});
						
						var view_level = 1;
						$("#viewMore").click(function(){
							var cur_itemBox = "#itemBox" + view_level;
							var next_itemBox = "#itemBox" + (view_level + 1);
							
							$(cur_itemBox).show();
							
							if($(next_itemBox).attr("id") == undefined){ $("#viewMore").hide(); }
							
							view_level++;
							
							// ----------------------------------------------------------------
							
							var height = parseInt($("#content").css("height"));
							$("#hidden_div").css("height", height + "px");
						   });
						
						
						var height = parseInt($("#content").css("height"));
						$("#hidden_div").css("height", height + "px");
					}); // 컨텐츠 구성(AJAX 사용) 끝
				});
		<% }else{ %>
				$("#menu, #content").hide();
				$("#not_searchedResult").show();
		<% } %>
		});
		
		
		$(function(){
			// type1 메뉴 비활성화 처리
			$(".type1").each(function(){
				var type1_name = $(this).find("span").html();
				var target = $(this).find("span"); // type1에 적용하면 type2에도 영향을 미치기 때문에 span에 적용
				var count = 0;
				
				<% for(String type1_name : type1_disabled_list){  %>
						if("<%= type1_name %>" == type1_name){
							$(target).addClass("disabled");
							count++;
						}
				<% } %>
				
				if(count == 0){ $(target).addClass("active"); }
			});
			
			// type2 메뉴 비활성화 처리
			$(".type2 > li").each(function(){
				var type2_name = $(this).text();
				var count = 0;
				
				<% for(String type2_name : type2_disabled_list){  %>
						if("<%= type2_name %>" == type2_name){
							$(this).addClass("disabled");
							count++;
						}
				<% } %>
				
				if(count == 0){ $(this).addClass("active"); }
			});
			
			
			$(".type1 > span.active").eq(0).trigger("click");
		});
	</script>
</head>
<body>
	<div id="wrapper">		
		<div id="show_keyword">'${ keyword }' 검색 결과</div>
		
		<div id="not_searchedResult" hidden="hidden">
			<div><img src="../img/not_searchedResult.png"></div>
			<div><span style="font-size:40px; font-weight:bold; color:#616161;">검색 결과가 존재하지 않습니다.</span></div>
		</div>
		
		<!-- -------------------------------------------------------------------------------------------------------- -->
		<ul id="menu">
			<li class="type1">
				<span type1_check="">간편식사</span>
				<ul class="type2">
					<li>도시락</li>
					<li>샌드위치/햄버거</li>
					<li>주먹밥/김밥</li>
				</ul>
			</li>
			
			<li class="type1">
				<span type1_check="">즉석조리</span>
				<ul class="type2">
					<li>튀김</li>
					<li>베이커리</li>
					<li>즉석커피</li>
				</ul>
			</li>
			
			<li class="type1">
				<span type1_check="">과자류</span>
				<ul class="type2">
					<li>스낵</li>
					<li>빵</li>
					<li>껌/캔디</li>
				</ul>
			</li>
			
			<li class="type1">
				<span type1_check="">아이스크림</span>
				<ul class="type2">
					<li>아이스크림</li>
				</ul>
			</li>
			
			<li class="type1">
				<span type1_check="">식품</span>
				<ul class="type2">
					<li>가공식사</li>
					<li>안주</li>
					<li>식재료</li>
				</ul>
			</li>
			
			<li class="type1">
				<span type1_check="">음료</span>
				<ul class="type2">
					<li>일반음료</li>
					<li>아이스드링크</li>
					<li>유제품</li>
				</ul>
			</li>
			
			<li class="type1">
				<span type1_check="">생활용품</span>
				<ul class="type2">
					<li>취미/레저</li>
					<li>의약외품</li>
					<li>잡화</li>
				</ul>
			</li>
		</ul>
	</div>
	
	<div id="content">
		<div id="menu_area"></div>
		<div id="content_area">
			<ul>
			</ul>
		</div>
	</div>
	
	
	<div id="hidden_div"></div>
	
	
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
	
	
	<jsp:include page="../template/footer.jsp" />
</body>
</html>