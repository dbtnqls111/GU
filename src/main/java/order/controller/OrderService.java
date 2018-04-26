package order.controller;

import java.util.ArrayList;

import order.bean.OrderDTO;

public interface OrderService {
	public int put(String itemCode, int quantity, String memId);
	public ArrayList<OrderDTO> orderList(String memId);
	public int deleteOrder(int seq);
}
