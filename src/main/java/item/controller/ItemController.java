package item.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import item.bean.ItemDTO;
import net.sf.jxls.transformer.XLSTransformer;

@Controller
public class ItemController {

	@Autowired
	private ItemService itemService;

	@RequestMapping(value = "/item/list.do")
	public ModelAndView getItemList(HttpServletRequest req) {
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("type1", req.getParameter("type1"));
		modelAndView.setViewName("/item/list.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "getItem.do")
	public ModelAndView getItem(HttpServletRequest req) {
		ModelAndView modelAndView = new ModelAndView();
		String code = req.getParameter("code");

		ItemDTO itemDTO = itemService.getItem(code);

		modelAndView.addObject("itemDTO", itemDTO);
		modelAndView.setViewName("/item/itemView.jsp");

		return modelAndView;
	}

	// 품목 목록 요청
	@RequestMapping(value = "/admin/itemList_admin.do")
	public ModelAndView itemList_admin(HttpServletRequest request) {
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 20;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<ItemDTO> itemList = itemService.getItemList_admin(startNum, endNum);

		int listCount = itemService.getItemListCount();
		int maxPage = (listCount + (limit - 1)) / limit;
		int startPage = (page - 1) / 10 * 10 + 1;
		int endPage = startPage + 9;
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("itemList", itemList);
		modelAndView.addObject("page", page);
		modelAndView.addObject("maxPage", maxPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.setViewName("register/itemList.jsp");

		return modelAndView;
	}

	// 검색된 품목 목록 요청
	@RequestMapping(value = "/admin/searchedItemList_admin.do")
	public ModelAndView searchedItemList_admin(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 20;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<ItemDTO> itemList = itemService.getSearchedItemList(keyword, startNum, endNum);

		int listCount = itemService.getSearchedItemListCount(keyword);
		int maxPage = (listCount + (limit - 1)) / limit;
		int startPage = (page - 1) / 10 * 10 + 1;
		int endPage = startPage + 9;
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("itemList", itemList);
		modelAndView.addObject("keyword", keyword);
		modelAndView.addObject("page", page);
		modelAndView.addObject("maxPage", maxPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.setViewName("register/itemList.jsp");

		return modelAndView;
	}

	// 품목 입력 양식 요청
	@RequestMapping(value = "/admin/itemInsertForm_admin.do")
	public ModelAndView itemInsertForm_admin() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("register/itemInsertForm.jsp");

		return modelAndView;
	}

	// 품목 입력 요청
	@RequestMapping(value = "/admin/itemInsert_admin.do")
	public ModelAndView itemInsert_admin(HttpServletRequest request) {
		String code = request.getParameter("code");
		String type1 = request.getParameter("type1");
		String type2 = request.getParameter("type2");
		String brand = request.getParameter("brand");
		String name = request.getParameter("name");
		int wup = Integer.parseInt(request.getParameter("wup"));
		int uup = Integer.parseInt(request.getParameter("uup"));

		ItemDTO itemDTO = new ItemDTO();
		itemDTO.setCode(code);
		itemDTO.setType1(type1);
		itemDTO.setType2(type2);
		itemDTO.setBrand(brand);
		itemDTO.setName(name);
		itemDTO.setWup(wup);
		itemDTO.setUup(uup);

		int result = itemService.insertItem(itemDTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("register/itemInsert.jsp");

		return modelAndView;
	}

	// 품목 엑셀 입력 양식 요청
	@RequestMapping(value = "/admin/itemExcelInsertForm_admin.do")
	public ModelAndView itemExcelInsertForm_admin() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("register/itemExcelInsertForm.jsp");

		return modelAndView;
	}

	// 품목 엑셀 입력 요청
	@RequestMapping(value = "/admin/itemExcelInsert_admin.do")
	public ModelAndView itemExcelInsert_admin(HttpServletRequest request, MultipartFile upload) {
		String filePath = request.getSession().getServletContext().getRealPath("/storage");
		String fileName = upload.getOriginalFilename();

		File file = new File(filePath, fileName);
		Map<String, Object> beans = new HashMap<>();
		int result = 0;
		int rows = 0;

		try {
			FileCopyUtils.copy(upload.getInputStream(), new FileOutputStream(file));
		} catch (IOException e) {
			e.printStackTrace();
		}

		try {
			InputStream is = new BufferedInputStream(new FileInputStream(file));
			XLSTransformer xlsTransformer = new XLSTransformer();
			Workbook workbook = xlsTransformer.transformXLS(is, beans);

			Sheet sheet = workbook.getSheetAt(0);
			rows = sheet.getPhysicalNumberOfRows();

			for (int i = 1; i < rows; i++) {
				String code = sheet.getRow(i).getCell(0).getStringCellValue();
				String type1 = sheet.getRow(i).getCell(1).getStringCellValue();
				String type2 = sheet.getRow(i).getCell(2).getStringCellValue();
				String brand = sheet.getRow(i).getCell(3).getStringCellValue();
				String name = sheet.getRow(i).getCell(4).getStringCellValue();
				int wup = (int) sheet.getRow(i).getCell(5).getNumericCellValue();
				int uup = (int) sheet.getRow(i).getCell(6).getNumericCellValue();

				ItemDTO itemDTO = new ItemDTO();
				itemDTO.setCode(code);
				itemDTO.setType1(type1);
				itemDTO.setType2(type2);
				itemDTO.setBrand(brand);
				itemDTO.setName(name);
				itemDTO.setWup(wup);
				itemDTO.setUup(uup);

				result += itemService.insertItem(itemDTO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (file != null) {
				/*file.delete();*/
			}
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("total", rows - 1);
		modelAndView.addObject("result", result);
		modelAndView.setViewName("register/itemInsert.jsp");

		return modelAndView;
	}

	// 품목 삭제 요청
	@RequestMapping(value = "/admin/itemDelete_admin.do")
	public ModelAndView itemDelete_admin(HttpServletRequest request) {
		String[] codes = request.getParameterValues("check_i");

		int result = 0;
		for (String code : codes) {
			result += itemService.deleteItem(code);
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("total", codes.length);
		modelAndView.addObject("result", result);
		modelAndView.setViewName("register/itemDelete.jsp");

		return modelAndView;
	}

	// 품목 수정 양식 요청
	@RequestMapping(value = "/admin/itemUpdateForm_admin.do")
	public ModelAndView itemUpdateForm_admin(HttpServletRequest request) {
		String code = request.getParameter("code");

		ItemDTO itemDTO = itemService.getItem(code);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("itemDTO", itemDTO);
		modelAndView.setViewName("register/itemUpdateForm.jsp");

		return modelAndView;
	}

	// 품목 수정 요청
	@RequestMapping(value = "/admin/itemUpdate_admin.do")
	public ModelAndView itemUpdate_admin(HttpServletRequest request) {
		String code = request.getParameter("code");
		String type1 = request.getParameter("type1");
		String type2 = request.getParameter("type2");
		String brand = request.getParameter("brand");
		String name = request.getParameter("name");
		int wup = Integer.parseInt(request.getParameter("wup"));
		int uup = Integer.parseInt(request.getParameter("uup"));

		ItemDTO itemDTO = new ItemDTO();
		itemDTO.setCode(code);
		itemDTO.setType1(type1);
		itemDTO.setType2(type2);
		itemDTO.setBrand(brand);
		itemDTO.setName(name);
		itemDTO.setWup(wup);
		itemDTO.setUup(uup);

		int result = itemService.updateItem(itemDTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("register/itemUpdate.jsp");

		return modelAndView;
	}

}