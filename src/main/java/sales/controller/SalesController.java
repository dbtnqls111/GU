package sales.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import branch.controller.BranchService;
import item.bean.ItemDTO;
import item.controller.ItemService;
import sales.bean.SalesDTO;

@Controller
public class SalesController {

	@Autowired
	private SalesService salesService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private BranchService branchService;

	// (발주 코드별로 묶인)발주 대기 목록 요청
	@RequestMapping(value = "/admin/salesStandByList_admin.do")
	public ModelAndView salesStandByList_admin(HttpServletRequest request) {
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 20;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<HashMap<String, String>> salesStandByList = salesService.getSalesStandByList(startNum, endNum);
		for (int i = 0; i < salesStandByList.size(); i++) {
			String code = salesStandByList.get(i).get("salesCode");
			ArrayList<SalesDTO> salesStandBy = salesService.getSalesStandBy(code);
			// 발주 대기 목록 중 첫 번째 목록의 품목 이름
			String firstItemName = itemService.getItem(salesStandBy.get(0).getItemCode()).getName();
			// 발주 대기 목록 크기 - 1 (~외 몇개 표시)
			String orderNumber = String.valueOf((salesStandBy.size() - 1));
			salesStandByList.get(i).put("firstItemName", firstItemName);
			salesStandByList.get(i).put("orderNumber", orderNumber);
		}

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
		for (int i = 0; i < salesStandByList.size(); i++) {
			String code = salesStandByList.get(i).get("salesCode");
			ArrayList<SalesDTO> salesStandBy = salesService.getSalesStandBy(code);
			// 발주 대기 목록 중 첫 번째 목록의 품목 이름
			String firstItemName = itemService.getItem(salesStandBy.get(0).getItemCode()).getName();
			// 발주 대기 목록 크기 - 1 (~외 몇개 표시)
			String orderNumber = String.valueOf((salesStandBy.size() - 1));
			salesStandByList.get(i).put("firstItemName", firstItemName);
			salesStandByList.get(i).put("orderNumber", orderNumber);
		}

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
		ArrayList<HashMap<String, Object>> salesStandByMap = new ArrayList<>();
		String salesCode = salesStandBy.get(0).getCode();
		String branchName = branchService.getBranch(salesStandBy.get(0).getBranchCode()).getName();
		int totalSalesPrice = 0;

		for (SalesDTO salesDTO : salesStandBy) {
			HashMap<String, Object> map = new HashMap<>();
			int salesSeq = salesDTO.getSeq();
			int salesQuantity = salesDTO.getQuantity();
			int salesPrice = salesDTO.getPrice();
			totalSalesPrice += salesPrice;
			ItemDTO itemDTO = itemService.getItem(salesDTO.getItemCode());
			map.put("salesSeq", salesSeq);
			map.put("salesQuantity", salesQuantity);
			map.put("salesPrice", salesPrice);
			map.put("itemType1", itemDTO.getType1());
			map.put("itemType2", itemDTO.getType2());
			map.put("itemBrand", itemDTO.getBrand());
			map.put("itemName", itemDTO.getName());
			map.put("itemUup", itemDTO.getUup());
			salesStandByMap.add(map);
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("salesCode", salesCode);
		modelAndView.addObject("branchName", branchName);
		modelAndView.addObject("salesStandByMap", salesStandByMap);
		modelAndView.addObject("totalSalesPrice", totalSalesPrice);
		modelAndView.setViewName("order/salesStandBy.jsp");

		return modelAndView;
	}

	// (발주 코드별로 묶인)판매 완료 목록 요청
	@RequestMapping(value = "/admin/salesCompleteList_admin.do")
	public ModelAndView salesCompleteList_admin(HttpServletRequest request) {
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 20;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<HashMap<String, String>> salesCompleteList = salesService.getSalesCompleteList(startNum, endNum);
		for (int i = 0; i < salesCompleteList.size(); i++) {
			String code = salesCompleteList.get(i).get("salesCode");
			ArrayList<SalesDTO> salesComplete = salesService.getSalesComplete(code);
			// 판매 완료 목록 중 첫 번째 목록의 품목 이름
			String firstItemName = itemService.getItem(salesComplete.get(0).getItemCode()).getName();
			// 판매 완료 목록 크기 - 1 (~외 몇개 표시)
			String orderNumber = String.valueOf((salesComplete.size() - 1));
			salesCompleteList.get(i).put("firstItemName", firstItemName);
			salesCompleteList.get(i).put("orderNumber", orderNumber);
		}

		int listCount = salesService.getSalesCompleteListCount();
		int maxPage = (listCount + (limit - 1)) / limit;
		int startPage = (page - 1) / 3 * 3 + 1;
		int endPage = startPage + 2;
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("salesCompleteList", salesCompleteList);
		modelAndView.addObject("page", page);
		modelAndView.addObject("maxPage", maxPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.setViewName("order/salesCompleteList.jsp");

		return modelAndView;
	}

	// 검색된 (발주 코드별로 묶인)판매 완료 목록 요청
	@RequestMapping(value = "/admin/searchedSalesCompleteList_admin.do")
	public ModelAndView searchedSalesCompleteList_admin(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 20;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<HashMap<String, String>> salesCompleteList = salesService.getSearchedSalesCompleteList(keyword,
				startNum, endNum);
		for (int i = 0; i < salesCompleteList.size(); i++) {
			String code = salesCompleteList.get(i).get("salesCode");
			ArrayList<SalesDTO> salesComplete = salesService.getSalesComplete(code);
			// 판매 완료 목록 중 첫 번째 목록의 품목 이름
			String firstItemName = itemService.getItem(salesComplete.get(0).getItemCode()).getName();
			// 판매 완료 목록 크기 - 1 (~외 몇개 표시)
			String orderNumber = String.valueOf((salesComplete.size() - 1));
			salesCompleteList.get(i).put("firstItemName", firstItemName);
			salesCompleteList.get(i).put("orderNumber", orderNumber);
		}

		int listCount = salesService.getSearchedSalesCompleteListCount(keyword);
		int maxPage = (listCount + (limit - 1)) / limit;
		int startPage = (page - 1) / 3 * 3 + 1;
		int endPage = startPage + 2;
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("salesCompleteList", salesCompleteList);
		modelAndView.addObject("keyword", keyword);
		modelAndView.addObject("page", page);
		modelAndView.addObject("maxPage", maxPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.setViewName("order/salesCompleteList.jsp");

		return modelAndView;
	}

	// 선택된 발주 코드에 대한 판매 완료 상세 목록 요청
	@RequestMapping(value = "/admin/salesComplete_admin.do")
	public ModelAndView salesComplete_admin(HttpServletRequest request) {
		String code = request.getParameter("code");

		ArrayList<SalesDTO> salesComplete = salesService.getSalesComplete(code);
		ArrayList<HashMap<String, Object>> salesCompleteMap = new ArrayList<>();
		String salesCode = salesComplete.get(0).getCode();
		String branchName = branchService.getBranch(salesComplete.get(0).getBranchCode()).getName();
		int totalSalesPrice = 0;

		for (SalesDTO salesDTO : salesComplete) {
			HashMap<String, Object> map = new HashMap<>();
			int salesSeq = salesDTO.getSeq();
			int salesQuantity = salesDTO.getQuantity();
			int salesPrice = salesDTO.getPrice();
			String salesDate = salesDTO.getSalesDate();
			totalSalesPrice += salesPrice;
			ItemDTO itemDTO = itemService.getItem(salesDTO.getItemCode());
			map.put("salesSeq", salesSeq);
			map.put("salesQuantity", salesQuantity);
			map.put("salesPrice", salesPrice);
			map.put("salesDate", salesDate);
			map.put("itemType1", itemDTO.getType1());
			map.put("itemType2", itemDTO.getType2());
			map.put("itemBrand", itemDTO.getBrand());
			map.put("itemName", itemDTO.getName());
			map.put("itemUup", itemDTO.getUup());
			salesCompleteMap.add(map);
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("salesCode", salesCode);
		modelAndView.addObject("branchName", branchName);
		modelAndView.addObject("salesCompleteMap", salesCompleteMap);
		modelAndView.addObject("totalSalesPrice", totalSalesPrice);
		modelAndView.setViewName("order/salesComplete.jsp");

		return modelAndView;
	}

	// 발주 대기 -> 판매 완료 (판매 처리)
	@RequestMapping(value = "/admin/salesStandByToComplete_admin.do")
	public ModelAndView salesStandByToComplete_admin(HttpServletRequest request) {
		String[] codes = request.getParameterValues("check_i_code");
		String[] seqs = request.getParameterValues("check_i_seq");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date currentTime = new Date();
		String salesDate = sdf.format(currentTime);

		int result = 0;
		ModelAndView modelAndView = new ModelAndView();
		if (codes != null && seqs == null) {
			// 발주 코드째 선택
			for (String code : codes) {
				result += salesService.updateSalesDateByCode(salesDate, code);
			}
			modelAndView.addObject("result", result);
			modelAndView.setViewName("order/salesStandByToComplete.jsp");
		} else if (codes == null && seqs != null) {
			// 발주 코드내에서 항목 선택
			for (String seq : seqs) {
				result += salesService.updateSalesDateBySeq(salesDate, Integer.parseInt(seq));
			}
			modelAndView.addObject("result", result);
			modelAndView.setViewName("order/salesStandByToCompleteDetail.jsp");
		}

		return modelAndView;
	}

	// 판매 완료 -> 발주 대기 (판매 처리 취소)
	@RequestMapping(value = "/admin/salesCompleteToStandBy_admin.do")
	public ModelAndView salesCompleteToStandBy_admin(HttpServletRequest request) {
		String[] codes = request.getParameterValues("check_i_code");
		String[] seqs = request.getParameterValues("check_i_seq");

		int result = 0;
		ModelAndView modelAndView = new ModelAndView();
		if (codes != null && seqs == null) {
			// 발주 코드째 선택
			for (String code : codes) {
				result += salesService.updateSalesDateByCode("", code);
			}
			modelAndView.addObject("result", result);
			modelAndView.setViewName("order/salesCompleteToStandBy.jsp");
		} else if (codes == null && seqs != null) {
			// 발주 코드내에서 항목 선택
			for (String seq : seqs) {
				result += salesService.updateSalesDateBySeq("", Integer.parseInt(seq));
			}
			modelAndView.addObject("result", result);
			modelAndView.setViewName("order/salesCompleteToStandByDetail.jsp");
		}

		return modelAndView;
	}

	// 발주 대기 입력 요청
	@RequestMapping(value = "/admin/salesInsert_admin.do")
	public ModelAndView salesInsert_admin(HttpServletRequest request) {
		
		
		return null;
	}

}
