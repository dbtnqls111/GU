package item.controller;

import java.util.ArrayList;

import item.bean.ItemDTO;

public interface ItemService {

	int insertItem(ItemDTO itemDTO);

	int updateItem(ItemDTO itemDTO);

	int deleteItem(String code);

	ItemDTO getItem(String code);

	ArrayList<ItemDTO> getItemList(String type2);
}
