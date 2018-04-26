var index = 0;	

function banner(){
	var listCount = $("#boxDiv > ul > li").length;
	var indexCount = index % listCount;
	$("#boxDiv > ul > li").eq(indexCount - 1).css("display", "none");
	$("#boxDiv > ul > li").eq(indexCount).css("display", "block");
	$(".pageButton").eq(indexCount-1).attr("src", "img/bannerPageNaviIcon.png");
	$(".pageButton").eq(indexCount).attr("src", "img/bannerPageNavi1.png");
	index++;
}

function pageNavi(){
	var listCount = $("#boxDiv > ul > li").length;
	
	if(listCount <= 1){
		$("#rightButton").css("display", "none");
		$("#leftButton").css("display", "none");
		$("#pauseIcon").css("display", "none");
	}
	
	for(var i = 0; i<listCount-1; i++){
		if(i==0){
			$("#bannerNavi > #pauseIcon").before("<img art='bannerPage' src='img/bannerPageNavi1.png' id='img_"+i+"' class='pageButton'>");
		}
		$("#bannerNavi > #pauseIcon").before("<img art='bannerPage' src='img/bannerPageNaviIcon.png' id='img_"+i+"' class='pageButton'>");
	}
}

function leftButton(){
	index--;
	
	if(index<0){
		index = index + 5;
	}
	
	var listCount = $("#boxDiv > ul > li").length;
	var indexCount = index % listCount;
	
	$("#boxDiv > ul > li").eq(indexCount).css("display", "none");
	$("#boxDiv > ul > li").eq(indexCount-1).css("display", "block");
	$(".pageButton").eq(indexCount).attr("src", "img/bannerPageNaviIcon.png");
	$(".pageButton").eq(indexCount-1).attr("src", "img/bannerPageNavi1.png");
}

$(document).ready(function() {			
	$("#boxDiv > ul > li").eq(0).css("display", "block");
	
	var i = 0;
	var interval = setInterval(banner, 3000);

	pageNavi();
	
	$("#pauseIcon").click(function(){
		var src = $(this).attr("src");
		
		if(src=="img/pause.png"){
			$("#pauseIcon").attr("src", "img/play.png");
			clearInterval(interval);				
		}else{
			$("#pauseIcon").attr("src", "img/pause.png");
			interval = setInterval(banner, 3000);
		}
	});
	
	var BestCount = $("#BestImg > li").length;
	
	for(i=1; i<=BestCount; i++){
		if(i%4==0){
			 $("#BestImg > li").eq(i-1).after("<br>");
		}
	}
	
	$("#rightButton").click(function(){
		banner();
	});
			
	$("#leftButton").click(function(){
		leftButton();
	});
});



// ====================================== 김민진 ======================================
function encode(type1, type2_num){
	location.href = "item/list.do?type1=" + encodeURI(type1, "UTF-8") + "&type2=" + type2_num;
}

$(function(){
	$.ajaxSetup({
		cache:false
	});
	
	// Best 상품 리스트 불러오기
	$.get("/GU/item/ajax/getBestItemList.jsp", function(data){
		$(data).find("item").each(function(){
			var code = $(this).find("code").text();
			
			var img_name = $(this).find("name").text();
			var item_name = img_name;
			if(img_name.length > 14){ item_name = img_name.substring(0, 14) + "..."; }
			
			var price = $(this).find("price").text();

			$("#bestItem" + $(this).index()).attr("code", code);
			$("#bestItem" + $(this).index()).append("<p class='img'><img src='/GU/img/item/" + code + ".PNG' width='100%' height='230px'></p>" +
																   "<p class='name'><span realName='" + img_name + "'>" + item_name + "</span></p>" +
																   "<p class='price'><span>" + price + "</span>원</p>");
		});
	});
	
	
	// mouseenter 이벤트 처리
	$("#bestItem > li").mouseenter(function(){
		$(this).css("cursor", "pointer");
		$(this).css({ "border":"2px solid black", "cursor":"pointer" });
	}).mouseleave(function(){
		$(this).css("border", "1px solid #999999");
	});
	
	
	// 상세보기
	$("#bestItem > li").click(function(){
		make_dialog($(this));
	});

	
	// 메뉴 이벤트
	$(".buttonMenu").mouseenter(function(){
		$("#boxDiv").hide();
		$("#boxDiv2").show();
		var id = "#type2_category" + $(this).index();

		$(this).css("background-color", "#2e4ea5");
		$("#boxDiv2").load("/GU/item/ajax/type2.html " + id, function(){
			$(id).css("color", "red");
		});
	}).mouseleave(function(){
		$(this).css("background-color", "#013282");
	});
	
	$("#bannerWrapper").mouseleave(function(){
		$("#boxDiv2").hide();
		$("#boxDiv").show();
	})
});