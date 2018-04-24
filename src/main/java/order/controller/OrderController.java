package order.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import member.dao.MemberDAO;
import order.bean.OrderDTO;


@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value = "orderList.do")
	public ModelAndView getOrderList(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		
		ArrayList<OrderDTO> orderList =  orderService.orderList();
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memId");
		
		modelAndView.addObject("orderList", orderList);
		modelAndView.setViewName("/order/orderList.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "deleteOrder.do")
	public @ResponseBody String deleteOrder(HttpServletRequest request) {
		int seq = Integer.parseInt(request.getParameter("seq"));
		String str;
		int result = orderService.deleteOrder(seq);
		
		if(result>0) {
			str =  "{\"result\":\""+"성공"+"\"}";
			return str;
		}else {
			str = "{\"result\":\""+"실패"+"\"}";
			return str;
		}
	}
}
