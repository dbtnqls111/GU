package sales.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sales.bean.SalesDTO;
import sales.dao.SalesDAO;

@Service
public class SalesServiceImpl implements SalesService {

	@Autowired
	private SalesDAO salesDAO;

	@Override
	public int insertSales(SalesDTO salesDTO) {
		return salesDAO.insertSales(salesDTO);
	}

	@Override
	public int updateSales(SalesDTO salesDTO) {
		return salesDAO.updateSales(salesDTO);
	}

	@Override
	public int deleteSales(int seq) {
		return salesDAO.deleteSales(seq);
	}

	@Override
	public SalesDTO getSales(int seq) {
		return salesDAO.getSales(seq);
	}

	@Override
	public ArrayList<SalesDTO> getSalesStandBy(String code) {
		return (ArrayList<SalesDTO>) salesDAO.getSalesStandBy(code);
	}

	@Override
	public ArrayList<SalesDTO> getSalesComplete(String code) {
		return (ArrayList<SalesDTO>) salesDAO.getSalesComplete(code);
	}

	@Override
	public ArrayList<HashMap<String, String>> getSalesStandByList(int startNum, int endNum) {
		return (ArrayList<HashMap<String, String>>) salesDAO.getSalesStandByList(startNum, endNum);
	}

	@Override
	public ArrayList<HashMap<String, String>> getSalesCompleteList(int startNum, int endNum) {
		return (ArrayList<HashMap<String, String>>) salesDAO.getSalesCompleteList(startNum, endNum);
	}

	@Override
	public int getSalesStandByListCount() {
		return salesDAO.getSalesStandByListCount();
	}

	@Override
	public int getSalesCompleteListCount() {
		return salesDAO.getSalesCompleteListCount();
	}

	@Override
	public ArrayList<HashMap<String, String>> getSearchedSalesStandByList(String keyword, int startNum, int endNum) {
		return (ArrayList<HashMap<String, String>>) salesDAO.getSearchedSalesStandByList(keyword, startNum, endNum);
	}

	@Override
	public ArrayList<HashMap<String, String>> getSearchedSalesCompleteList(String keyword, int startNum, int endNum) {
		return (ArrayList<HashMap<String, String>>) salesDAO.getSearchedSalesCompleteList(keyword, startNum, endNum);
	}

	@Override
	public int getSearchedSalesStandByListCount(String keyword) {
		return salesDAO.getSearchedSalesStandByListCount(keyword);
	}

	@Override
	public int getSearchedSalesCompleteListCount(String keyword) {
		return salesDAO.getSearchedSalesCompleteListCount(keyword);
	}

}
