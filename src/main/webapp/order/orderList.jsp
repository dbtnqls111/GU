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
			$("#orderTbody").append($('<tr><td class="td_border" id="${orderDTO.seq}">' + "${orderDTO.itemCode}" + '</td>'
					+ '<td class="td_border">' + "${orderDTO.name}" + '</td>'
					+ '<td class="td_border" id="price_'+i+'" align="right">' + "${orderDTO.uup}" + '</td>'
					+ '<td class="td_border" id="table_center">'				
					+ '<table id="countTable"><tr><td id="countTd"><input type="text" class="countText" id="countText_' + i + '" onkeydown="javascript:onlyNumber(this)" value="${orderDTO.quantity}"></td>'
					+ '<td id="countButton">'
					+ '<div class="buttonImg"><img src="${pageContext.request.contextPath}/img/upButton.png" class="countButton" id="up_"'+i+' onclick="javascript:up('+i+')"></div>'
					+ '<div class="buttonImg"><img src="${pageContext.request.contextPath}/img/downButton.png" class="countButton" id="down_"'+i+' onclick="javascript:down('+i+')"></div>'
					+ '</td></tr></table>'
					+ '</td>'
					+ '<td class="td_border" id="allPrice_'+i+'" align="right">' + "${orderDTO.uup * orderDTO.quantity}" + '</td>'
					+ '<td align="center"><input type="checkbox" id="check_${orderDTO.seq}"></td></tr>'
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
		
		$("#deleteOrder").click(function(){
			if (confirm("선택하신 상품을 삭제하시겠습니까?") == true){
				for(var i=$('input:checkbox').length-1; i>=0; i--){
				 	if($('input:checkbox:eq('+i+')').prop("checked")){	 		
				 		var seq = $('input:checkbox:eq('+i+')').attr('id').split("_")[1];
				 		$.ajax({
				 	        url:"deleteOrder.do",
				 	        type:"post",
				 	        data:{"seq":seq},
				 	        dataType:"json",
				 	        success:function(data){
				 	          	alert("정상적으로 상품이 삭제되었습니다.");
				 	        },
				 	        error:function(jqXHR, textStatus, errorThrown){
				 	        	alert("상품 삭제 실패");
				 	        }
				 	    });
				 		var all =  parseInt($("#allPrice").text());
				 		all = all - parseInt($("#orderTable > tbody > tr:eq("+(i-1)+") > td:eq(4)").text());
				 		$("#allPrice").html(all+"원");
				 		$('#orderTable > tbody > tr:eq('+(i-1)+')').remove();				 			 		
					}
				 }
			}else{ 
			    return;
			}		 
		});
		
		$("#orderButton").click(function(){
			  var orderArray = new Array(); // 배열 생성
	         
	          var totalOrderList = new Object(); // 배열을 담을 객체
	          var stringJsonOrder;  // 스트링형태로 바꾼 배열 저장
	          for(var i=1; i<$('input:checkbox').length; i++){				
				 	if($('input:checkbox:eq('+i+')').prop("checked")){
				 		var orderObj = new Object(); // 객체 생성
				 		orderObj.seq=$("#orderTable > tbody > tr:eq("+(i-1)+") > td:eq(0)").attr("id");
				 		orderObj.itemCode=$("#orderTable > tbody > tr:eq("+(i-1)+") > td:eq(0)").text();
				 		orderObj.name=$("#orderTable > tbody > tr:eq("+(i-1)+") > td:eq(1)").text();
				 		orderObj.uup=$("#orderTable > tbody > tr:eq("+(i-1)+") > td:eq(2)").text();
				 		orderObj.quantity=$(".countText:eq("+(i-1)+")").val();
				 		orderObj.price=$("#orderTable > tbody > tr:eq("+(i-1)+") > td:eq(4)").text();
				 		
				 		orderArray.push(orderObj);
				 	}
	          }
	          
	          totalOrderList.order = orderArray ;
	          stringJsonOrder = JSON.stringify(totalOrderList);
	          
	          var form = document.createElement('form');
	          
	          var objs = document.createElement('input');
	          objs.setAttribute('type', 'hidden');
	          objs.setAttribute('name', 'orderList');
	          objs.setAttribute('value', stringJsonOrder);
	          form.appendChild(objs);
	          
	          form.setAttribute('method', 'post');
	          form.setAttribute('action', 'order.do');
	          document.body.appendChild(form);
	          form.submit();
	          
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
		<div id="top_head"><div id="home">GU</div></div>
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
			
			<tfoot>
				<tr id="deleteOrderTr">
					<td colspan="6" id="deleteOrderTd"><input type="button" value="삭제" id="deleteOrder"></td>
				</tr>
			</tfoot>
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