package sales.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public int updateSalesDateByCode(String salesDate, String code) {
		Map<String, String> map = new HashMap<>();
		map.put("salesDate", salesDate);
		map.put("code", code);

		return sqlSession.update("mybatis.salesMapper.updateSalesDateByCode", map);
	}

	public int updateSalesDateBySeq(String salesDate, int seq) {
		Map<String, Object> map = new HashMap<>();
		map.put("salesDate", (String) salesDate);
		map.put("seq", (Integer) seq);

		return sqlSession.update("mybatis.salesMapper.updateSalesDateBySeq", map);
	}

	public int deleteSales(int seq) {
		return sqlSession.delete("mybatis.salesMapper.deleteSales", seq);
	}

	public SalesDTO getSales(int seq) {
		return sqlSession.selectOne("mybatis.salesMapper.getSales", seq);
	}

	public List<SalesDTO> getSalesStandBy(String code) {
		return sqlSession.selectList("mybatis.salesMapper.getSalesStandBy", code);
	}

	public List<SalesDTO> getSalesComplete(String code) {
		return sqlSession.selectList("mybatis.salesMapper.getSalesComplete", code);
	}

	public List<HashMap<String, String>> getSalesStandByNews(String today) {
		return sqlSession.selectList("mybatis.salesMapper.getSalesStandByNews", today);
	}

	public List<HashMap<String, String>> getSalesStandByList(int startNum, int endNum) {
		Map<String, Integer> map = new HashMap<>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);

		return sqlSession.selectList("mybatis.salesMapper.getSalesStandByList", map);
	}

	public List<HashMap<String, String>> getSalesCompleteList(int startNum, int endNum) {
		Map<String, Integer> map = new HashMap<>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);

		return sqlSession.selectList("mybatis.salesMapper.getSalesCompleteList", map);
	}

	public int getSalesStandByListCount() {
		return sqlSession.selectOne("mybatis.salesMapper.getSalesStandByListCount");
	}

	public int getSalesCompleteListCount() {
		return sqlSession.selectOne("mybatis.salesMapper.getSalesCompleteListCount");
	}

	public List<HashMap<String, String>> getSearchedSalesStandByList(String keyword, int startNum, int endNum) {
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", (String) keyword);
		map.put("startNum", (Integer) startNum);
		map.put("endNum", (Integer) endNum);

		return sqlSession.selectList("mybatis.salesMapper.getSearchedSalesStandByList", map);
	}

	public List<HashMap<String, String>> getSearchedSalesCompleteList(String keyword, int startNum, int endNum) {
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", (String) keyword);
		map.put("startNum", (Integer) startNum);
		map.put("endNum", (Integer) endNum);

		return sqlSession.selectList("mybatis.salesMapper.getSearchedSalesCompleteList", map);
	}

	public int getSearchedSalesStandByListCount(String keyword) {
		return sqlSession.selectOne("mybatis.salesMapper.getSearchedSalesStandByListCount", keyword);
	}

	public int getSearchedSalesCompleteListCount(String keyword) {
		return sqlSession.selectOne("mybatis.salesMapper.getSearchedSalesCompleteListCount", keyword);
	}

	public List<String> getCodeList(String today) {
		return sqlSession.selectList("mybatis.salesMapper.getCodeList", today);
	}

	public List<SalesDTO> getsalesCurrentList(String branchCode) {
		return sqlSession.selectList("mybatis.salesMapper.getsalesCurrentList", branchCode);
	}

	public List<SalesDTO> getsalesCurrentListView(String branchCode, String code) {
		Map<String, Object> map = new HashMap<>();
		map.put("branchCode", branchCode);
		map.put("code", code);
		return sqlSession.selectList("mybatis.salesMapper.getSalesCurrentListView", map);
	}

}
