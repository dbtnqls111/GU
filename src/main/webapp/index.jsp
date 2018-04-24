<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/template/header.jsp"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>GU</title>

<script type="text/javascript" src="/GU/js/jquery-3.3.1.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>

<script type="text/javascript" src="script/indexScript.js"></script>

<script type="text/javascript">
	function encode(type1, type2) {
		location.href = "item/list.do?type1=" + encodeURI(type1, "UTF-8") + "&type2=" + encodeURI(type2, "UTF-8");
	}

	$(document).ready(function(){
		// ----------------------------------- buttonMenu -----------------------------------
		$.ajaxSetup({
			cache : false
		});
		
		// Best 상품 리스트 불러오기
		$.get("item/ajax/getBestItemList.jsp", function(data){
			$(data).find("item").each(function(){
				var code = $(this).find("code").text();
				
				var img_name = $(this).find("name").text();
				var item_name = img_name;
				if(img_name.length > 14){ item_name = img_name.substring(0, 14) + "..."; }
				
				var price = $(this).find("price").text();

				$("#bestItem" + $(this).index()).append("<p id='img'><img src='img/item/" + code + ".PNG' width='100%' height='230px'></p>" +
																	  "<p id='name'><span realName='" + img_name + "'>" + item_name + "</span></p>" +
																	  "<p id='price'><span>" + price + "</span>원</p>");
			});
		});

		// 메뉴 이벤트
		$(".buttonMenu").mouseenter(function(){
			$("#boxDiv").hide();
			$("#boxDiv2").show();
			var id = "#type2_category" + $(this).index();

			$(this).css("background-color", "#2e4ea5");
			$("#boxDiv2").load("item/ajax/type2.html " + id, function(){
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
</script>

<link rel="stylesheet" type="text/css" href="css/index.css">

</head>

<body>
	<div id="wrap_index">
		<div id="bannerWrapper">
			<div id="buttonMenu">
				<div id="mealMenu" class="buttonMenu">
					<img alt="간편식사" src="img/meal.png" id="mealIcon">간편 식사
				</div>
				<div id="instantMenu" class="buttonMenu">
					<img alt="즉석조리" src="img/instant.png" id="instantIcon">즉석 조리
				</div>
				<div id="snackMenu" class="buttonMenu">
					<img alt="과자류" src="img/snack.png" id="snackIcon">과자류
				</div>
				<div id="iceMenu" class="buttonMenu">
					<img alt="아이스크림" src="img/icecream.png" id="iceIcon">아이스크림
				</div>
				<div id="foodMenu" class="buttonMenu">
					<img alt="식품" src="img/food.png" id="foodIcon">식품
				</div>
				<div id="drinkMenu" class="buttonMenu">
					<img alt="음료" src="img/drink.png" id="drinkIcon">음료
				</div>
				<div id="dailyMenu" class="buttonMenu">
					<img alt="생활용품" src="img/daily.png" id="dailyIcon">생활용퓸
				</div>
			</div>
			
			<div id="boxDiv">
				<div id="left">
					<img alt="leftButton" src="img/bannerLeftButton.png"
						id="leftButton">
				</div>

				<ul id="sliderUl">
					<li id="sliderImg1" class="slides"><a href="boardView.do?seq=24&pg=1"><img alt="봄맞이 도시락 대전" src="img/box1.png" id="1"></a></li>
					<li id="sliderImg2" class="slides"><a href="boardView.do?seq=25&pg=1"><img alt="맛있는 이벤트" src="img/box2.png" id="2"></a></li>
					<li id="sliderImg3" class="slides"><a href="boardView.do?seq=26&pg=1"><img alt="봄맞이 프로모션" src="img/box3.png" id="3"></a></li>
					<li id="sliderImg4" class="slides"><a href="boardView.do?seq=27&pg=1"><img alt="벨기에 맥주 프로모션" src="img/box4.png" id="4"></a></li>
				</ul>

				<div id="right">
					<img alt="rightButton" src="img/bannerRightButton.png"
						id="rightButton">
				</div>

				<div id="bannerNavi">
					<img alt="pause" src="img/pause.png" id="pauseIcon">
				</div>

			</div>
			
			<div id="boxDiv2" hidden="hidden"></div>
		</div>

		<div id="best">
			<div id="title">
				<div><img src="img/hot.gif" width="60px" height="60px"></div>
				<div id="title_text"><span>Best 상품</span></div>
			</div>
			<ul id="BestImg">
				<li id="bestItem0"></li>
				<li id="bestItem1"></li>
				<li id="bestItem2"></li>
				<li id="bestItem3"></li>
				<li id="bestItem4"></li>
				<li id="bestItem5"></li>
				<li id="bestItem6"></li>
				<li id="bestItem7"></li>
			</ul>
		</div>
	</div>
</body>

</html>
<%@ include file="/template/footer.jsp"%>