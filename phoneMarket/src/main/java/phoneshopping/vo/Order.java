package phoneshopping.vo;

public class Order {
	private String userid;
	private String name;
	private String postcd;
	private String addr1;
	private String addr2;
	private int phone;
	private String memo;
	private int orderPrice;

	
	public Order(String userid, String name, String postcd, String addr1, String addr2, int phone, String memo, int orderPrice) {
		super();
		this.userid = userid;
		this.name = name;
		this.postcd = postcd;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.phone = phone;
		this.memo = memo;
		this.orderPrice = orderPrice;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPostcd() {
		return postcd;
	}

	public void setPostcd(String postcd) {
		this.postcd = postcd;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public int getPhone() {
		return phone;
	}

	public void setPhone(int phone) {
		this.phone = phone;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public int getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}

	public String getId() {
		return userid;
	}

	public void setId(String userid) {
		this.userid = userid;
	}
	
}
