package branch.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import branch.bean.BranchDTO;

@Controller
public class BranchController {

	@Autowired
	private BranchService branchService;

	@RequestMapping(value = "/branch/branchList_admin.do")
	public ModelAndView branchList_admin() {
		ArrayList<BranchDTO> branchList = branchService.getBranchList();

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("branchList", branchList);
		modelAndView.setViewName("../admin/register/branchList.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "/branch/searchedBranchList_admin.do")
	public ModelAndView searchedBranchList_admin(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		ArrayList<BranchDTO> branchList = branchService.getSearchedBranchList(keyword);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("branchList", branchList);
		modelAndView.addObject("keyword", keyword);
		modelAndView.setViewName("../admin/register/branchList.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "/branch/branchInsertForm_admin.do")
	public ModelAndView branchInsertForm_admin() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("../admin/register/branchInsertForm.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "/branch/branchInsert_admin.do")
	public ModelAndView branchInsert_admin(HttpServletRequest request) {
		String code = request.getParameter("code");
		String name = request.getParameter("name");
		String address = request.getParameter("address");

		BranchDTO branchDTO = new BranchDTO();
		branchDTO.setCode(code);
		branchDTO.setName(name);
		branchDTO.setAddress(address);
		branchDTO.setOwnerId("");

		int result = branchService.insertBranch(branchDTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("../admin/register/branchInsert.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "/branch/branchDelete_admin.do")
	public ModelAndView branchDelete_admin(HttpServletRequest request) {
		String[] codes = request.getParameterValues("check_i");

		int result = 0;
		for (String code : codes) {
			result += branchService.deleteBranch(code);
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("total", codes.length);
		modelAndView.addObject("result", result);
		modelAndView.setViewName("../admin/register/branchDelete.jsp");

		return modelAndView;
	}

}
