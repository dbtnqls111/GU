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
import stats.bean.StatsByBranch_itemType;
import stats.bean.StatsByBranch_itemType1DTO;
import stats.bean.StatsByBranch_itemType2DTO;

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
	public ModelAndView statsByBranch_month(HttpServletRequest request) {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = year + "/" + month;

		// 선택한 월에 대한 판매 정보를 모두 가져옴
		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsByBranchList(date);

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

	// 선택한 월과 지점의 판매 정보에 대한 상세(품목 타입별) 통계
	@RequestMapping(value = "/admin/statsByBranch_itemType.do")
	public ModelAndView statsByBranch_itemType1(HttpServletRequest request) {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = year + "/" + month;
		String branchName = request.getParameter("branchName");

		// 선택한 월과 지점에 대한 판매 정보를 모두 가져옴
		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsByBranchList_branchName(date, branchName);

		// 선택한 지점에 대한 상세(품목 타입별) 통계
		StatsByBranch_itemType statsByBranch_itemType = new StatsByBranch_itemType(statsList);
		ArrayList<StatsByBranch_itemType1DTO> statsByBranchList_itemType1 = statsByBranch_itemType
				.getStatsByBranchList_itemType();
		int totalSalesPrice = statsByBranch_itemType.getTotalSalesPrice();
		
		for (StatsByBranch_itemType1DTO a : statsByBranchList_itemType1) {
			System.out.println("=============================");
			System.out.println(a.getRank() + " " + a.getItemType1() + " " + a.getSalesPrice() + " " + a.getRatio());
			for (StatsByBranch_itemType2DTO b : a.getDetailList()) {
				System.out.println(b.getRank() + " " + b.getItemType2() + " " + b.getSalesPrice() + " " + b.getRatio());
			}
			System.out.println("=============================");
		}

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
