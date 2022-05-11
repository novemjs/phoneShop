package phoneshopping.vo;

import java.util.Date;

public class Review {
	private int id;
	private String userid;
	private String review;
	private String phoneName;
	private Date regdate;
	
	public Review() {}
	
	public Review(int id,String userid, String review,String phoneName) {
		super();
		this.id = id;
		this.userid=userid;
		this.review = review;
		this.phoneName=phoneName;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
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
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
}
