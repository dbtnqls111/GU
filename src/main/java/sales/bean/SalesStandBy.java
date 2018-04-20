package sales.bean;

import java.util.ArrayList;

public class SalesStandBy {

	private String code;
	private String branchName;
	private String branchOwnerName;
	private ArrayList<SalesDTO> salesStandByList;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getBranchName() {
		return branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public String getBranchOwnerName() {
		return branchOwnerName;
	}

	public void setBranchOwnerName(String branchOwnerName) {
		this.branchOwnerName = branchOwnerName;
	}

	public ArrayList<SalesDTO> getSalesStandByList() {
		return salesStandByList;
	}

	public void setSalesStandByList(ArrayList<SalesDTO> salesStandByList) {
		this.salesStandByList = salesStandByList;
	}

}
