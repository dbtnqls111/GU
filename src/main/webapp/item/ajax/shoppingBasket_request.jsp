<%@page import="order.dao.OrderDAO"%>
<%@page import="org.mybatis.spring.SqlSessionTemplate"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@page language="java" contentType="text/text; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String itemCode = request.getParameter("itemCode");
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	String memId = request.getParameter("memId");

	OrderDAO orderDAO = new OrderDAO();
	
	GenericXmlApplicationContext context = new GenericXmlApplicationContext("spring/application-config.xml");
	SqlSessionTemplate sessionTemplate = (SqlSessionTemplate)context.getBean("sessionTemplate");
	
	/*
		스프링 컨테이너를 통해 얻은 객체가 아닌 직접 생성한 객체이기 때문에
		자동 주입이 이루어지지 않으므로 SqlSessionTemplate 객체를 직접 주입해주어야 한다.
	*/
	orderDAO.setSqlSession(sessionTemplate);

	orderDAO.put(itemCode, quantity, memId);

	context.close();
%>