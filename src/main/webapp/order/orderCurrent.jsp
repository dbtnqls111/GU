<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/template/header.jsp"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<title>풀캘린더</title>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>

<link href='http://fullcalendar.io/js/fullcalendar-2.7.3/fullcalendar.css' rel='stylesheet' />
<link href='http://fullcalendar.io/js/fullcalendar-2.7.3/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='//cdnjs.cloudflare.com/ajax/libs/moment.js/2.13.0/moment.min.js'></script>
<script src='//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://fullcalendar.io/js/fullcalendar-2.7.3/fullcalendar.js'></script>
<script src='http://fullcalendar.io/js/fullcalendar-2.7.3/lang/ko.js'></script>

<script type="text/javascript">
$(document).ready(function() {
	$.ajax({
		url : 'getsalesCurrentList.do',
		data : {
			'branchCode' : "${branchCode}"
		},
		dataType : 'json',
		success : function(data, text, request) {
			setCalendar(data.events);
			displayLoading(false);
		},
		error : function() {
		}
	});
	
	
});

function setCalendar(data) {
	LeftPosition=(screen.width-900)/2;
	TopPosition=(screen.height-500)/2;
	
	
	$("#calendar").fullCalendar({     
		header : {
			left : '',
			center : 'prev, title, next myCustomButton',
			right : 'today'
		},
		buttonIcons: {
		    prev: 'left-single-arrow',
		    next: 'right-single-arrow'
		},
		theme:false,
		locale : 'ko',
		eventLimit : true,
		events : eval(data),
		eventClick : function(calEvent, jsEvent, view) {
			var title = calEvent.title;
			window.open("getsalesCurrentListView.do?title="+title+"&branchCode=${branchCode}", "", "top="+TopPosition+", left="+LeftPosition+", width=900, height=500, scrollbars=yes, directories=no, location=no, menubar=no, resizable=no, status=no, toolbar=no");
			return false;
		}
	});
	
	
}


</script>

<style type="text/css">
body {
	margin: 40px 10px;
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 14px;
}

#calendar {
	max-width: 900px;
	margin: 0 auto;	
	margin-top: 20px;
	color: #565656;
}

#cWrap {
	width: 1050px;
	height: 2000px;
	margin-left: 252px;
}

#orderTitle {
	font-size: 25px;
	margin-top: 50px;
	margin-left: 72px;
}

button {
	outline: none;
}

.fc-event:hover {
	cursor: pointer;
	background-color: #a6d0f4;
	border-color: #a6d0f4;	
	color:#828080;
}

.fc-today{
	font-weight: bold;
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
