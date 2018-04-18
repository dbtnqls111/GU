package sales.controller;

import java.util.ArrayList;

import sales.bean.SalesDTO;

public interface SalesService {

	int insertSales(SalesDTO salesDTO);

	int updateSales(SalesDTO salesDTO);

	int deleteSales(String code);

	SalesDTO getSales(String code);

	ArrayList<SalesDTO> getSalesList();

}
