package stats.bean;

public class StatsByBranchDTO implements Comparable<StatsByBranchDTO> {

	private int rank;
	private String branchName;
	private int salesPrice;
	private double ratio;

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getBranchName() {
		return branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public int getSalesPrice() {
		return salesPrice;
	}

	public void setSalesPrice(int salesPrice) {
		this.salesPrice = salesPrice;
	}

	public double getRatio() {
		return ratio;
	}

	public void setRatio(double ratio) {
		this.ratio = ratio;
	}

	@Override
	public int compareTo(StatsByBranchDTO o) {
		if (this.salesPrice > o.salesPrice) {
			return -1;
		} else if (this.salesPrice < o.salesPrice) {
			return 1;
		} else {
			return 0;
		}
	}

}
