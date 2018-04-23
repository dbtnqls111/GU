package item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import item.bean.ItemDTO;

@Repository
public class ItemDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	public SqlSessionTemplate getSqlSession() {
		return sqlSession;
	}

	public int insertItem(ItemDTO itemDTO) {
		return sqlSession.insert("mybatis.itemMapper.insertItem", itemDTO);
	}

	public int updateItem(ItemDTO itemDTO) {
		return sqlSession.update("mybatis.itemMapper.updateItem", itemDTO);
	}

	public int deleteItem(String code) {
		return sqlSession.delete("mybatis.itemMapper.deleteItem", code);
	}

	public ItemDTO getItem(String code) {
		return sqlSession.selectOne("mybatis.itemMapper.getItem", code);
	}
	
	public List<ItemDTO> getItemList(String keyword, String type2, int lowest_price, int highest_price) {
		Map<String, Object> param = new HashMap<>();
		param.put("keyword", keyword);
		param.put("type2", type2);
		param.put("lowest_price", lowest_price);
		param.put("highest_price", highest_price);

		return sqlSession.selectList("mybatis.itemMapper.getItemList", param);
	}

	public List<ItemDTO> getItemList_admin(int startNum, int endNum) {
		Map<String, Integer> map = new HashMap<>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);

		return sqlSession.selectList("mybatis.itemMapper.getItemList_admin", map);
	}

	public List<ItemDTO> getSearchedItemList(String keyword, int startNum, int endNum) {
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", (String) keyword);
		map.put("startNum", (Integer) startNum);
		map.put("endNum", (Integer) endNum);

		return sqlSession.selectList("mybatis.itemMapper.getSearchedItemList", map);
	}

	public int getItemListCount() {
		return sqlSession.selectOne("mybatis.itemMapper.getItemListCount");
	}

	public int getSearchedItemListCount(String keyword) {
		return sqlSession.selectOne("mybatis.itemMapper.getSearchedItemListCount", keyword);
	}

}