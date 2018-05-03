// 장바구니 버튼 이벤트 처리
function shoppingBasket_request(){
	var memId = $("#detail_dialog #hiddenInfo").attr("memId");
	
	if(memId == "null"){
		alert("로그인 후 이용해주세요.");
		location.replace("/GU/member/loginForm.do?");
	}else{
		var itemCode = $("#detail_dialog #hiddenInfo").attr("itemCode");
		var quantity = $("#detail_dialog #d_itemQuantity > input").val();
		if(quantity == ""){
			alert("수량을 입력해주세요.");
			$("#detail_dialog #d_itemQuantity > input").focus();
			return;
		}

		$("#basket_alert_dialog > .btn > button").button();
		
		$("#basket_alert_dialog").dialog({
			open:function(){
				$(this).parents(".ui-dialog").attr("tabindex", -1)[0].focus(); // 다이얼로그 창이 열렸을 때 X 버튼에 포커싱이 되는 현상을 해결
				$(this).parents(".ui-dialog").find(".ui-dialog-title").css({ "width":"100%", "display":"block", "text-align":"center" }); // title 가운데 정렬
				$(this).parents(".ui-dialog").css("z-index", "300");
			},
			
			width:440,
			height:190,
			
            modal:true,
            resizable:false,
            position:{ of:"#detail_dialog" }
		});
		
		// 버튼 이벤트 처리
		$("#basket_alert_dialog #moveBtn").off("click"); // 기존 이벤트 제거
		$("#detail_dialog, #basket_alert_dialog").off("click");
		
		$("#basket_alert_dialog #moveBtn").click(function(){
			location.replace("/GU/order/shoppingBasket.do?itemCode=" + itemCode + "&quantity=" + quantity + "&memId=" + memId);
		});
		
		$("#basket_alert_dialog #continueBtn").click(function(){
			var url = "/GU/item/ajax/shoppingBasket_request.jsp";
			var param = { "itemCode":itemCode, "quantity":quantity, "memId":memId };
			$.get(url, param);
			
			$("#detail_dialog, #basket_alert_dialog").dialog("close");
		});
	}
}


//발주 버튼 이벤트 처리
function order_request(){
	var memId = $("#detail_dialog #hiddenInfo").attr("memId");
	if(memId == "null"){
		alert("로그인 후 이용해주세요.");
		location.replace("/GU/member/loginForm.do");
	}else{
		var code = $("#detail_dialog #hiddenInfo").attr("itemCode");
		var name = $("#detail_dialog #d_itemName").text();
		var quantity = $("#detail_dialog #d_itemQuantity > input").val();
		var price = $("#detail_dialog #d_itemPrice > span").text();
		if(quantity == ""){
			alert("수량을 입력해주세요.");
			$("#detail_dialog #d_itemQuantity > input").focus();
			return;
		}
		
		location.replace("/GU/order/orderDecision.do?code=" + code + "&name=" + name + "&quantity=" + quantity + "&price=" + price);
	} 
}


// 상세보기창 콘텐츠 구성
function make_detail_dialog(target){
	$("#d_itemQuantity > input").val(""); // 수량 입력란 초기화
	
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
		$("#detail > .btn > button").button();
		
		$("#detail_dialog").dialog({
			open:function(){
				$(this).parents(".ui-dialog").attr("tabindex", -1)[0].focus(); // 다이얼로그 창이 열렸을 때 X 버튼에 포커싱이 되는 현상을 해결
				$(this).parents(".ui-dialog").find(".ui-dialog-title").css({ "width":"100%", "display":"block", "text-align":"center" }); // title 가운데 정렬
				$(this).parents(".ui-dialog").css("z-index", "300");
			},
			
			width:750,
			height:400,
			
            modal:true,
            resizable:false,
		});
		
		// 버튼 이벤트 처리
		$("#detail_dialog #basket").off("click"); // 기존 이벤트 제거
		$("#detail_dialog #order").off("click");
		
		$("#detail_dialog #basket").click(function(){
			shoppingBasket_request();
		});
		
		$("#detail_dialog #order").click(function(){
			order_request();
		});
	});
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
			
			$("#content > ul").append("</span>");
		}
		
		view_level = 1; // view_level 초기화
		
		// 첫 번째 itemBox만 출력
		$(".itemBoxes").not("#itemBox0").hide();

		// itemBox1이 존재한다는 것은 itemBox가 2개 이상이라는 의미이므로 viewMore를 출력
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
			make_detail_dialog($(this));
		});
	}).always(function(){
		$("#loader_background").fadeOut();
		$("#loader").fadeOut();
		
		$("html").css("overflow", "auto"); // 페이지 스크롤 원상복구
	});
}