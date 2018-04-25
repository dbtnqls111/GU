var view_level; // 더 보기 level

function onlyNumber(event){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39){
		return;
	}else{
		return false;
	}
}

function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if(keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39){
		return;
	}else{
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
}

function content_revalidate(url, param){
	$("html").css("overflow", "hidden"); // 콘텐츠가 전부 채워질 때까지 페이지 스크롤을 못하게 금지(제거)
	
	$("#loader_background").fadeIn();
	$("#loader").fadeIn();
	
	$.get(url, param, function(data){
		$("#content > ul > *").remove();
		
		var itemBox_count = parseInt($(data).find("itemBox_count").text());

		for(var i = 0; i < itemBox_count; i++){
			$("#content > ul").append("<span id='itemBox" + i + "' class='itemBoxes'>");
			
			$(data).find("divide" + i + " > .item").each(function(){
				var code = $(this).find("code").text();
				
				var img_name = $(this).find("name").text();
				var item_name = img_name;
				if(img_name.length > 14){ item_name = img_name.substring(0, 14) + "..."; }
				
				var price = $(this).find("price").text();

				$("#itemBox" + i).append("<li code='" + code + "'>" +
														"<p id='img'><img src='../img/item/" + code + ".PNG' width='100%' height='230px'></p>" +
														"<p id='name'><span realName='" + img_name + "'>" + item_name + "</span></p>" +
														"<p id='price'><span>" + price + "</span>원</p>" +
												  "</li>");
			});
			
			$("#content > ul").append("</span>");
		}
		
		view_level = 1; // view_level 초기화
		
		// 첫 번째 덩어리만 출력
		$(".itemBoxes").not("#itemBox0").hide();

		// itemBox1이 존재한다는 것은 덩어리가 2개 이상이라는 의미이므로 '더 보기'를 출력
		if($("#itemBox1").attr("class") != undefined){
			$("#viewMore").show();
		}else{
			$("#viewMore").hide();
		}
		
		// mouseenter 이벤트 처리
		$(".itemBoxes > li").mouseenter(function(){
			$(this).css({ "border":"2px solid black", "cursor":"pointer" });
		}).mouseleave(function(){
			$(this).css("border", "1px solid #999999");
		});
		
		// 상세보기
		$("#content li").click(function(){
			// 다이얼로그 콘텐츠 구성
			var itemCode = $(this).attr("code");
			var itemName = $(this).find("#name > span").attr("realName");
			var itemPrice = $(this).find("#price > span").html();
			
			// 상품 설명 불러오기
			$("#d_itemDescription").load("../item/ajax/item_description.html #" + itemCode, function(){
				if($("#d_itemDescription").html() == ""){
					$("#d_itemDescription").html("설명 : ...");
				}
				
				$("#detail_left img").attr("src", "../img/item/" + itemCode + ".PNG");
				$("#d_itemName").html(itemName);
				$("#d_itemPrice").html("가격 : " + itemPrice);
				
				// 다이얼로그 구성
				/*
					만약 'is not a function' 오류가 발생한다면 jQuery 라이브러리가 중복 include되어 그런 것일 확률이 많으므로
					include하여 사용 중인 페이지(header, footer 등)들 중에서 jQuery 라이브러리를 include 중인지 확인해보길 바란다.
				*/
				$("#detail #btn > button").button();
				
				$("#dialog").dialog({
					open:function(){
						$(this).parents(".ui-dialog").attr("tabindex", -1)[0].focus(); // 다이얼로그 창이 열렸을 때 X 버튼에 포커싱이 되는 현상을 해결
						$(this).parents(".ui-dialog").find(".ui-dialog-title").css({ "width":"100%", "display":"block", "text-align":"center" }); // title 가운데 정렬
					},
					
					width:750,
					height:400,
					
	                modal:true,
	                resizable:false,
				});
			});
		});
	}).always(function(){
		$("#loader_background").fadeOut();
		$("#loader").fadeOut();
		
		$("html").css("overflow", "auto"); // 페이지 스크롤 원상복구
	});
}


$(function(){
	//																		 ◆ content ◆ 
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