package stats.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import stats.bean.StatsByBranch;
import stats.bean.StatsByBranchDTO;

@Controller
public class StatsController {

	@Autowired
	private StatsService statsService;

	// 지점별 통계 요청
	@RequestMapping(value = "/admin/statsByBranch_main.do")
	public ModelAndView salesStandByList_admin(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("stats/statsByBranch.jsp");

		return modelAndView;
	}

	// 선택한 월의 모든 판매 정보에 대한 지점별 통계
	@RequestMapping(value = "/admin/statsByBranch.do")
	public ModelAndView statsByBranch_month(HttpServletRequest request) {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = year + "/" + month;

		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsByBranchList(date);

		StatsByBranch statsByBranch = new StatsByBranch(statsList);
		ArrayList<StatsByBranchDTO> statsByBranchList = statsByBranch.getStatsByBranchList();
		int totalSalesPrice = statsByBranch.getTotalSalesPrice();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("year", year);
		modelAndView.addObject("month", month);
		modelAndView.addObject("statsByBranchList", statsByBranchList);
		modelAndView.addObject("totalSalesPrice", totalSalesPrice);
		modelAndView.setViewName("stats/statsByBranch.jsp");

		return modelAndView;
	}

	// 선택한 월과 지점의 모든 판매 정보에 대한 품목 타입별 통계
	@RequestMapping(value = "/admin/statsByBranch_itemType1.do")
	public ModelAndView statsByBranch_itemType1(HttpServletRequest request) {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = year + "/" + month;
		String branchName = request.getParameter("branchName");

		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsByBranchList_branchName(date, branchName);

		return null;
	}

	// 선택한 월과 지점의 모든 판매 정보에 대한 품목 브랜드별 통계
	@RequestMapping(value = "/admin/statsByBranch_itemBrand.do")
	public ModelAndView statsByBranch_itemBrand(HttpServletRequest request) {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = year + "/" + month;
		String branchName = request.getParameter("branchName");

		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsByBranchList_branchName(date, branchName);

		return null;
	}

	// 품목별 통계 요청
	@RequestMapping(value = "/admin/statsByItem_main.do")
	public ModelAndView statsByItem_admin(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("stats/statsByItem.jsp");

		return modelAndView;
	}

}
