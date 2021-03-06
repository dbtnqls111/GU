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

	// list
	@RequestMapping(value = "/item/list.do")
	public ModelAndView getItemList(HttpServletRequest req) {
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("type1", req.getParameter("type1"));
		modelAndView.addObject("type2", req.getParameter("type2"));
		modelAndView.setViewName("/item/list.jsp");

		return modelAndView;
	}

	// search
	@RequestMapping(value = "/item/search.do")
	public ModelAndView getSearchedItemList(HttpServletRequest req) {
		ModelAndView modelAndView = new ModelAndView();
		
		String keyword = req.getParameter("keyword");
		if(keyword.trim().isEmpty()){ keyword = " "; }

		ArrayList<ItemDTO> itemList = itemService.getSearchedItemList(keyword);
		
		// -----------------------------------------------------------------------------------------------
		
		HashMap<String, ArrayList<String>> searchedResult = new HashMap<>();
		
		String[] type1_name_list = { "간편식사", "즉석조리", "과자류", "아이스크림", "식품", "음료", "생활용품" };
		
		HashMap<String, String[]> type2_name_list = new HashMap<>();
		type2_name_list.put("간편식사", new String[]{"도시락", "샌드위치/햄버거", "주먹밥/김밥"});
		type2_name_list.put("즉석조리", new String[]{"튀김", "베이커리", "즉석커피"});
		type2_name_list.put("과자류", new String[]{"스낵", "빵", "껌/캔디"});
		type2_name_list.put("아이스크림", new String[]{"아이스크림"});
		type2_name_list.put("식품", new String[]{"가공식사", "안주", "식재료"});
		type2_name_list.put("음료", new String[]{"일반음료", "아이스드링크", "유제품"});
		type2_name_list.put("생활용품", new String[]{"취미/레저", "의약외품", "잡화"});
		
		for(int i = 0; i < type1_name_list.length; i++) {
			searchedResult.put(type1_name_list[i], new ArrayList<String>());
		}
		
		for(int i = 0; i < type1_name_list.length; i++) {
			String type1_name = type1_name_list[i];
			
			for(ItemDTO itemDTO : itemList) {
				if(itemDTO.getType1().equals(type1_name)) {
					ArrayList<String> list = searchedResult.get(type1_name);
					int count = 0;
					
					if(list.size() == type2_name_list.get(type1_name).length) {
						break;
					}
					
					for(String type2_name : list) {
						if(itemDTO.getType2().equals(type2_name)){ 
							count++;
							break;
						}
					}
					
					if(count == 0){ list.add(itemDTO.getType2()); }
				}
			}
		}
		
		// -----------------------------------------------------------------------------------------------
		
		int notEmpty_count = 0;
		for(int i = 0; i < type1_name_list.length; i++) {
			if(searchedResult.get(type1_name_list[i]).size() > 0) {
				notEmpty_count++;
				break;
			}
		}
		
		if(notEmpty_count > 0) {
			modelAndView.addObject("searchedResult", searchedResult);
		}else {
			modelAndView.addObject("searchedResult", null);
		}
		
		modelAndView.addObject("keyword", keyword);
		modelAndView.setViewName("/item/searchedResult.jsp");
		
		return modelAndView;
	}

	
	// =======================================================================
	
	
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

			String column1 = sheet.getRow(0).getCell(0).getStringCellValue();
			String column2 = sheet.getRow(0).getCell(1).getStringCellValue();
			String column3 = sheet.getRow(0).getCell(2).getStringCellValue();
			String column4 = sheet.getRow(0).getCell(3).getStringCellValue();
			String column5 = sheet.getRow(0).getCell(4).getStringCellValue();
			String column6 = sheet.getRow(0).getCell(5).getStringCellValue();
			String column7 = sheet.getRow(0).getCell(6).getStringCellValue();

			if (column1.equals("code") && column2.equals("type1") && column3.equals("type2") && column4.equals("brand")
					&& column5.equals("name") && column6.equals("wup") && column7.equals("uup")) {
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (file != null) {

				// file.delete();

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

	// 품목 코드 중복 체크
	@RequestMapping(value = "/admin/itemCodeCheck_admin.do")
	public ModelAndView itemCodeCheck_admin(HttpServletRequest request) {
		String code = request.getParameter("code");
		boolean isExist = false;

		ItemDTO itemDTO = itemService.getItem(code);
		if (itemDTO != null) {
			isExist = true;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("isExist", isExist);
		modelAndView.addObject("code", code);
		modelAndView.setViewName("register/itemCodeCheck.jsp");

		return modelAndView;
	}

}