package sales.controller;

import java.util.ArrayList;

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
	public int deleteSales(String code) {
		return salesDAO.deleteSales(code);
	}

	@Override
	public SalesDTO getSales(String code) {
		return salesDAO.getSales(code);
	}

	@Override
	public ArrayList<SalesDTO> getSalesList() {
		return (ArrayList<SalesDTO>) salesDAO.getSalesList();
	}

}
