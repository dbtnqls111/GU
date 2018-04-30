package stats.bean;

public class StatsByItemDetailDTO implements Comparable<StatsByItemDetailDTO> {

	private int rank;
	private String itemType2;
	private int salesPrice;
	private double ratio;

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getItemType2() {
		return itemType2;
	}

	public void setItemType2(String itemType2) {
		this.itemType2 = itemType2;
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
	public int compareTo(StatsByItemDetailDTO o) {
		if (this.salesPrice > o.salesPrice) {
			return -1;
		} else if (this.salesPrice < o.salesPrice) {
			return 1;
		} else {
			return 0;
		}
	}

}
