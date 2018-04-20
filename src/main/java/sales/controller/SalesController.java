package sales.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import sales.bean.SalesDTO;

@Controller
public class SalesController {

	@Autowired
	private SalesService salesService;

	// (발주 코드별로 묶인)발주 대기 목록 요청
	@RequestMapping(value = "/admin/salesStandByList_admin.do")
	public ModelAndView salesStandByList_admin(HttpServletRequest request) {
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 20;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<HashMap<String, String>> salesStandByList = salesService.getSalesStandByList(startNum, endNum);

		int listCount = salesService.getSalesStandByListCount();
		int maxPage = (listCount + (limit - 1)) / limit;
		int startPage = (page - 1) / 3 * 3 + 1;
		int endPage = startPage + 2;
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("salesStandByList", salesStandByList);
		modelAndView.addObject("page", page);
		modelAndView.addObject("maxPage", maxPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.setViewName("order/salesStandByList.jsp");

		return modelAndView;
	}

	// 검색된 (발주 코드별로 묶인)발주 대기 목록 요청
	@RequestMapping(value = "/admin/searchedSalesStandByList_admin.do")
	public ModelAndView searchedSalesStandByList_admin(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 20;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<HashMap<String, String>> salesStandByList = salesService.getSearchedSalesStandByList(keyword,
				startNum, endNum);

		int listCount = salesService.getSearchedSalesStandByListCount(keyword);
		int maxPage = (listCount + (limit - 1)) / limit;
		int startPage = (page - 1) / 3 * 3 + 1;
		int endPage = startPage + 2;
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("salesStandByList", salesStandByList);
		modelAndView.addObject("keyword", keyword);
		modelAndView.addObject("page", page);
		modelAndView.addObject("maxPage", maxPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.setViewName("order/salesStandByList.jsp");

		return modelAndView;
	}

	// 선택된 발주 코드에 대한 발주 대기 상세 목록 요청
	@RequestMapping(value = "/admin/salesStandBy_admin.do")
	public ModelAndView salesStandBy_admin(HttpServletRequest request) {
		String code = request.getParameter("code");

		ArrayList<SalesDTO> salesStandBy = salesService.getSalesStandBy(code);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("salesStandBy", salesStandBy);
		modelAndView.setViewName("order/salesStandBy.jsp");

		return modelAndView;
	}

	// (발주 코드별로 묶인)판매 완료 목록 요청 - 미완성
	@RequestMapping(value = "/admin/salesCompleteList_admin.do")
	public ModelAndView salesCompleteList_admin(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("order/salesCompleteList.jsp");

		return modelAndView;
	}

}
