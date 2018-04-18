package branch.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import branch.bean.BranchDTO;

@Repository
public class BranchDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertBranch(BranchDTO branchDTO) {
		return sqlSession.insert("mybatis.branchMapper.insertBranch", branchDTO);
	}

	public int updateBranch(BranchDTO branchDTO) {
		return sqlSession.update("mybatis.branchMapper.updateBranch", branchDTO);
	}

	public int deleteBranch(String code) {
		return sqlSession.delete("mybatis.branchMapper.deleteBranch", code);
	}

	public BranchDTO getBranch(String code) {
		return sqlSession.selectOne("mybatis.branchMapper.getBranch", code);
	}

	public List<BranchDTO> getBranchList(int startNum, int endNum) {
		Map<String, Integer> map = new HashMap<>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);

		return sqlSession.selectList("mybatis.branchMapper.getBranchList", map);
	}

	public List<BranchDTO> getSearchedBranchList(String keyword, int startNum, int endNum) {
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", (String) keyword);
		map.put("startNum", (Integer) startNum);
		map.put("endNum", (Integer) endNum);

		return sqlSession.selectList("mybatis.branchMapper.getSearchedBranchList", map);
	}

	public int getBranchListCount() {
		return sqlSession.selectOne("mybatis.branchMapper.getBranchListCount");
	}

	public int getSearchedBranchListCount(String keyword) {
		return sqlSession.selectOne("mybatis.branchMapper.getSearchedBranchListCount", keyword);
	}

}
