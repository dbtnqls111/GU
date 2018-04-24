package branch.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import branch.bean.BranchDTO;

@Controller
public class BranchController {

	@Autowired
	private BranchService branchService;

	// 지점 목록 요청
	@RequestMapping(value = "/admin/branchList_admin.do")
	public ModelAndView branchList_admin(HttpServletRequest request) {
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 20;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<BranchDTO> branchList = branchService.getBranchList(startNum, endNum);

		int listCount = branchService.getBranchListCount();
		int maxPage = (listCount + (limit - 1)) / limit;
		int startPage = (page - 1) / 5 * 5 + 1;
		int endPage = startPage + 4;
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("branchList", branchList);
		modelAndView.addObject("page", page);
		modelAndView.addObject("maxPage", maxPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.setViewName("register/branchList.jsp");

		return modelAndView;
	}

	// 검색된 지점 목록 요청
	@RequestMapping(value = "/admin/searchedBranchList_admin.do")
	public ModelAndView searchedBranchList_admin(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 20;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<BranchDTO> branchList = branchService.getSearchedBranchList(keyword, startNum, endNum);

		int listCount = branchService.getSearchedBranchListCount(keyword);
		int maxPage = (listCount + (limit - 1)) / limit;
		int startPage = (page - 1) / 5 * 5 + 1;
		int endPage = startPage + 4;
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("branchList", branchList);
		modelAndView.addObject("keyword", keyword);
		modelAndView.addObject("page", page);
		modelAndView.addObject("maxPage", maxPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.setViewName("register/branchList.jsp");

		return modelAndView;
	}

	// 지점 입력 양식 요청
	@RequestMapping(value = "/admin/branchInsertForm_admin.do")
	public ModelAndView branchInsertForm_admin() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("register/branchInsertForm.jsp");

		return modelAndView;
	}

	// 지점 입력 요청
	@RequestMapping(value = "/admin/branchInsert_admin.do")
	public ModelAndView branchInsert_admin(HttpServletRequest request) {
		String code = request.getParameter("code");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String ownerId = request.getParameter("ownerId");

		BranchDTO branchDTO = new BranchDTO();
		branchDTO.setCode(code);
		branchDTO.setName(name);
		branchDTO.setAddress(address);
		if (ownerId == null) {
			branchDTO.setOwnerId("");
		} else {
			branchDTO.setOwnerId(ownerId);
		}

		int result = branchService.insertBranch(branchDTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("register/branchInsert.jsp");

		return modelAndView;
	}

	// 지점 엑셀 입력 양식 요청
	@RequestMapping(value = "/admin/branchExcelInsertForm_admin.do")
	public ModelAndView branchExcelInsertForm_admin() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("register/branchExcelInsertForm.jsp");

		return modelAndView;
	}

	// 품목 엑셀 입력 요청
	@RequestMapping(value = "/admin/branchExcelInsert_admin.do")
	public ModelAndView branchExcelInsert_admin(HttpServletRequest request, MultipartFile upload) {

		return null;
	}

	// 지점 삭제 요청
	@RequestMapping(value = "/admin/branchDelete_admin.do")
	public ModelAndView branchDelete_admin(HttpServletRequest request) {
		String[] codes = request.getParameterValues("check_i");

		int result = 0;
		for (String code : codes) {
			result += branchService.deleteBranch(code);
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("total", codes.length);
		modelAndView.addObject("result", result);
		modelAndView.setViewName("register/branchDelete.jsp");

		return modelAndView;
	}

	// 지점 수정 양식 요청
	@RequestMapping(value = "/admin/branchUpdateForm_admin.do")
	public ModelAndView branchUpdateForm_admin(HttpServletRequest request) {
		String code = request.getParameter("code");

		BranchDTO branchDTO = branchService.getBranch(code);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("branchDTO", branchDTO);
		modelAndView.setViewName("register/branchUpdateForm.jsp");

		return modelAndView;
	}

	// 지점 수정 요청
	@RequestMapping(value = "/admin/branchUpdate_admin.do")
	public ModelAndView branchUpdate_admin(HttpServletRequest request) {
		String code = request.getParameter("code");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String ownerId = request.getParameter("ownerId");

		BranchDTO branchDTO = new BranchDTO();
		branchDTO.setCode(code);
		branchDTO.setName(name);
		branchDTO.setAddress(address);
		if (ownerId == null) {
			branchDTO.setOwnerId("");
		} else {
			branchDTO.setOwnerId(ownerId);
		}

		int result = branchService.updateBranch(branchDTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("register/branchUpdate.jsp");

		return modelAndView;
	}

}
