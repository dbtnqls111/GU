package branch.controller;

import java.util.ArrayList;

import branch.bean.BranchDTO;

public interface BranchService {

	int insertBranch(BranchDTO branchDTO);

	int updateBranch(BranchDTO branchDTO);

	int deleteBranch(String code);

	BranchDTO getBranch(String code);

	ArrayList<BranchDTO> getBranchList(int startNum, int endNum);

	ArrayList<BranchDTO> getSearchedBranchList(String keyword, int startNum, int endNum);

	int getBranchListCount();
	
	int getSearchedBranchListCount(String keyword);

}
