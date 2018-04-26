package order.controller;

import java.util.ArrayList;

import order.bean.OrderDTO;

public interface OrderService {
	public int put(String itemCode, int quantity);
	public ArrayList<OrderDTO> orderList();
	public int deleteOrder(int seq);
}
