package sales.controller;

import java.util.ArrayList;
import java.util.HashMap;

import sales.bean.SalesDTO;

public interface SalesService {

	int insertSales(SalesDTO salesDTO);

	int updateSales(SalesDTO salesDTO);

	int updateSalesDateByCode(String salesDate, String code);

	int updateSalesDateBySeq(String salesDate, int seq);

	int deleteSales(int seq);

	SalesDTO getSales(int seq);

	ArrayList<SalesDTO> getSalesStandBy(String code);

	ArrayList<SalesDTO> getSalesComplete(String code);

	ArrayList<HashMap<String, String>> getSalesStandByList(int startNum, int endNum);

	ArrayList<HashMap<String, String>> getSalesCompleteList(int startNum, int endNum);

	int getSalesStandByListCount();

	int getSalesCompleteListCount();

	ArrayList<HashMap<String, String>> getSearchedSalesStandByList(String keyword, int startNum, int endNum);

	ArrayList<HashMap<String, String>> getSearchedSalesCompleteList(String keyword, int startNum, int endNum);

	int getSearchedSalesStandByListCount(String keyword);

	int getSearchedSalesCompleteListCount(String keyword);

	ArrayList<String> getCodeList(String today);
	
	ArrayList<SalesDTO> getsalesCurrentList(String branchCode);

	ArrayList<SalesDTO> getsalesCurrentListView(String branchCode, String code);
}
