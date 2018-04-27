// 다이얼로그 콘텐츠 구성
function make_dialog(target){
	var itemCode = $(target).attr("code");
	var itemName = $(target).find(".name > span").attr("realName");
	var itemPrice = $(target).find(".price > span").html();
	
	// 상품 설명 불러오기
	$("#d_itemDescription > span").load("/GU/item/ajax/item_description.html #" + itemCode, function(){
		if($("#d_itemDescription > span").html() == ""){
			$("#d_itemDescription > span").html("...");
		}
		
		$("#detail_left img").attr("src", "/GU/img/item/" + itemCode + ".PNG");
		$("#d_itemName").html(itemName);
		$("#d_itemPrice > span").html(itemPrice);
		$("#hiddenInfo").attr("itemCode", itemCode);
		
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
}

// 장바구니 버튼 이벤트 처리
function shoppingBasket_request(){
	var memId = $("#dialog #hiddenInfo").attr("memId");
	
	if(memId == "null"){
		alert("로그인 후 이용해주세요.");
		location.replace("/GU/member/loginForm.do");
	}else{
		var itemCode = $("#dialog #hiddenInfo").attr("itemCode");
		var quantity = $("#dialog #d_itemQuantity > input").val();
		if(quantity == ""){
			alert("수량을 입력해주세요.");
			$("#dialog #d_itemQuantity > input").focus();
			return;
		}
			
		location.replace("/GU/order/shoppingBasket.do?itemCode=" + itemCode + "&quantity=" + quantity + "&memId=" + memId);
	}
}

//발주 버튼 이벤트 처리
function order_request(){
	var memId = $("#dialog #hiddenInfo").attr("memId");
	if(memId == "null"){
		alert("로그인 후 이용해주세요.");
		location.replace("/GU/member/loginForm.do");
	}else{
		var code = $("#dialog #hiddenInfo").attr("itemCode");
		var name = $("#dialog #d_itemName").text();
		var quantity = $("#dialog #d_itemQuantity > input").val();
		var price = $("#dialog #d_itemPrice > span").text();
		if(quantity == ""){
			alert("수량을 입력해주세요.");
			$("#dialog #d_itemQuantity > input").focus();
			return;
		}
		
		location.replace("/GU/order/orderDecision.do?code=" + code + "&name=" + name + "&quantity=" + quantity + "&price=" + price);
	} 
}


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
														"<p class='img'><img src='/GU/img/item/" + code + ".PNG' width='100%' height='230px'></p>" +
														"<p class='name'><span realName='" + img_name + "'>" + item_name + "</span></p>" +
														"<p class='price'><span>" + price + "</span>원</p>" +
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
			make_dialog($(this));
		});
	}).always(function(){
		$("#loader_background").fadeOut();
		$("#loader").fadeOut();
		
		$("html").css("overflow", "auto"); // 페이지 스크롤 원상복구
	});
}