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
import stats.bean.StatsByItem;
import stats.bean.StatsByItemDTO;

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

	// 선택한 월의 판매 정보에 대한 지점별 통계
	@RequestMapping(value = "/admin/statsByBranch.do")
	public ModelAndView statsByBranch(HttpServletRequest request) {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = year + "/" + month;

		// 선택한 월에 대한 판매 정보를 모두 가져옴
		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsList(date);

		// 지점별로 판매액에 관한 통계
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

	// 선택한 월과 지점의 판매 정보에 대한 상세(품목별) 통계
	@RequestMapping(value = "/admin/statsByBranchToItem.do")
	public ModelAndView statsByBranchToItem(HttpServletRequest request) {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = year + "/" + month;
		String branchName = request.getParameter("branchName");

		// 선택한 월과 지점에 대한 판매 정보를 모두 가져옴
		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsListByBranchName(date, branchName);

		// 선택한 지점에 대한 상세(품목별) 통계
		StatsByItem statsByItem = new StatsByItem(statsList);
		ArrayList<StatsByItemDTO> statsByItemList = statsByItem.getStatsByItemList();
		int totalSalesPrice = statsByItem.getTotalSalesPrice();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("year", year);
		modelAndView.addObject("month", month);
		modelAndView.addObject("branchName", branchName);
		modelAndView.addObject("statsByItemList", statsByItemList);
		modelAndView.addObject("totalSalesPrice", totalSalesPrice);
		modelAndView.setViewName("stats/statsByBranchToItem.jsp");

		return modelAndView;
	}

	// 품목별 통계 요청
	@RequestMapping(value = "/admin/statsByItem_main.do")
	public ModelAndView statsByItem_admin(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("stats/statsByItem.jsp");

		return modelAndView;
	}

	// 선택한 월의 판매 정보에 대한 품목별 통계
	@RequestMapping(value = "/admin/statsByItem.do")
	public ModelAndView statsByItem(HttpServletRequest request) {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = year + "/" + month;

		// 선택한 월에 대한 판매 정보를 모두 가져옴
		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsList(date);

		// 품목별로 판매액에 관한 통계
		StatsByItem statsByItem = new StatsByItem(statsList);
		ArrayList<StatsByItemDTO> statsByItemList = statsByItem.getStatsByItemList();
		int totalSalesPrice = statsByItem.getTotalSalesPrice();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("year", year);
		modelAndView.addObject("month", month);
		modelAndView.addObject("statsByItemList", statsByItemList);
		modelAndView.addObject("totalSalesPrice", totalSalesPrice);
		modelAndView.setViewName("stats/statsByItem.jsp");

		return modelAndView;
	}

	// 선택한 월과 품목의 판매 정보에 대한 상세(지점별) 통계
	@RequestMapping(value = "/admin/statsByItemToBranch.do")
	public ModelAndView statsByItemToBranch(HttpServletRequest request) {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = year + "/" + month;
		String itemType1 = request.getParameter("itemType1");

		// 선택한 월과 품목에 대한 판매 정보를 모두 가져옴
		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsListByItemType1(date, itemType1);

		// 선택한 품목에 대한 상세(지점별) 통계
		StatsByBranch statsByBranch = new StatsByBranch(statsList);
		ArrayList<StatsByBranchDTO> statsByBranchList = statsByBranch.getStatsByBranchList();
		int totalSalesPrice = statsByBranch.getTotalSalesPrice();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("year", year);
		modelAndView.addObject("month", month);
		modelAndView.addObject("itemType1", itemType1);
		modelAndView.addObject("statsByBranchList", statsByBranchList);
		modelAndView.addObject("totalSalesPrice", totalSalesPrice);
		modelAndView.setViewName("stats/statsByItemToBranch.jsp");

		return modelAndView;
	}

}
