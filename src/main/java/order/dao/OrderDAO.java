package order.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import order.bean.OrderDTO;

@Repository
public class OrderDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<OrderDTO> orderList(){
		return sqlSession.selectList("mybatis.orderMapper.orderList");
	}
}
