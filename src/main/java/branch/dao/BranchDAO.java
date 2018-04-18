package branch.dao;

import java.util.List;

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

	public List<BranchDTO> getBranchList() {
		return sqlSession.selectList("mybatis.branchMapper.getBranchList");
	}

	public List<BranchDTO> getSearchedBranchList(String keyword) {
		return sqlSession.selectList("mybatis.branchMapper.getSearchedBranchList", keyword);
	}

}
