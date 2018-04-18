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