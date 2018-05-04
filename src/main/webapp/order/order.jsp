<%@page import="order.bean.OrderDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<title>발주</title>
<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	var i = 0;
	var count = 0;
	
	var orderArray = new Array(); // 배열 생성    
    var totalOrderList = new Object(); // 배열을 담을 객체
    var stringJsonOrder;  // 스트링형태로 바꾼 배열 저장
	
	<c:forEach var="orderDTO" items="${orderList}">
		i= i + 1;
		$("#orderTbody").append($('<tr><td class="td_border" id="${orderDTO.seq}">' + "${orderDTO.itemCode}" + '</td>'
				+ '<td class="td_border">' + "${orderDTO.name}" + '</td>'
				+ '<td class="td_border" align="right">' + comma("${orderDTO.uup}") + '</td>'
				+ '<td class="td_border" id="table_center">'+"${orderDTO.quantity}"+'</td>'
				+ '<td class="td_border" id="allPrice_'+i+'" align="right">' + comma("${orderDTO.uup * orderDTO.quantity}") + '</td>'
				+ '</tr>'
			));
		count = count + parseInt(uncomma($("#allPrice_"+i).text()));
		
		var orderObj = new Object(); // 객체 생성
		orderObj.seq=$("#orderTable > tbody > tr:eq("+(i-1)+") > td:eq(0)").attr("id");
 		orderObj.itemCode=$("#orderTable > tbody > tr:eq("+(i-1)+") > td:eq(0)").text();
 		orderObj.quantity=$("#orderTable > tbody > tr:eq("+(i-1)+") > td:eq(3)").text();
 		orderObj.price=uncomma($("#orderTable > tbody > tr:eq("+(i-1)+") > td:eq(4)").text());
 		orderObj.branchCode="${branchCode}";
 		orderArray.push(orderObj);
	</c:forEach>
	$("#allPrice").html(comma(count)+"원");
	
	totalOrderList.order = orderArray;
    stringJsonOrder = JSON.stringify(totalOrderList);
    
    $("#orderButton").click(function(){
    	var form = document.createElement('form');
        
        var objs = document.createElement('input');
        objs.setAttribute('type', 'hidden');
        objs.setAttribute('name', 'orderList');
        objs.setAttribute('value', stringJsonOrder);
        form.appendChild(objs);
        
        form.setAttribute('method', 'post');
        form.setAttribute('action', '/GU/ordering.do');
        document.body.appendChild(form);
        form.submit();
    });
    
    $("#home").click(function() {
		location.href = "${pageContext.request.contextPath}/index.jsp";
	});
});

//콤마찍기
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

//콤마풀기
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}
</script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderList.css">

<style type="text/css">
	#coment{
		text-align:center;
		margin-top:30px;
		font-size:18px;
	}
</style>

</head>

<body>

<div id="orderWrap">
	<div id="top">
		<div id="top_head"><span id="home">GU</span></div>
		<div id="top_body"><img src="${pageContext.request.contextPath}/img/top_body1.png" id="top_bodyImg"></div>
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
				</tr>
				
			</thead>
			
			<tbody id="orderTbody">
			</tbody>
		</table>
	</div>
	
	<div id="bottom">
		<div id="orderPrice">
			<span id="allPriceText">총 상품 금액</span><span id="allPrice_colon">:</span>
			<span id="allPrice">0원</span>
		</div>
		
		<div id="coment">발주 목록을 확인 후 발주신청을 눌러주세요</div>
		<div id="orderButtonList">
			<input type="button" value="발주신청" id="orderButton">
		</div>
	</div>
</div>
</body>

</html>