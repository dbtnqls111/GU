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

	public List<ItemDTO> getItemList(String type2) {
		if(type2.equals("전체")) {
			return sqlSession.selectList("mybatis.itemMapper.getItemListAll");
		}else {
			return sqlSession.selectList("mybatis.itemMapper.getItemList", type2);
		}
	}
	
	public String getType1(String type2) {
		return sqlSession.selectOne("mybatis.itemMapper.getType1", type2);
	}
	
	public List<ItemDTO> search(String keyword, String type2, int lowest_price, int highest_price){
		System.out.println("keyword : " + keyword);
		System.out.println("type2 : " + type2);
		System.out.println("lowest_price : " + lowest_price);
		System.out.println("highest_price : " + highest_price);
		
		if(type2.equals("전체")) {
			type2 = "%";
		}
		
		Map<String, Object> param = new HashMap<>();
		param.put("keyword", keyword);
		param.put("type2", type2);
		param.put("lowest_price", lowest_price);
		param.put("highest_price", highest_price);
		
		return sqlSession.selectList("mybatis.itemMapper.search", param);
	}
}