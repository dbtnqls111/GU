package stats.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import stats.bean.StatsByBranchDTO;
import stats.bean.StatsByBranchForGraph;
import stats.bean.StatsByBranchForTable;
import stats.bean.StatsByItemDTO;
import stats.bean.StatsByItemForGraph;
import stats.bean.StatsByItemForTable;

@Controller
public class StatsController {

	@Autowired
	private StatsService statsService;

	public ArrayList<String> getLast6MonthDates(String yyyyDD) {
		// 그래프를 위한 지난 여섯 달의 날짜
		ArrayList<String> last6MonthDates = new ArrayList<>();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		try {
			Date date2 = sdf.parse(yyyyDD + "/01");

			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date2);

			last6MonthDates.add(yyyyDD);
			for (int i = 0; i < 5; i++) {
				calendar.add(Calendar.MONTH, -1);
				last6MonthDates.add(sdf.format(calendar.getTime()).substring(0, 7));
			}
			Collections.reverse(last6MonthDates);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return last6MonthDates;
	}

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

		// 선택한 월에 대한 판매 정보를 모두 가져옴(표)
		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsList(date);

		// 선택한 월의 지점별 판매액에 관한 통계(표)
		StatsByBranchForTable statsByBranchForTable = new StatsByBranchForTable(statsList);
		ArrayList<StatsByBranchDTO> statsByBranchListForTable = statsByBranchForTable.getStatsByBranchList();
		int totalSalesPrice = statsByBranchForTable.getTotalSalesPrice();

		// 선택한 월과 그 이전 5달까지의 목록(yyyy/DD 포맷)
		ArrayList<String> last6MonthDates = getLast6MonthDates(date);

		// 선택한 월과 해당 월 기준 지난 다섯 달에 대한 판매 정보를 모두 가져옴(그래프)
		ArrayList<ArrayList<HashMap<String, Object>>> statsList6 = new ArrayList<>();
		for (String lastDate : last6MonthDates) {
			statsList6.add(statsService.getStatsList(lastDate));
		}

		// 선택한 월과 해당 월 기준 지난 다섯 달의 지점별 판매액에 관한 통계(그래프)
		StatsByBranchForGraph statsByBranchForGraph = new StatsByBranchForGraph(statsList6);
		ArrayList<ArrayList<StatsByBranchDTO>> statsByBranchListForGraph6 = statsByBranchForGraph
				.getStatsByBranchList6();
		ArrayList<String> branchNameListForGraph = statsByBranchForGraph.getBranchNameListForGraph();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("year", year);
		modelAndView.addObject("month", month);
		modelAndView.addObject("statsByBranchListForTable", statsByBranchListForTable);
		modelAndView.addObject("totalSalesPrice", totalSalesPrice);
		modelAndView.addObject("statsByBranchListForGraph6", statsByBranchListForGraph6);
		modelAndView.addObject("branchNameListForGraph", branchNameListForGraph);
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

		// 선택한 월과 지점에 대한 판매 정보를 모두 가져옴(표)
		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsListByBranchName(date, branchName);

		// 선택한 월과 지점에 대한 상세(품목별) 통계
		StatsByItemForTable statsByItemForTable = new StatsByItemForTable(statsList);
		ArrayList<StatsByItemDTO> statsByItemListForTable = statsByItemForTable.getStatsByItemList();
		int totalSalesPrice = statsByItemForTable.getTotalSalesPrice();

		// 선택한 월과 그 이전 5달까지의 목록(yyyy/DD 포맷)
		ArrayList<String> last6MonthDates = getLast6MonthDates(date);

		// 선택한 월과 해당 월 기준 지난 다섯 달에 대한 판매 정보를 모두 가져옴(그래프)
		ArrayList<ArrayList<HashMap<String, Object>>> statsList6 = new ArrayList<>();
		for (String lastDate : last6MonthDates) {
			statsList6.add(statsService.getStatsListByBranchName(lastDate, branchName));
		}

		// 선택한 월과 해당 월 기준 지난 다섯 달의 품목별 판매액에 관한 통계(그래프)
		StatsByItemForGraph statsByItemForGraph = new StatsByItemForGraph(statsList6);
		ArrayList<ArrayList<StatsByItemDTO>> statsByItemListForGraph6 = statsByItemForGraph.getStatsByItemList6();
		ArrayList<String> itemType1ListForGraph = statsByItemForGraph.getItemType1ListForGraph();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("year", year);
		modelAndView.addObject("month", month);
		modelAndView.addObject("branchName", branchName);
		modelAndView.addObject("statsByItemListForTable", statsByItemListForTable);
		modelAndView.addObject("totalSalesPrice", totalSalesPrice);
		modelAndView.addObject("statsByItemListForGraph6", statsByItemListForGraph6);
		modelAndView.addObject("itemType1ListForGraph", itemType1ListForGraph);
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

		// 선택한 월에 대한 판매 정보를 모두 가져옴(표)
		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsList(date);

		// 선택한 월의 품목별 판매액에 관한 통계(표)
		StatsByItemForTable statsByItemForTable = new StatsByItemForTable(statsList);
		ArrayList<StatsByItemDTO> statsByItemListForTable = statsByItemForTable.getStatsByItemList();
		int totalSalesPrice = statsByItemForTable.getTotalSalesPrice();

		// 선택한 월과 그 이전 5달까지의 목록(yyyy/DD 포맷)
		ArrayList<String> last6MonthDates = getLast6MonthDates(date);

		// 선택한 월과 해당 월 기준 지난 다섯 달에 대한 판매 정보를 모두 가져옴(그래프)
		ArrayList<ArrayList<HashMap<String, Object>>> statsList6 = new ArrayList<>();
		for (String lastDate : last6MonthDates) {
			statsList6.add(statsService.getStatsList(lastDate));
		}

		// 선택한 월과 해당 월 기준 지난 다섯 달의 품목별 판매액에 관한 통계(그래프)
		StatsByItemForGraph statsByItemForGraph = new StatsByItemForGraph(statsList6);
		ArrayList<ArrayList<StatsByItemDTO>> statsByItemListForGraph6 = statsByItemForGraph.getStatsByItemList6();
		ArrayList<String> itemType1ListForGraph = statsByItemForGraph.getItemType1ListForGraph();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("year", year);
		modelAndView.addObject("month", month);
		modelAndView.addObject("statsByItemListForTable", statsByItemListForTable);
		modelAndView.addObject("totalSalesPrice", totalSalesPrice);
		modelAndView.addObject("statsByItemListForGraph6", statsByItemListForGraph6);
		modelAndView.addObject("itemType1ListForGraph", itemType1ListForGraph);
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

		// 선택한 월과 품목에 대한 판매 정보를 모두 가져옴(표)
		ArrayList<HashMap<String, Object>> statsList = statsService.getStatsListByItemType1(date, itemType1);

		// 선택한 월과 품목에 대한 상세(지점별) 통계
		StatsByBranchForTable statsByBranchForTable = new StatsByBranchForTable(statsList);
		ArrayList<StatsByBranchDTO> statsByBranchListForTable = statsByBranchForTable.getStatsByBranchList();
		int totalSalesPrice = statsByBranchForTable.getTotalSalesPrice();

		// 선택한 월과 그 이전 5달까지의 목록(yyyy/DD 포맷)
		ArrayList<String> last6MonthDates = getLast6MonthDates(date);

		// 선택한 월과 해당 월 기준 지난 다섯 달에 대한 판매 정보를 모두 가져옴(그래프)
		ArrayList<ArrayList<HashMap<String, Object>>> statsList6 = new ArrayList<>();
		for (String lastDate : last6MonthDates) {
			statsList6.add(statsService.getStatsListByItemType1(lastDate, itemType1));
		}

		// 선택한 월과 해당 월 기준 지난 다섯 달의 지점별 판매액에 관한 통계(그래프)
		StatsByBranchForGraph statsByBranchForGraph = new StatsByBranchForGraph(statsList6);
		ArrayList<ArrayList<StatsByBranchDTO>> statsByBranchListForGraph6 = statsByBranchForGraph
				.getStatsByBranchList6();
		ArrayList<String> branchNameListForGraph = statsByBranchForGraph.getBranchNameListForGraph();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("year", year);
		modelAndView.addObject("month", month);
		modelAndView.addObject("itemType1", itemType1);
		modelAndView.addObject("statsByBranchListForTable", statsByBranchListForTable);
		modelAndView.addObject("totalSalesPrice", totalSalesPrice);
		modelAndView.addObject("statsByBranchListForGraph6", statsByBranchListForGraph6);
		modelAndView.addObject("branchNameListForGraph", branchNameListForGraph);
		modelAndView.setViewName("stats/statsByItemToBranch.jsp");

		return modelAndView;
	}

}
