package branch.controller;

import java.util.ArrayList;

import branch.bean.BranchDTO;

public interface BranchService {

	int insertBranch(BranchDTO branchDTO);

	int updateBranch(BranchDTO branchDTO);

	int deleteBranch(String code);

	BranchDTO getBranch(String code);

	ArrayList<BranchDTO> getBranchList();

	ArrayList<BranchDTO> getSearchedBranchList(String keyword);

}
