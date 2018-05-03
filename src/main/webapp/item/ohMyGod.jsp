<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="item.bean.ItemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/template/header.jsp"%>
<!DOCTYPE html>

<%
	HashMap<String, HashMap<String, ArrayList<ItemDTO>>> searchedResult = (HashMap<String, HashMap<String, ArrayList<ItemDTO>>>)request.getAttribute("searchedResult");

	HashMap<String, String[]> name_list = new HashMap<>();
	name_list.put("간편식사", new String[]{"도시락", "샌드위치/햄버거", "주먹밥/김밥"});
	name_list.put("즉석조리", new String[]{"튀김", "베이커리", "즉석커피"});
	name_list.put("과자류", new String[]{"스낵", "빵", "껌/캔디"});
	name_list.put("아이스크림", new String[]{"아이스크림"});
	name_list.put("식품", new String[]{"가공식사", "안주", "식재료"});
	name_list.put("음료", new String[]{"일반음료", "아이스드링크", "유제품"});
	name_list.put("생활용품", new String[]{"취미/레저", "의약외품", "잡화"});

	String[] type1_name_list = { "간편식사", "즉석조리", "과자류", "아이스크림", "식품", "음료", "생활용품" };
	String[] type2_name_list = null;
	
	String disableTarget = "";
	
	if(searchedResult != null){
		for(int i = 0; i < type1_name_list.length; i++){
			if(searchedResult.get(type1_name_list[i]).size() == 0){
				disableTarget += i + ",";
			}
		}
	}
%>

<html>
<head>
	<title></title>
	<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
	
	<script type="text/javascript" src="/GU/js/jquery-ui.js"></script>
	<link rel="stylesheet" href="/GU/css/searchedResult/jquery-ui.css" /> <!-- jquery-ui.css : jquery-ui.theme.css + jquery-ui.structure.css -->
	<!-- <link rel="stylesheet" href="/GU/css/searchedResult/jquery-ui.theme.css" /> -->
	<!-- <link rel="stylesheet" href="/GU/css/searchedResult/jquery-ui.structure.css" /> -->
    
    <script type="text/javascript" src="/GU/script/searchedResult.js"></script>
	<link rel="stylesheet" href="/GU/css/searchedResult/searchedResult.css">
	
	<script type="text/javascript">
		$()
	
		// -------------------------------------------------------------------------------------------------------------
		$(function(){
	        <%
	        	if(searchedResult != null){
	        %>
	        		$("#tabs").tabs({ disabled:[<%= disableTarget %>] });
	        <%
		        	for(int i = 0; i < type1_name_list.length; i++){
		        		int itemBox_index = -1;
		        		int count = 0;
		        		
		        		HashMap<String, ArrayList<ItemDTO>> type2_list = searchedResult.get(type1_name_list[i]);
		        		type2_name_list = name_list.get(type1_name_list[i]);
		        		
		        		for(int j = 0; j < type2_name_list.length; j++){
		        			String convertedName = type2_name_list[j].replace("/", "_"); // 선택자로 '/' 기호는 사용할 수 없으므로 변환
		        			if(!(type2_list.containsKey(type2_name_list[j]))){ // 아이템이 들어있지 않은 type2 메뉴는 비활성화
			%>
								$("#<%= convertedName %>").css({
									"cursor":"default",
									"border":"1px solid #aed0ea",
									"background":"#d7ebf9 url('/GU/img/ui-bg_glass_80_d7ebf9_1x400.png') 50% 50% repeat-x",
									"color":"#90CAF9"
								});
			<%
		        			}else{
			%>
								<%-- // 아이템이 들어있는 type2 메뉴 이벤트 처리
								$("#<%= convertedName %>").click(function(){
									$("#tabMenu-<%= i %> > a").trigger("click");
									$("#tabs-<%= i %>").
								}); --%>
			<%
		        				ArrayList<ItemDTO> itemList = type2_list.get(type2_name_list[j]);
		        			
		        				for(ItemDTO itemDTO : itemList){
				        			if(count % 12 == 0){
				        				itemBox_index++;
			%>
										$("#tabs-<%= i %> > ul").append("<span id='itemBox<%= itemBox_index %>' class='itemBoxes'></span>");
			<%
					        		}
			        				String code = itemDTO.getCode();
			        				
				        			String realName = itemDTO.getName();
				        			String reducedName = realName;
				        			if(realName.length() > 14){ reducedName = realName.substring(0, 14) + "..."; }
			        			
			        				int price = itemDTO.getUup();
			%>
									$("#tabs-<%= i %> > ul #itemBox<%= itemBox_index %>").append("<li code='<%= code %>'>" +
											"<p class='img'><img src='/GU/img/item/<%= code %>.PNG' width='100%' height='230px'></p>" +
											"<p class='name'><span realName='<%= realName %>'><%= reducedName %></span></p>" +
											"<p class='price'><span><%= price %></span>원</p>" +
									  "</li>");
			<%
		        					count++;
		        				}
		        			}
		        		}
			%>
		        		// 'viewMore 생성'
						$("#tabs-<%= i %> > ul").append("<div id='viewMore<%= i %>' class='viewMore'>더 보기</div>");
						
						// -------------------------------------------------------------------------------------------
						
						// type2 메뉴 위치 셋팅
						var left = $("#tabMenu-<%= i %>").offset().left;
						var top = $("#tabMenu-<%= i %>").offset().top + $("#tabMenu-<%= i %>").height() - 13;
						
						$(".type2-<%= i %>").css({
							"top":top,
							"left":left
						});
						
						
						// 탭에 갖다 댔을 때 type2 리스트 출력
						var flag = 0;
						$("#tabMenu-<%= i %>").mouseenter(function(){
							$(".type2-<%= i %>").stop().show(200);
						})
						
						$(".type2-<%= i %>").mouseleave(function(){
							$(".type2-<%= i %>").stop().hide(200);
						});
						
						
						var view_level = 1;
						// 메뉴 탭이 클릭될 때마다 기본 셋팅으로 초기화하는 역할
						$("#tabMenu-<%= i %>").click(function(){
							view_level = 1; // view_level 초기화
							
							// 첫 번째 itemBox만 출력
							$("#tabs-<%= i %> .itemBoxes").not("#itemBox0").hide();
							
							// itemBox1이 존재한다는 것은 itemBox가 2개 이상이라는 의미이므로 viewMore를 출력
							if($("#tabs-<%= i %> #itemBox1").attr('class') != undefined){
								$("#viewMore<%= i %>").show();
							}else{
								$("#viewMore<%= i %>").hide();
							}
						});
						
						// -------------------------------------------------------------------------------------------
						
						// viewMore 이벤트 처리
						$("#viewMore<%= i %>").hover(function(){
							$("#viewMore<%= i %>").css({
								"cursor":"pointer",
								"text-decoration":"underline"
							});
						}, function(){
							$("#viewMore<%= i %>").css("text-decoration", "none");
						});
						
						$("#viewMore<%= i %>").click(function(){
							var cur_itemBox = "#tabs-<%= i %> #itemBox" + view_level;
							var next_itemBox = "#tabs-<%= i %> #itemBox" + (view_level + 1);
							
							$(cur_itemBox).show();
							
							if($(next_itemBox).attr("id") == undefined){
								$("#viewMore<%= i %>").hide();
							}
							
							view_level++;
						});
			<%
		        	} // 전체 for문의 끝
			%>
					// 활성화 상태인 탭들 중 첫 번째 탭을 선택
		    		$("#tabs > ul > li").each(function(){
		    			if(!($(this).hasClass("ui-state-disabled"))){
		    				$(this).find("a").trigger("click");
		    				
		    				return false; // http://dhplanner.blogspot.kr/search?q=each+break 참고
		    			}
		    		});
			<%
	        	}else{
			%>
	        		$("#tabs").hide();
	        		$("#not_searchedResult").show();
			<%
	        	}
			%>
	    });
	</script>
</head>
<body>
	<div id="wrapper">
		<div id="w_left">
		</div>
		
		<div id="w_center">
			<div id="show_keyword">'${ keyword }' 검색 결과</div>
			<div id="tabs" style="background:white;">
			    <ul>
			        <li id="tabMenu-0" class="first_tabMenu"><a href="#tabs-0">간편식사</a></li>
			        <li id="tabMenu-1"><a href="#tabs-1">즉석조리</a></li>
			        <li id="tabMenu-2"><a href="#tabs-2">과자류</a></li>
			        <li id="tabMenu-3"><a href="#tabs-3">아이스크림</a></li>
			        <li id="tabMenu-4"><a href="#tabs-4">식품</a></li>
			        <li id="tabMenu-5"><a href="#tabs-5">음료</a></li>
			        <li id="tabMenu-6"><a href="#tabs-6">생활용품</a></li>
			    </ul>
			    <div id="tabs-0" class="content"><ul></ul></div>
				<div id="tabs-1" class="content"><ul></ul></div>
				<div id="tabs-2" class="content"><ul></ul></div>
				<div id="tabs-3" class="content"><ul></ul></div>
				<div id="tabs-4" class="content"><ul></ul></div>
				<div id="tabs-5" class="content"><ul></ul></div>
				<div id="tabs-6" class="content"><ul></ul></div>
			</div>
			
			<div id="not_searchedResult" hidden="hidden">
				<div><img src="../img/not_searchedResult.png"></div>
				<div><span style="font-size:40px; font-weight:bold; color:#616161;">검색 결과가 존재하지 않습니다.</span></div>
			</div>
			
			<div id="type2">
				<ul id="간편식사" class="type2-0">
					<li id="도시락">도시락</li>
					<li id="샌드위치_햄버거">샌드위치/햄버거</li>
					<li id="주먹밥_김밥">주먹밥/김밥</li>
				</ul>
				
				<ul id="즉석조리" class="type2-1">
					<li id="튀김">튀김</li>
					<li id="베이커리">베이커리</li>
					<li id="즉석커피">즉석커피</li>
				</ul>
				
				<ul id="과자류" class="type2-2">
					<li id="스낵">스낵</li>
					<li id="빵">빵</li>
					<li id="껌_캔디">껌/캔디</li>
				</ul>
				
				<ul id="아이스크림" class="type2-3">
					<li id="아이스크림">아이스크림</li>
				</ul>
				
				<ul id="식품" class="type2-4">
					<li id="가공식사">가공식사</li>
					<li id="안주">안주</li>
					<li id="식재료">식재료</li>
				</ul>
				
				<ul id="음료" class="type2-5">
					<li id="일반음료">일반음료</li>
					<li id="아이스드링크">아이스드링크</li>
					<li id="유제품">유제품</li>
				</ul>
				
				<ul id="생활용품" class="type2-6">
					<li id="취미_레저">취미/레저</li>
					<li id="의약외품">의약외품</li>
					<li id="잡화">잡화</li>
				</ul>
			</div>
		
			<div id="w_right">
			
			</div>
		</div>
		<jsp:include page="../template/footer.jsp" />
	</div>
</body>
</html>