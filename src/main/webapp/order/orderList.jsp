<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>발주 대기 목록</title>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var i = 0;
		var count = 0;
		<c:forEach var="orderDTO" items="${orderList}">
			i= i + 1;
			$("#orderTbody").append($('<tr><td class="td_border">' + "${orderDTO.itemCode}" + '</td>'
					+ '<td class="td_border">' + "${orderDTO.itemName}" + '</td>'
					+ '<td class="td_border" id="price_'+i+'" align="right">' + "${orderDTO.price}" + '</td>'
					+ '<td class="td_border" id="table_center">'				
					+ '<table id="countTable"><tr><td id="countTd"><input type="text" class="countText" id="countText_' + i + '" onkeydown="javascript:onlyNumber(this)" value="${orderDTO.quantity}"></td>'
					+ '<td id="countButton">'
					+ '<div class="buttonImg"><img src="${pageContext.request.contextPath}/img/upButton.png" class="countButton" id="up_"'+i+' onclick="javascript:up('+i+')"></div>'
					+ '<div class="buttonImg"><img src="${pageContext.request.contextPath}/img/downButton.png" class="countButton" id="down_"'+i+' onclick="javascript:down('+i+')"></div>'
					+ '</td></tr></table>'
					+ '</td>'
					+ '<td class="td_border" id="allPrice_'+i+'" align="right">' + "${orderDTO.price * orderDTO.quantity}" + '</td>'
					+ '<td align="center"><input type="checkbox"></td></tr>'
				));
			count = count + parseInt($("#allPrice_"+i).text());
		</c:forEach>
		$("#allPrice").html(count+"원");
		
		$("#home").click(function() {
			location.href = "${pageContext.request.contextPath}/index.jsp";
		});

		$("#allSelect").click(function() {
			var check = $("#allSelect").prop("checked");
			$("input[type='checkbox']").prop("checked", check);
		});
		
		$("#orderButton").click(function(){
			var session = "${branchCode}";
			alert(session);
		});
	});
	
	function up(number){
		var all =  parseInt($("#allPrice").text());
		var count = parseInt($("#countText_"+number).val())+1;
		$("#countText_"+number).val(count);		
		var allprice = parseInt($("#price_"+number).text())*count;
		all = all - parseInt($("#allPrice_"+number).text()) + allprice;
		$("#allPrice_"+number).html(allprice);
		$("#allPrice").html(all+"원");
	}
	
	function down(number){
		var all =  parseInt($("#allPrice").text());		
		var count = parseInt($("#countText_"+number).val())-1;
		if(count<0){
			count=0;
		}
		$("#countText_"+number).val(count);
		var allprice = parseInt($("#price_"+number).text())*count;
		all = all - parseInt($("#allPrice_"+number).text()) + allprice;
		$("#allPrice_"+number).html(allprice);
		$("#allPrice").html(all+"원");
	}
	
	function onlyNumber(obj){
		$(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}
	
</script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderList.css">

</head>
<body>
<div id="orderWrap">
	<div id="top">
		<div id="top_head"><span id="home">GU</span></div>
		<div id="top_body"><img src="${pageContext.request.contextPath}/img/top_body.png" id="top_bodyImg"></div>
	</div>
	
	<div id="body">
		<div id="bodyFont">발주 목록</div>
		<table id="orderTable">
			<thead id="thead">
				<tr id="th_tr">
					<th class="thWidth_1">상품코드</th>
					<th class="thWidth_1">상품명</th>
					<th class="thWidth_2">상품금액</th>
					<th class="thWidth_3">수량</th>
					<th class="thWidth_2">주문금액</th>
					<th class="thWidth_4"><input type="checkbox" id="allSelect"></th>
				</tr>
				
			</thead>
			
			<tbody id="orderTbody">
			</tbody>
		</table>
	</div>
	
	<div id="bottom">
		<div id="orderPrice">
			<span id="allPriceText">선택된 상품 금액</span><span id="allPrice_colon">:</span>
			<span id="allPrice">0원</span>
		</div>
		<div id="orderButtonList">
			<input type="button" value="발주넣기" id="orderButton">
		</div>
	</div>
</div>
</body>
</html>