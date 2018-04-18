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
	public ArrayList<ItemDTO> getItemList(String type2) {
		return (ArrayList<ItemDTO>) itemDAO.getItemList(type2);
	}
}