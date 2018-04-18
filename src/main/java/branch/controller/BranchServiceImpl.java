package branch.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import branch.bean.BranchDTO;
import branch.dao.BranchDAO;

@Service
public class BranchServiceImpl implements BranchService {

	@Autowired
	private BranchDAO branchDAO;

	@Override
	public int insertBranch(BranchDTO branchDTO) {
		return branchDAO.insertBranch(branchDTO);
	}

	@Override
	public int updateBranch(BranchDTO branchDTO) {
		return branchDAO.updateBranch(branchDTO);
	}

	@Override
	public int deleteBranch(String code) {
		return branchDAO.deleteBranch(code);
	}

	@Override
	public BranchDTO getBranch(String code) {
		return branchDAO.getBranch(code);
	}

	@Override
	public ArrayList<BranchDTO> getBranchList(int startNum, int endNum) {
		return (ArrayList<BranchDTO>) branchDAO.getBranchList(startNum, endNum);
	}

	@Override
	public ArrayList<BranchDTO> getSearchedBranchList(String keyword, int startNum, int endNum) {
		return (ArrayList<BranchDTO>) branchDAO.getSearchedBranchList(keyword, startNum, endNum);
	}

	@Override
	public int getBranchListCount() {
		return branchDAO.getBranchListCount();
	}

	@Override
	public int getSearchedBranchListCount(String keyword) {
		return branchDAO.getSearchedBranchListCount(keyword);
	}

}
