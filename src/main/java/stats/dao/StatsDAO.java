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

	public List<HashMap<String, Object>> getStatsByBranchList(String date) {
		return sqlSession.selectList("mybatis.salesMapper.getStatsByBranchList", date);
	}

	public List<HashMap<String, Object>> getStatsByBranchList_branchName(String date, String branchName) {
		Map<String, String> map = new HashMap<>();
		map.put("date", date);
		map.put("branchName", branchName);

		return sqlSession.selectList("mybatis.salesMapper.getStatsByBranchList_branchName", map);
	}

}
