package item.bean;

public class ItemDTO {

	private String code;
	private String type1;
	private String type2;
	private String brand;
	private String name;
	private int wup; // 입고단가
	private int uup; // 출고단가

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getType1() {
		return type1;
	}

	public void setType1(String type1) {
		this.type1 = type1;
	}

	public String getType2() {
		return type2;
	}

	public void setType2(String type2) {
		this.type2 = type2;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getWup() {
		return wup;
	}

	public void setWup(int wup) {
		this.wup = wup;
	}

	public int getUup() {
		return uup;
	}

	public void setUup(int uup) {
		this.uup = uup;
	}

}
