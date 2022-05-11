package phoneshopping.vo;

public class Order {
	private int id;//핸드폰 상품번호
	private String userid;
	private String phoneName;
	private String name;
	private String postcd;
	private String addr1;
	private String addr2;
	private int phone;
	private String memo;
	private int price;
	private int cnt;

	
	public Order(int id,String userid,String phoneName, String name, String postcd, String addr1, String addr2, int phone, String memo, int price,int cnt) {
		super();
		this.id=id;
		this.userid = userid;
		this.phoneName=phoneName;
		this.name = name;
		this.postcd = postcd;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.phone = phone;
		this.memo = memo;
		this.price = price;
		this.cnt=cnt;
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

	public int getPrice() {
		return price;
	}

	public void setPrice(int oPrice) {
		this.price = price;
	}

	public String getPhoneName() {
		return phoneName;
	}

	public void setPhoneName(String phoneName) {
		this.phoneName = phoneName;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public int getId() {
		return id;
	}
	
	
	
}
