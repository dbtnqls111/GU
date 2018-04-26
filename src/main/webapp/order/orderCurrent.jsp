<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/template/header.jsp"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<title>풀캘린더</title>
<style type="text/css">
    body {
        margin :40px 10px;
        padding : 0;
        font-family : "Lucida Grande", Helvetica, Arial, Verdana,sans-serif;
        font-size : 14px;
    }
    #calendar {
        max-width : 900px;
        margin : 0 auto;
    }
</style>
<link href="${pageContext.request.contextPath}/css/fullcalendar.min.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/fullcalendar.print.css" rel="stylesheet" media="print"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/moment.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/fullcalendar.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/locale-all.js"></script>

<script type="text/javascript">
    jQuery(document).ready(function() {
    	
    	jQuery("#calendar").fullCalendar({
    		locale:'ko',
    		buttonIcons: false
     	});
    });
</script>

<style type="text/css">

#cWrap{
	width:1050px;
	height:2000px;
	margin-left:252px;
}

#orderTitle{
	font-size:25px;
	font-weight: bold;
	margin-top:50px;
	margin-left:72px;;
}

#calendar{	
	margin:auto;
	margin-top:20px;
}

button{
	outline:none;
}
</style>
<body>
<div>
	<div id="cWrap">
		<div id="orderTitle">발주 현황</div>
   	 <div id="calendar"></div>
	</div>
</div>
</body>
</html>
