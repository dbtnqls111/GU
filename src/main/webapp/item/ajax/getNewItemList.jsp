<?xml version='1.0' encoding='UTF-8'?>

<%@page import="org.mybatis.spring.SqlSessionTemplate"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@page import="item.bean.ItemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="item.dao.ItemDAO"%>
<%@page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String type1 = request.getParameter("type1");
	
	ItemDAO itemDAO = new ItemDAO();
	
	GenericXmlApplicationContext context = new GenericXmlApplicationContext("spring/application-config.xml");
	SqlSessionTemplate sessionTemplate = (SqlSessionTemplate)context.getBean("sessionTemplate");
	
	/*
		스프링 컨테이너를 통해 얻은 객체가 아닌 직접 생성한 객체이기 때문에
		자동 주입이 이루어지지 않으므로 SqlSessionTemplate 객체를 직접 주입해주어야 한다.
	*/
	itemDAO.setSqlSession(sessionTemplate);
	
	
	int itemCount = itemDAO.getItemListCount(type1);
	
	System.out.println("[itemCount : " + itemCount + "]");
	int rand = (int)(Math.random() * ((itemCount - 3) - 1 + 1)) + 1; // itemCount가 25개인 경우의 난수 범위 : 1 ~ 22
	System.out.println("[rand : " + rand + "]");
	ArrayList<ItemDTO> item_list = (ArrayList<ItemDTO>)itemDAO.getItemList(type1, rand, rand + 4); // 난수가 22인 경우 22번 ~ 25번(최댓값) 아이템들이 반환됨
	System.out.println("[item_list(size) : " + item_list.size() + "]");

	context.close();
%>

<root>
	<%
		for(int i = 0; i < 4; i++){
			String code = item_list.get(i).getCode();
			String name = item_list.get(i).getName();
			int price = item_list.get(i).getUup();
	%>
			<item>
				<code><%= code %></code>
				<name><![CDATA[<%= name %>]]></name>
				<price><%= price %></price>
			</item>
	<%
		}
	%>
</root>