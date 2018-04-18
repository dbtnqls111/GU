<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#foldingLi").click(function(){
			$("#footer").css("display", "none");
			$("#unFolding").fadeIn();
		});
		
		$("#unFoldingLi").click(function(){
			$("#unFolding").css("display", "none");
			$("#footer").fadeIn();
		});		
		
		$("#topIcon").click(function() {
	        $('html, body').animate({
	          scrollTop : 0
	        }, 400);
	        return false;
	     });
		 
		$("#searchBarIcon").click(function(){
			$("#search").focus();
		});
	});
</script>

<link rel="stylesheet" type="text/css" href="/GU/css/footer.css">

<div id="footer">
	<fieldset id="footerField">
		<ul id="footerUl">
			<li id="foldingLi"><img alt="접기" src="${pageContext.request.contextPath}/img/folding.png" id="foldingIcon"></li>
			<li id="mainBar"><a href="${pageContext.request.contextPath}/index.jsp"><img alt="main" src="${pageContext.request.contextPath}/img/home.png" id="homeIcon"></a></li>
			<li><img alt="검색" src="${pageContext.request.contextPath}/img/searchBar.png" id="searchBarIcon"></li>
			<li><a href="#"><img alt="발주대기목록" src="${pageContext.request.contextPath}/img/orderBar.png" id="orderBarIcon"></a></li>
			<li id="topBar"><a href="#"><img alt="맨위로" src="${pageContext.request.contextPath}/img/top.png" id="topIcon"></a></li>
		</ul>
		
	</fieldset>	
</div>

<div id="unFolding">
	<fieldset id="unFoldingField">
		<ul id="unFoldingUl">
			<li id="unFoldingLi"><img alt="펴기" src="${pageContext.request.contextPath}/img/unfolding.png" id="unfoldingIcon"></li>
		</ul>
	</fieldset>
</div>