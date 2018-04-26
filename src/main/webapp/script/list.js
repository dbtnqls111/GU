var view_level; // 더 보기 level

$(function(){
	//																		     ◆ hot ◆ 
	// ---------------------------------------------------------------------------------------------------------------
	$("#hot").on("mouseenter", ".img", function(){
		$(this).css("cursor", "pointer");
	});
	
	$("#hot").on("mouseenter", ".name", function(){
		$(this).css({ "cursor":"pointer", "text-decoration":"underline" });
	}).on("mouseleave", ".name", function(){
		$(this).css("text-decoration", "none");
	});
	
	$("#hot").on("click", ".img, .name", function(){
		make_dialog($(this).parents("li"));
	});
	// ---------------------------------------------------------------------------------------------------------------
	
	
	//																		 ◆ viewMore ◆ 
	// ---------------------------------------------------------------------------------------------------------------	
	$("#viewMore").hover(function(){
		$("#viewMore").css({
			"cursor":"pointer",
			"text-decoration":"underline"
		});
	}, function(){
		$("#viewMore").css("text-decoration", "none");
	});
	
	
	$("#viewMore").click(function(){
		var cur_itemBox = "#itemBox" + view_level;
		var next_itemBox = "#itemBox" + (view_level + 1);
		
		$(cur_itemBox).show();
		
		if($(next_itemBox).attr("id") == undefined){
			$("#viewMore").hide();
		}
		
		view_level++;
	});
	// ---------------------------------------------------------------------------------------------------------------
	
	
	//																		 ◆ type2 ◆
	// ---------------------------------------------------------------------------------------------------------------
	$(document).on("mouseenter", ".type2", function(){
		$(this).css("cursor", "pointer");
	});
	// ---------------------------------------------------------------------------------------------------------------
	
	
	//																		 ◆ search ◆
	// ---------------------------------------------------------------------------------------------------------------
	// 'type2 메뉴 클릭' 및 '검색 시'
	$(document).on("click", ".type2, #mj_btn_area > img", function(){
		if($(this).attr("class") == "type2"){ // class 속성값이 type2이면 type2 메뉴 중 하나를 클릭한 것이니 클릭된 메뉴의 css를 처리
			$(".type2").not(this).removeClass("selected");
			$(".type2").not(this).css("border", "1px solid #999999");
			
			$(this).addClass("selected");
			$(this).css("border", "2px solid black");
		}
		
		var url = "../item/ajax/getItemList.jsp";
		var type1 = $("#wrapper").attr("type1");
		var keyword = $("#mj_input02 #search_text").val();
		var type2 = $("#type2 li[class='type2 selected'] > a").text();
		var lowest_price = $("#mj_input01 input[name='lowest_price']").val();
		var highest_price = $("#mj_input01 input[name='highest_price']").val();
		
		if(type2 == "전체"){ type2 = "%"; }
		if(lowest_price == ""){ lowest_price = 0; }
		if(highest_price == ""){ highest_price = 999999999; }
		
		var param = { "type1":type1, "keyword":keyword, "type2":type2, "lowest_price":lowest_price, "highest_price":highest_price };
		
		content_revalidate(url, param);
		
		return false;
	});
	
	
	// 라디오 버튼 이벤트 처리
	$(document).on("change", "input[name='price_range']", function(){
		var price_range = $(this).attr("id");
		
		if(price_range == "price_range01"){
			$("input[name='lowest_price']").val(0);
			$("input[name='highest_price']").val(1500);
		}else if(price_range == "price_range02"){
			$("input[name='lowest_price']").val(1500);
			$("input[name='highest_price']").val(3000);
		}else if(price_range == "price_range03"){
			$("input[name='lowest_price']").val(3000);
			$("input[name='highest_price']").val("");
		}
	});
	
	// searchBtn 이벤트
	$(document).on("mousedown", "#mj_btn_area > img", function(){
		$(this).attr("src", "../img/searchBtn_down.png");
	}).on("mouseup", "#mj_btn_area > img", function(){
		$(this).attr("src", "../img/searchBtn_up.png");
	}).on("mouseenter", "#mj_btn_area > img", function(){
		$(this).css("cursor", "pointer");
	}).on("mouseleave", "#mj_btn_area > img", function(){
		$(this).attr("src", "../img/searchBtn_up.png");
	});
	// ---------------------------------------------------------------------------------------------------------------	
	

	//																		 ◆ moving_banner ◆
	// ---------------------------------------------------------------------------------------------------------------
	var navigator_top = $("#hot").offset().top; // http://cofs.tistory.com/197 참고
	$("#moving_banner").css("top", navigator_top);
	
	$(window).scroll(function( ){  // scroll 이벤트
		var position = $(document).scrollTop() + 150; // scrollTop : scroll 상단 위치
		$("#moving_banner").animate({ top:position + "px" }, 30);
	});
	// ---------------------------------------------------------------------------------------------------------------
	
	
	//																		 ◆ fixed_bar ◆
	// ---------------------------------------------------------------------------------------------------------------
	$("#fixed_bar").hover(function(){
		$("#fixed_bar").css("cursor", "pointer")
	});
	
	$("#fixed_bar").click(function(){
		window.scrollTo(0, 0);
	});
	// ---------------------------------------------------------------------------------------------------------------
});