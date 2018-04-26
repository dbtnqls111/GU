package order.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import order.bean.OrderDTO;

@Repository
public class OrderDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int put(String itemCode, int quantity) {
		Map<String, Object> param = new HashMap<>();
		param.put("itemCode", itemCode);
		param.put("quantity", quantity);
		
		return sqlSession.insert("mybatis.orderMapper.put", param);
	}
	
	public List<OrderDTO> orderList(){
		return sqlSession.selectList("mybatis.orderMapper.orderList");
	}
	
	public int deleteOrder(int seq) {
		return sqlSession.delete("mybatis.orderMapper.deleteOrder", seq);
	}
}
