package sales.bean;

import java.util.ArrayList;

public class SalesComplete {

	private String code;
	private String branchName;
	private String branchOwnerName;
	private String salesDate;
	private ArrayList<SalesDTO> salesCompleteList;

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

	public String getSalesDate() {
		return salesDate;
	}

	public void setSalesDate(String salesDate) {
		this.salesDate = salesDate;
	}

	public ArrayList<SalesDTO> getSalesCompleteList() {
		return salesCompleteList;
	}

	public void setSalesCompleteList(ArrayList<SalesDTO> salesCompleteList) {
		this.salesCompleteList = salesCompleteList;
	}

}
