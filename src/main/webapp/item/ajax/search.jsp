<?xml version='1.0' encoding='UTF-8'?>

<%@page import="org.mybatis.spring.SqlSessionTemplate"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@page import="item.bean.ItemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="item.dao.ItemDAO"%>
<%@page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String keyword = request.getParameter("keyword");
	String type1 = request.getParameter("type1");
	String type2 = request.getParameter("type2");
	
	System.out.println("keyword : " + keyword);
	System.out.println("type1 : " + type1);
	System.out.println("type2 : " + type2);
	
	ItemDAO itemDAO = new ItemDAO();
	
	GenericXmlApplicationContext context = new GenericXmlApplicationContext("spring/application-config.xml");
	SqlSessionTemplate sessionTemplate = (SqlSessionTemplate)context.getBean("sessionTemplate");
	
	/*
		스프링 컨테이너를 통해 얻은 객체가 아닌 직접 생성한 객체이기 때문에
		자동 주입이 이루어지지 않으므로 SqlSessionTemplate 객체를 직접 주입해주어야 한다.
	*/
	itemDAO.setSqlSession(sessionTemplate);
	
	ArrayList<ItemDTO> searchedResult = (ArrayList<ItemDTO>)itemDAO.getSearchedItemList(keyword, type1, type2);
	
	final int ROW_PER_ITEMCOUNT = 4; // 행당 아이템 개수
	final int ITEMBOX_PER_ROWCOUNT = 3; // 아이템 박스당 행 개수
	final int ITEMBOX_PER_ITEMCOUNT = ROW_PER_ITEMCOUNT * ITEMBOX_PER_ROWCOUNT; // 아이템 박스당 아이템 개수

	int index = 0;
	int total_count = searchedResult.size();
	int itemBox_count = 0;
	
	if(total_count % ITEMBOX_PER_ITEMCOUNT == 0){
		itemBox_count = total_count / ITEMBOX_PER_ITEMCOUNT;
	}else{
		itemBox_count = total_count / ITEMBOX_PER_ITEMCOUNT + 1;
	}
	
	context.close();
%>

<root>
	<itemBox_count><%= itemBox_count %></itemBox_count>
	
	<%
		for(int i = 0; i < itemBox_count; i++){
	%>
			<divide<%= i %>>
	<%
			for(int j = 0; j < ITEMBOX_PER_ITEMCOUNT; j++){
				try{
					String code = searchedResult.get(index).getCode();
					String name =searchedResult.get(index).getName();
					int price = searchedResult.get(index).getUup();
	%>
					<item<%= index %> class="item">
						<code><%= code %></code>
						<name><![CDATA[<%= name %>]]></name>
						<price><%= price %></price>
					</item<%= index %>>
	<%	
				}catch(IndexOutOfBoundsException e){ break; }
				index++;
			}
	%>
			</divide<%= i %>>
	<%
		}
	%>
</root>