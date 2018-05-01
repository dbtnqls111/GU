<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>발주 현황</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderList.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	<c:forEach var="salesDTO" items="${currentList}">	
		$("#orderTbody").append($('<tr><td class="td_border">' + "${salesDTO.itemCode}" + '</td>'
				+ '<td class="td_border">' + "${salesDTO.name}" + '</td>'
				+ '<td class="td_border" align="right">' + "<fmt:formatNumber value='${salesDTO.uup}'/>" + '</td>'
				+ '<td class="td_border" id="table_center">'+"${salesDTO.quantity}"+'</td>'
				+ '<td class="td_border" id="price_all"  align="right">' + "<fmt:formatNumber value='${salesDTO.price}'/>" + '</td>'
				+ '</tr>'
		));
	</c:forEach>
	
	$("#orderCurrent").click(function(){
		location.href="orderCurrent.do";
	});
});
</script>

<style type="text/css">
#orderWrap{
	width:100%;
	min-width: 800px;	
	max-width: 800px;
	margin:auto;
	margin-top:30px;
	margin-bottom:30px;
}

#orderTable{
	width:100%;
	min-width:800px;
	max-width: 800px;
}

#price_all{
	border-right:none;
}

#orderCurrent{
	border:1px solid #7c7c7c;
	background-color:#ffffff;
	width:100px;
	height:30px;
	font-size:15px;
}


</style>
</head>
<body>
<div id="orderWrap">		
	<div id="orderBody">
		<div id="bodyFont">발주 현황 목록 - <span id="date">(${title})</span></div>
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
</div>
</body>
</html>