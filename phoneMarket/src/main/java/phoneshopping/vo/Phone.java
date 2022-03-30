package phoneshopping.vo;

import java.util.Date;

public class Phone {
	private int id;
	private String kind;
	private String name;
	private String color;
	private String size;
	private String camera;
	private String image;
	private int price;
	private String stockqty;
	private String content;
	private int readcount;
	private Date regdate;
	private Date updatedate;
	
	public Phone() {}
	
	public Phone(int id,String kind, String name, String color, String size, String camera,String image, int price, String stockqty,
			String content,int readcount, Date regdate, Date updatedate) {
		super();
		this.id=id;
		this.kind = kind;
		this.name = name;
		this.color = color;
		this.size = size;
		this.camera = camera;
		this.image=image;
		this.price = price;
		this.stockqty = stockqty;
		this.content = content;
		this.readcount=readcount;
		this.regdate = regdate;
		this.updatedate = updatedate;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getCamera() {
		return camera;
	}

	public void setCamera(String camera) {
		this.camera = camera;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getStockqty() {
		return stockqty;
	}

	public void setStockqty(String stockqty) {
		this.stockqty = stockqty;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
}
