package item.controller;

import java.util.ArrayList;

import item.bean.ItemDTO;

public interface ItemService {

	int insertItem(ItemDTO itemDTO);

	int updateItem(ItemDTO itemDTO);

	int deleteItem(String code);

	ItemDTO getItem(String code);

	ArrayList<ItemDTO> getItemList(String type1, String keyword, String type2, int lowest_price, int highest_price);

	ArrayList<ItemDTO> getItemList_admin(int startNum, int endNum);

	ArrayList<ItemDTO> getSearchedItemList(String keyword, int startNum, int endNum);

	int getItemListCount();

	int getSearchedItemListCount(String keyword);
}
