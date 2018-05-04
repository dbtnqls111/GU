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



// =================================================== 김민진 ===================================================
function encode(type1, type2_num){
	location.href = "item/list.do?type1=" + encodeURIComponent(type1) + "&type2=" + type2_num;
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
		$(this).css({ "border":"solid 2px #757575", "cursor":"pointer" });
	}).mouseleave(function(){
		$(this).css("border", "1px solid #999999");
	});
	
	
	$(function(){
		// 상세보기
		$("#bestItem > li").click(function(){
			make_detail_dialog($(this));
		});
	});
	
	
	// 메뉴 이벤트
	$(".buttonMenu").mouseenter(function(){
		$("#boxDiv").hide();
		$("#boxDiv2").show();
		var id = "#category" + $(this).index();

		$(this).css("background-color", "#2e4ea5");
		$("#boxDiv2 #box2_left").load("/GU/item/ajax/type2.html " + id, function(){
			var type1 = $(id).attr("type1");
			
			$(id).find(".type2").each(function(){
				var type2 = $(this).attr("type2");
				$(this).css({
							  "background":"url(/GU/img/category/" + type2 + ".png)",
							  "background-repeat":"no-repeat",
							  "background-size":"100% 80%",
							  "opacity":"0.6",
							  "line-height":"590px",
							  "font-weight":"bold"
						  });
				
				
				$(this).click(function(){
					encode(type1, $(this).index());
				});
			});
			
			$("#boxDiv2 #box2_right > img").attr("src", "/GU/img/category/" + type1 + ".png");
			
			
			// typ2_area의 type2들 마우스 이벤트
			$(id).find(".type2").mouseenter(function(){
				$(this).css("opacity", "1");
			}).mouseleave(function(){
				$(this).css("opacity", "0.6");
			});
		});
	}).mouseleave(function(){
		$(this).css("background-color", "#013282");
	});
	
	
	// 범위 벗어나면 다시 광고가 나오도록 처리
	$("#bannerWrapper").mouseleave(function(){
		$("#boxDiv2").hide();
		$("#boxDiv").show();
	});
	
	
	// "Best 상품!" 반짝임 효과
	var flag = 0;
	window.setInterval(function(){
		if(flag == 0){
			$("#title_text > span").css("color", "black");
			flag = 1;
		}else if(flag == 1){
			$("#title_text > span").css("color", "red");
			flag = 0;
		}
	}, 250);
});