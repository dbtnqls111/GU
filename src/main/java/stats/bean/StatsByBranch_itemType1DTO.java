package stats.bean;

import java.util.ArrayList;

public class StatsByBranch_itemType1DTO implements Comparable<StatsByBranch_itemType1DTO> {

	private int rank;
	private String itemType1;
	private int salesPrice;
	private double ratio;
	private ArrayList<StatsByBranch_itemType2DTO> detailList;

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getItemType1() {
		return itemType1;
	}

	public void setItemType1(String itemType1) {
		this.itemType1 = itemType1;
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

	public ArrayList<StatsByBranch_itemType2DTO> getDetailList() {
		return detailList;
	}

	public void setDetailList(ArrayList<StatsByBranch_itemType2DTO> detailList) {
		this.detailList = detailList;
	}

	@Override
	public int compareTo(StatsByBranch_itemType1DTO o) {
		if (this.salesPrice > o.salesPrice) {
			return -1;
		} else if (this.salesPrice < o.salesPrice) {
			return 1;
		} else {
			return 0;
		}
	}

}
