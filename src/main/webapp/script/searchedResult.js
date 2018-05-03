$(function(){
	$(".type2").hide();
	
	
	$(".type1").mouseenter(function(){
		if($(this).find("span").hasClass("disabled")){ return false; }
		
		$(this).find("span").css("background", "#1976D2");
		$(this).find(".type2").stop().slideDown(300);
	}).mouseleave(function(){
		if($(this).find("span").hasClass("disabled")){ return false; }
		
		$(this).find("span").css("background", "#3baae3 url(/GU/css/searchedResult/images/ui-bg_glass_50_3baae3_1x400.png) 50% 50% repeat-x");
		$(this).find(".type2").stop().slideUp(300);
	});
	
	
	$(".type2 > li").mouseenter(function(){
		$(this).css("background", "#1976D2");
	}).mouseleave(function(){
		$(this).css("background", "#3baae3 url(/GU/css/searchedResult/images/ui-bg_glass_50_3baae3_1x400.png) 50% 50% repeat-x");
	});
});


$(function(){
	$(document).on("mouseenter", ".itemBoxes > li", function(){
		$(this).css({ "border":"2px solid black", "cursor":"pointer" });
	}).on("mouseleave", ".itemBoxes > li", function(){
		$(this).css("border", "1px solid #999999");
	});
	
	$(document).on("click", ".itemBoxes > li", function(){
		make_detail_dialog($(this));
	});
});