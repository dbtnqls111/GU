<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/template/header.jsp"%>
<!DOCTYPE html>

<html>
<head>
	<title></title>
	<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
	<!-- <script type="text/javascript" src="/GU/js/jquery-ui.js"></script> -->
	<!-- <link rel="stylesheet" href="/GU/css/searchedResult/jquery-ui.css" /> --> <!-- jquery-ui.css : jquery-ui.theme.css + jquery-ui.structure.css -->
	<!-- <link rel="stylesheet" href="/GU/css/searchedResult/jquery-ui.theme.css" /> -->
	<!-- <link rel="stylesheet" href="/GU/css/searchedResult/jquery-ui.structure.css" /> -->
    
    <script type="text/javascript" src="/GU/script/searchedResult.js"></script>
	<link rel="stylesheet" href="/GU/css/searchedResult/searchedResult.css">
	<style type="text/css">
		#wrapper *{ box-sizing:border-box; }
	
		#wrapper ul{ padding:0px; text-align:center; list-style:none; }
		
		#wrapper li{
			background:#3baae3 url(/GU/img/ui-bg_glass_50_3baae3_1x400.png) 50% 50% repeat-x;
			border:1px solid #2694e8;
			line-height:40px;
			cursor:pointer;
			font-size:100%; font-weight:bold;
			color:#ffffff;
		}
		
		.type1{ width:130px; float:left; margin-right:20px; }
		.type2 > li{ width:100%; float:left; }
	</style>
</head>
<body>
	<div id="wrapper">		
		<div id="show_keyword">'${ keyword }' 검색 결과</div>
		
		<div id="not_searchedResult" hidden="hidden">
			<div><img src="../img/not_searchedResult.png"></div>
			<div><span style="font-size:40px; font-weight:bold; color:#616161;">검색 결과가 존재하지 않습니다.</span></div>
		</div>
		
		<!-- -------------------------------------------------------------------------------------------------------- -->
		
		<ul class="menu">
			<li class="type1">간편식사
				<ul class="type2">
					<li>도시락</li>
					<li>샌드위치/햄버거</li>
					<li>주먹밥/김밥</li>
				</ul>
			</li>
			
			<li class="type1">즉석조리
				<ul class="type2">
					<li>튀김</li>
					<li>베이커리</li>
					<li>즉석커피</li>
				</ul>
			</li>
			
			<li class="type1">과자류
				<ul class="type2">
					<li>스낵</li>
					<li>빵</li>
					<li>껌/캔디</li>
				</ul>
			</li>
			
			<li class="type1">아이스크림
				<ul class="type2">
					<li>아이스크림</li>
				</ul>
			</li>
			
			<li class="type1">식품
				<ul class="type2">
					<li>가공식사</li>
					<li>안주</li>
					<li>식재료</li>
				</ul>
			</li>
			
			<li class="type1">음료
				<ul class="type2">
					<li>일반음료</li>
					<li>아이스드링크</li>
					<li>유제품</li>
				</ul>
			</li>
			
			<li class="type1">생활용품
				<ul class="type2">
					<li>취미/레저</li>
					<li>의약외품</li>
					<li>잡화</li>
				</ul>
			</li>
		</ul>
		
		<!-- -------------------------------------------------------------------------------------------------------- -->
	</div>
		<jsp:include page="../template/footer.jsp" />
</body>
</html>