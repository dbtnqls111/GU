<?xml version='1.0' encoding='UTF-8'?> <!-- XML declaration allowed only at the start of the document -->

<%@page import="org.mybatis.spring.SqlSessionTemplate"%>
<%@page import="org.springframework.context.support.GenericXmlApplicationContext"%>
<%@page import="item.bean.ItemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="item.dao.ItemDAO"%>
<%@page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String keyword = request.getParameter("keyword");
	String type2 = request.getParameter("type2");
	int lowest_price = Integer.parseInt(request.getParameter("lowest_price"));
	int highest_price = Integer.parseInt(request.getParameter("highest_price"));

	ItemDAO itemDAO = new ItemDAO();
	
	GenericXmlApplicationContext context = new GenericXmlApplicationContext("spring/application-config.xml");
	SqlSessionTemplate sessionTemplate = (SqlSessionTemplate)context.getBean("sessionTemplate");
	context.close();
	
	itemDAO.setSqlSession(sessionTemplate);

	ArrayList<ItemDTO> item_list = (ArrayList<ItemDTO>)itemDAO.search(keyword, type2, lowest_price, highest_price);
	System.out.println("size : " + item_list.size());
	
/* 	final int ROW_PER_ITEMCOUNT = 4; // 행당 아이템 개수
	final int ITEMBOX_PER_ROWCOUNT = 3; // 아이템 박스당 행 개수
	final int ITEMBOX_PER_ITEMCOUNT = ROW_PER_ITEMCOUNT * ITEMBOX_PER_ROWCOUNT; // 아이템 박스당 아이템 개수

	int index = 0;
	int total_count = item_list.size();
	int itemBox_count = 0;
	
	if(total_count % ITEMBOX_PER_ITEMCOUNT == 0){
		itemBox_count = total_count / ITEMBOX_PER_ITEMCOUNT;
	}else{
		itemBox_count = total_count / ITEMBOX_PER_ITEMCOUNT + 1;
	} */
%>

<root>
	<%-- <itemBox_count><%= itemBox_count %></itemBox_count> --%>
	
<%-- 	<%
		for(int i = 0; i < itemBox_count; i++){
	%>
			<divide<%= i %>>
	<%
			for(int j = 0; j < 12; j++){
				try{
					String name = item_list.get(index).getName();
					int price = item_list.get(index).getUup();
					
					
	%>
					<item<%= index %> class="item">
						<name><![CDATA[<%= name %>]]></name>
						<price><%= price %></price>
					</item<%= index %>>
	<%	
				}catch(IndexOutOfBoundsException e){
					if(index % 4 == 0){
						break;
					}
	%>
					<item<%= index %>>　</item<%= index %>>
	<%				
				}
				index++;
			}
	%>
			</divide<%= i %>>
	<%
		}
	%> --%>
</root>