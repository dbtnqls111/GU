package order.controller;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import order.bean.OrderDTO;
import order.dao.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService{
	@Autowired
	private OrderDAO orderDAO;

	@Override
	public ArrayList<OrderDTO> orderList(String branchCode) {		
		return (ArrayList<OrderDTO>)orderDAO.orderList(branchCode);
	}

	@Override
	public int deleteOrder(int seq) {
		return orderDAO.deleteOrder(seq);
	}
}
