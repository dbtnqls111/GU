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
    		 header:{
    			left:'',
    			center:'prev, title, next',
    			right:'today'
    		 },
    		 locale:'ko',
    		 buttonIcons: true,
    		 eventLimit: true,
    		 events: function(start, end, callback) {
    			 $.ajax({ 
    				 url: 'getsalesCurrentList.do',
    				 
    				 dataType: 'json', 
    				 success: function(data, text, request) { 
    					 var events = eval(data.jsonTxt); 
    					 callback(events); 
    				 }
    			 });
    		 },
    		 eventClick: function(calEvent, jsEvent, view) {   
    			 var moment = jQuery("#calendar").fullCalendar("getDate");
    			 var date = moment.format("YYYY/MM/DD");
    			 location.href="orderCurrentListView.do?date="+date;
    		}
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
	margin-top:50px;
	margin-left:72px;
}

#calendar{	
	margin:auto;
	margin-top:20px;
	color:#565656;
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
	
	<div id="mySchedule"></div>
</div>
</body>
</html>
