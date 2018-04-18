package admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {

	@RequestMapping(value = "/admin/main.do")
	public ModelAndView main() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/admin/main.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "/admin/notice.do")
	public ModelAndView notice() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice/notice.jsp");

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

	@RequestMapping(value = "/admin/statsByBranch.do")
	public ModelAndView statsByBranch() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("statsByBranch/statsByBranch.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "/admin/statsByItem.do")
	public ModelAndView statsByItem() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("statsByItem/statsByItem.jsp");

		return modelAndView;
	}

}
