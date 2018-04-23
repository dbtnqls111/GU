package item.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import item.bean.ItemDTO;
import item.dao.ItemDAO;

@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	private ItemDAO itemDAO;

	@Override
	public int insertItem(ItemDTO itemDTO) {
		return itemDAO.insertItem(itemDTO);
	}

	@Override
	public int updateItem(ItemDTO itemDTO) {
		return itemDAO.updateItem(itemDTO);
	}

	@Override
	public int deleteItem(String code) {
		return itemDAO.deleteItem(code);
	}

	@Override
	public ItemDTO getItem(String code) {
		return itemDAO.getItem(code);
	}

	@Override
	public ArrayList<ItemDTO> getItemList(String type1, String keyword, String type2, int lowest_price, int highest_price) {
		return (ArrayList<ItemDTO>) itemDAO.getItemList(type1, keyword, type2, lowest_price, highest_price);
	}

	@Override
	public ArrayList<ItemDTO> getItemList_admin(int startNum, int endNum) {
		return (ArrayList<ItemDTO>) itemDAO.getItemList_admin(startNum, endNum);
	}

	@Override
	public ArrayList<ItemDTO> getSearchedItemList(String keyword, int startNum, int endNum) {
		return (ArrayList<ItemDTO>) itemDAO.getSearchedItemList(keyword, startNum, endNum);
	}

	@Override
	public int getItemListCount() {
		return itemDAO.getItemListCount();
	}

	@Override
	public int getSearchedItemListCount(String keyword) {
		return itemDAO.getSearchedItemListCount(keyword);
	}

}