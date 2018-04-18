package sales.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sales.bean.SalesDTO;

@Repository
public class SalesDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertSales(SalesDTO salesDTO) {
		return sqlSession.insert("mybatis.salesMapper.insertSales", salesDTO);
	}

	public int updateSales(SalesDTO salesDTO) {
		return sqlSession.update("mybatis.salesMapper.updateSales", salesDTO);
	}

	public int deleteSales(String code) {
		return sqlSession.delete("mybatis.salesMapper.deleteSales", code);
	}

	public SalesDTO getSales(String code) {
		return sqlSession.selectOne("mybatis.salesMapper.getSales", code);
	}

	public List<SalesDTO> getSalesList() {
		return sqlSession.selectList("mybatis.salesMapper.getSalesList");
	}

}
