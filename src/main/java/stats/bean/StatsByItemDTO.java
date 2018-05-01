package stats.bean;

import java.util.ArrayList;

public class StatsByItemDTO implements Comparable<StatsByItemDTO> {

	private int rank;
	private String itemType1;
	private int salesPrice;
	private double ratio;
	private ArrayList<StatsByItemDetailDTO> detailList;

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

	public ArrayList<StatsByItemDetailDTO> getDetailList() {
		return detailList;
	}

	public void setDetailList(ArrayList<StatsByItemDetailDTO> detailList) {
		this.detailList = detailList;
	}

	@Override
	public int compareTo(StatsByItemDTO o) {
		if (this.salesPrice > o.salesPrice) {
			return -1;
		} else if (this.salesPrice < o.salesPrice) {
			return 1;
		} else {
			return 0;
		}
	}

}
