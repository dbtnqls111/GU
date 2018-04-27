package order.controller;

import java.util.ArrayList;

import order.bean.OrderDTO;

public interface OrderService {
	public int put(String itemCode, int quantity, String memId);
	public int getMaxSeq();
	
	public ArrayList<OrderDTO> orderList(String branchCode);
	public int deleteOrder(int seq);
}
