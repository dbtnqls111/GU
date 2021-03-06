<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/template/header.jsp"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>GU</title>


<script type="text/javascript" src="script/list_function.js"></script>
<script type="text/javascript" src="script/indexScript.js"></script>

<script type="text/javascript" src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css">

<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" type="text/css" href="css/index_and_list_public.css">

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
			
			<div id="boxDiv2" hidden="hidden">
				<div id="box2_left"></div>
				<div id="box2_right"><img src="" width="100%" height="100%"></div>
			</div>
		</div>

		<div id="best">
			<div id="title">
				<div><img src="img/hot.gif" width="70px" height="70px"></div>
				<div id="title_text"><span>Best 상품!</span></div>
			</div>
			<ul id="bestItem">
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

	
	<!-- 상세보기 창 -->
	<div id="detail_dialog" title="상세보기" style="display:none;">
		<div id="detail">
			<div id="detail_left">
				<img src="" width="100%" height="100%">
			</div>
			<div id="detail_right">
				<h2 id="d_itemName"></h2>
				<div id="d_itemPrice">
					<strong>가격</strong> : <span style="font-family:-webkit-body;"></span>
				</div><br>
				<div id="d_itemDescription">
					<strong>설명</strong> : <span style="font-family:-webkit-body;"></span>
				</div><br>
				<div id="d_itemQuantity">
					<strong>수량</strong> :
					<input type="text" size="3" maxlength="3" onpaste="javascript:return false" onfocusout="removeChar(event)"
							  onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" style="ime-mode:disabled">
				</div><br>
			</div>
			<div class="btn">
				<button id="basket">장바구니</button> &nbsp;
				<button id="order">발주</button>
				<span id="hiddenInfo" memId=<%= session.getAttribute("memId") %>></span>
			</div>
		</div>
	</div>
	
	
	<!-- 장바구니 알림창 -->
	<div id="basket_alert_dialog" title="장바구니" style="display:none;">
		<div class="text">
			<span>
				해당 상품이 정상적으로 장바구니에 담겼습니다.<br>
				장바구니로 이동하시겠습니까?
			</span>
		</div>
		
		<div class="btn">
			<button id="moveBtn">장바구니 이동</button> &nbsp;
			<button id="continueBtn">쇼핑 계속</button>
		</div>
	</div>
</body>

</html>
<%@ include file="/template/footer.jsp"%>