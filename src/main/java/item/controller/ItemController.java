package item.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import item.bean.ItemDTO;

@Controller
public class ItemController {

	@Autowired
	private ItemService itemService;

	@RequestMapping(value = "/item/list.do")
	public ModelAndView loginForm(HttpServletRequest req) {
		ModelAndView modelAndView = new ModelAndView();
		ArrayList<ItemDTO> item_list = itemService.getItemList(req.getParameter("type2"));		
		
		modelAndView.addObject("item_list", item_list);
		modelAndView.addObject("type1", req.getParameter("type1"));
		modelAndView.setViewName("/item/list.jsp");

		return modelAndView;
	}
	
	@RequestMapping(value = "getItem.do")
	public ModelAndView getItem(HttpServletRequest req) {
		ModelAndView modelAndView = new ModelAndView();
		String code = req.getParameter("code");
		
		ItemDTO itemDTO = itemService.getItem(code);
		
		modelAndView.addObject("itemDTO", itemDTO);
		modelAndView.setViewName("/item/itemView.jsp");
		
		return modelAndView;
	}
}