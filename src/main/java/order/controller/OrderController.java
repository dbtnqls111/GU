package order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	
	
	@RequestMapping(value = "order.do")	
	public ModelAndView oder(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		OrderDTO orderDTO;
		ArrayList<OrderDTO> orderList = new ArrayList<>();
		
		String orderStr = request.getParameter("orderList");
		System.out.println(orderStr);
		try {
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObj = (JSONObject) jsonParser.parse(orderStr);
            JSONArray orderArray = (JSONArray) jsonObj.get("order");

            for(int i=0 ; i<orderArray.size() ; i++){
                JSONObject temp = (JSONObject) orderArray.get(i);
                orderDTO = new OrderDTO();
                orderDTO.setSeq(Integer.parseInt(temp.get("seq").toString()));
                orderDTO.setItemCode(temp.get("itemCode").toString());
                orderDTO.setName(temp.get("name").toString());
                orderDTO.setUup(Integer.parseInt(temp.get("uup").toString()));
                orderDTO.setQuantity(Integer.parseInt(temp.get("quantity").toString()));
                orderDTO.setPrice(Integer.parseInt(temp.get("price").toString()));

                orderList.add(orderDTO);
            }
            
            modelAndView.addObject("orderList", orderList);
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		
		modelAndView.setViewName("/order/order.jsp");
		return modelAndView;
	}
	
	@RequestMapping(value = "ordering.do")
	public ModelAndView odering(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		OrderDTO orderDTO;
		ArrayList<OrderDTO> orderList = new ArrayList<>();
		
		String orderStr = request.getParameter("orderList");
		
		try {
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObj = (JSONObject) jsonParser.parse(orderStr);
            JSONArray orderArray = (JSONArray) jsonObj.get("order");

            for(int i=0 ; i<orderArray.size() ; i++){
                JSONObject temp = (JSONObject) orderArray.get(i);
                orderDTO = new OrderDTO();
                orderDTO.setSeq(Integer.parseInt(temp.get("seq").toString()));
                orderDTO.setItemCode(temp.get("itemCode").toString());
                orderDTO.setQuantity(Integer.parseInt(temp.get("quantity").toString()));
                orderDTO.setPrice(Integer.parseInt(temp.get("price").toString()));
                orderDTO.setBranchCode(temp.get("branchCode").toString());
                orderList.add(orderDTO);
            }
            
            modelAndView.addObject("orderList", orderList);
        } catch (Exception e) {
            e.printStackTrace();
        }
		modelAndView.setViewName("/admin/salesInsert_admin.do");
		return modelAndView;
	}
	
	
	@RequestMapping(value = "orderSuccess.do")
	public ModelAndView oderSuccess(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		Map<Integer, Integer> orderSeq = (HashMap<Integer, Integer>)request.getAttribute("orderSeq");
		
		for(int i=0; i<orderSeq.size(); i++) {
			orderService.deleteOrder(orderSeq.get(i));
		}		
		
		modelAndView.setViewName("/order/orderSuccess.jsp");
		return modelAndView;
	}
}
