package admin.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import sales.controller.SalesService;

@Controller
public class AdminController {

	@Autowired
	private SalesService salesService;

	@RequestMapping(value = "/admin/main.do")
	public ModelAndView main() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Date currentTime = new Date();
		String today = sdf.format(currentTime);

		ArrayList<HashMap<String, String>> salesStandByList = salesService.getSalesStandByNews(today);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("salesStandByList", salesStandByList);
		modelAndView.setViewName("/admin/main.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "/admin/board.do")
	public ModelAndView board() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("board/board.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "/admin/register.do")
	public ModelAndView register() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("register/register.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "/admin/order.do")
	public ModelAndView order() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("order/order.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "/admin/stats.do")
	public ModelAndView statsByBranch() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("stats/stats.jsp");

		return modelAndView;
	}

}
