package sales.bean;

public class SalesDTO {

	private int seq;
	private String code; // 지점이 발주한 날짜 기반 코드 : yy/mm/dd - n, n은 날짜가 바뀌면 1로 초기화
	private String itemCode;
	private String branchCode;
	private int quantity;
	private int price;
	private String salesDate; // 본사가 발주 처리 완료한 날짜(비어있으면 발주 대기 상태)

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getBranchCode() {
		return branchCode;
	}

	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getSalesDate() {
		return salesDate;
	}

	public void setSalesDate(String salesDate) {
		this.salesDate = salesDate;
	}

}
