<%@page import="item.bean.ItemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/template/header.jsp"%>
<!DOCTYPE html>

<%
	ArrayList<ArrayList<ItemDTO>> searchedResult = (ArrayList<ArrayList<ItemDTO>>)request.getAttribute("searchedResult");
	String disableTarget = "";
	
	if(searchedResult != null){
		int tabIndex = 0;
		for(ArrayList<ItemDTO> tmp : searchedResult){
			if(tmp.size() == 0){
				disableTarget += tabIndex + ",";
			}
			
			tabIndex++;
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
		$(function(){
	        <%
	        	if(searchedResult != null){
	        %>
	        		$("#tabs").tabs({ disabled:[<%= disableTarget %>] });
	        <%
		        	int i = 0;
		        	int itemBox_index;
		        	for(ArrayList<ItemDTO> tmp : searchedResult){
		        		itemBox_index = -1;
		        		System.out.println(i + "번 tab : " + tmp.size() + "개");
		        		for(int j = 0; j < tmp.size(); j++){
		        			if(j % 12 == 0){
		        				++itemBox_index;
			%>
		        				$("#tabs-<%= i %> > ul").append("<span id='itemBox<%= itemBox_index %>' class='itemBoxes'></span>");
			<%
		        			}
		        			String code = tmp.get(j).getCode();
		        			String realName = tmp.get(j).getName();
		        			String convertedName = realName;
		        			if(realName.length() > 14){ convertedName = realName.substring(0, 14) + "..."; }
		        			
		        			int price = tmp.get(j).getUup();
			%>
							$("#tabs-<%= i %> > ul #itemBox<%= itemBox_index %>").append("<li code='<%= code %>'>" +
																	"<p class='img'><img src='/GU/img/item/<%= code %>.PNG' width='100%' height='230px'></p>" +
																	"<p class='name'><span realName='<%= realName %>'><%= convertedName %></span></p>" +
																	"<p class='price'><span><%= price %></span>원</p>" +
															  "</li>");
							
			<%
			        	}
			%>
						// 'viewMore 생성'
						$("#tabs-<%= i %> > ul").append("<div id='viewMore<%= i %>' class='viewMore'>더 보기</div>");
						
						// -------------------------------------------------------------------------------------------
						
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
						i++;
		        	}
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
		</div>
		
		<div id="w_right">
			
		</div>
		<jsp:include page="../template/footer.jsp" />
	</div>
</body>
</html>