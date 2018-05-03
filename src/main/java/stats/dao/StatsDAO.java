package stats.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StatsDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<HashMap<String, Object>> getStatsList(String date) {
		return sqlSession.selectList("mybatis.salesMapper.getStatsList", date);
	}

	public List<HashMap<String, Object>> getStatsListByBranchName(String date, String branchName) {
		Map<String, String> map = new HashMap<>();
		map.put("date", date);
		map.put("branchName", branchName);

		return sqlSession.selectList("mybatis.salesMapper.getStatsListByBranchName", map);
	}

	public List<HashMap<String, Object>> getStatsListByItemType1(String date, String itemType1) {
		Map<String, String> map = new HashMap<>();
		map.put("date", date);
		map.put("itemType1", itemType1);

		return sqlSession.selectList("mybatis.salesMapper.getStatsListByItemType1", map);
	}

}
