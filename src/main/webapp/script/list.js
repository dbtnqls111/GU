﻿$.getScript("http://code.jquery.com/ui/1.10.2/jquery-ui.js"); // jQuery UI JavaScript file load

function content_revalidate(url, param){
	$.get(url, param, function(data){
		$("#loader_background").fadeIn();
		$("#loader").fadeIn();
		
		$("#content > ul > *").remove();
		
		var itemBox_count = parseInt($(data).find("itemBox_count").text());

		for(var i = 0; i < itemBox_count; i++){
			$("#content > ul").append("<span id='itemBox" + i +"' class='itemBoxes'>");
			
			$(data).find("divide" + i + " > .item").each(function(){
				var img_name = $(this).find("name").text();
				var item_name = img_name;
				if(img_name.length > 17){ item_name = img_name.substring(0, 17) + "..."; }
				
				var price = $(this).find("price").text();

				$("#itemBox" + i).append("<li>" +
														"<p id='img'><img src='../img/" + img_name + ".jpg' width='100%'></p>" +
														"<p id='name'><span>" + item_name + "</span></p>" +
														"<p id='price'><span>" + price + "</span>원</p>" +
												  "</li>");
			});
			
			$("#content > ul").append("</span>");
		}
		
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
		$("#content img").click(function(){
			$("#detail #btn > button").button();
			
			$("#dialog").dialog({
				open:function(){
					$(this).parents(".ui-dialog").attr("tabindex", -1)[0].focus(); // 다이얼로그 창이 열렸을 때 X 버튼에 포커싱이 되는 현상을 해결; // 다이얼로그 창이 열렸을 때 X 버튼에 포커싱이 되는 현상을 해결
					$(this).parents(".ui-dialog").find(".ui-dialog-title").css({ "width":"100%", "display":"block", "text-align":"center" }); // title 가운데 정렬
				},
				
				width:800,
				height:500,
                modal:true,
                resizable:false,
			});
		});
	}).always(function(){
		$("#loader_background").fadeOut();
		$("#loader").fadeOut();
	});
}


$(function(){
	//																		 ◆ content ◆ 
	// ---------------------------------------------------------------------------------------------------------------
	// type2 메뉴 클릭 시
	$(document).on("click", ".type2", function(){
		var url = "../item/ajax/getItemList.jsp";
		var type2 = $(this).find("a").html();
		var param = { "url":url, "type2":type2 };
		
		content_revalidate(url, param);
		
		
		$(".type2").not(this).removeClass("selected");
		$(".type2").not(this).css("background", "none");
		
		$(this).addClass("selected");
		$(this).css("background", "black");
		
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
	
	
	var view_level = 1;
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
	// 검색
	$(document).on("change", "#mj_input01 input[name='price_range']", function(){
		var price_range = $(this).attr("id");
		
		if(price_range == "price_range01"){
			$("#mj_input01 input[name='lowest']").val(0);
			$("#mj_input01 input[name='highest']").val(1500);
		}else if(price_range == "price_range02"){
			$("#mj_input01 input[name='lowest']").val(1500);
			$("#mj_input01 input[name='highest']").val(3000);
		}else if(price_range == "price_range03"){
			$("#mj_input01 input[name='lowest']").val(5000);
			$("#mj_input01 input[name='highest']").val("");
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
	var navigator_top = $("#navigator").offset().top; // http://cofs.tistory.com/197 참고
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