package phoneshopping.dao;

import static phoneshopping.db.JdbcUtil.close;
import static phoneshopping.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import phoneshopping.vo.Order;
import phoneshopping.vo.Phone;
import phoneshopping.vo.Review;

//데이터베이스 연동처리하는 Data Access Object기능을 수행하는 클래스
public class PhoneDAO {

	Connection con;
	
	private static PhoneDAO phoneDAO;
	
	private PhoneDAO() {}
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	//싱글톤 패턴 으로 메모리 효율을 높이기 위해 사용
	public static PhoneDAO getInstance() {
		if(phoneDAO == null) {
			phoneDAO = new PhoneDAO();
		}
		
		return phoneDAO;
	}//
	
	//핸드폰 목록을 처리하는 메서드
	public ArrayList<Phone> selectphoneList(){
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//핸드폰 목록을 처리하기 위한 ArrayList
		ArrayList<Phone> phoneList = null;
		String sql = "select * from phone order by id desc";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {//조회한 후에 가져올 데이터 존재여부 체크
				phoneList = new ArrayList<Phone>();
				
				//반복문을 통해 phone테이블의 핸드폰 내역을 ArrayList에 대입
				do {
					phoneList.add(new Phone(
						rs.getInt("id"),
						rs.getString("kind"),
						rs.getString("name"),
						rs.getString("color"),
						rs.getString("size"),
						rs.getString("camera"),
						rs.getString("image"),
						rs.getInt("price"),
						rs.getString("stockqty"),
						rs.getString("content"),
						rs.getInt("readcount"),
						rs.getDate("regdate"),
						rs.getDate("updatedate")));
				}while(rs.next());
				
			}
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return phoneList;
	}//
	
	//특정 아이디에 대한 핸드폰 내역을 가져오는 메서드
	public Phone selectphone(int id) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Phone phone = null;
		
		String sql = "select * from phone where id = ?";
		
		try {
			
			pstmt = con.prepareStatement(sql);
			//매개변수로 특정 핸드폰 데이터 검색
			pstmt.setInt(1,id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //특정 아이디에 대한 핸드폰 정보가 존재하면
				phone = new Phone(
						rs.getInt("id"),
						rs.getString("kind"),
						rs.getString("name"),
						rs.getString("color"),
						rs.getString("size"),
						rs.getString("camera"),
						rs.getString("image"),
						rs.getInt("price"),
						rs.getString("stockqty"),
						rs.getString("content"),
						rs.getInt("readcount"),
						rs.getDate("regdate"),
						rs.getDate("updatedate"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return phone;
	}//
	
	//조회수 증가 처리하는 메서드
	public int updateReadCount(int id) {
		
		PreparedStatement pstmt = null;
		int updateCount = 0;
		String sql = "update phone" +
		             "   set readcount = readcount + 1" + 
				     " where id = ?";
		
		try {
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1,id);
			
			updateCount = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return updateCount;
	}//
	
	//신규 핸드폰 정보 등록처리하는 메서드
	public int insertphone(Phone phone) {
		PreparedStatement pstmt = null;
		int insertCount = 0;
		String sql = "insert into phone values((SELECT IFNULL(MAX(id) + 1, 1) from phone p),?,?,?,?,?,?,?,?,?,?,now(),null)";
		             
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1,phone.getKind());
			pstmt.setString(2,phone.getName());
			pstmt.setString(3,phone.getColor());
			pstmt.setString(4,phone.getSize());
			pstmt.setString(5,phone.getCamera());
			pstmt.setString(6, phone.getImage());
			pstmt.setInt(7,phone.getPrice());
			pstmt.setString(8,phone.getStockqty());
			pstmt.setString(9,phone.getContent());
			pstmt.setInt(10,phone.getReadcount());
			
			insertCount = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return insertCount;
	}
	//삭제처리
	public int removePhone(int id) {
		PreparedStatement pstmt=null;
		String sql="delete from phone where id=?";
		int removeCount=0;
		try {
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, id);
			
			removeCount=pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return removeCount;
	}
	
	public int updatePhone(Phone phone) {
		PreparedStatement pstmt=null;
		String sql="update phone set "
				+ "		kind=?,"
				+ "		name=?,"
				+ "		color=?,"
				+ "		size=?,"
				+ "		camera=?,"
				+ "		image=?,"
				+ "		price=?,"
				+ "		stockqty=?,"
				+ "		content=?,"
				+ "		updatedate=now() "
				+ "		where id=?";
		int updateCount=0;
		try {
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, phone.getKind());
			pstmt.setString(2, phone.getName());
			pstmt.setString(3, phone.getColor());
			pstmt.setString(4, phone.getSize());
			pstmt.setString(5, phone.getCamera());
			pstmt.setString(6, phone.getImage());
			pstmt.setInt(7, phone.getPrice());
			pstmt.setString(8, phone.getStockqty());
			pstmt.setString(9, phone.getContent());
			pstmt.setInt(10, phone.getId());
			
			updateCount=pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("수정에러:"+e.getMessage());
		}finally {
			close(pstmt);
		}
		return updateCount;
	}
	
	public Phone selectPhone(int id) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Phone phone=null;
		try {
			pstmt=con.prepareStatement("select*from phone where id=?");
			pstmt.setInt(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				phone=new Phone(rs.getInt("id"),
								rs.getString("kind"),
								rs.getString("name"),
								rs.getString("color"),
								rs.getString("size"),
								rs.getString("camera"),
								rs.getString("image"),
								rs.getInt("price"),
								rs.getString("stockqty"),
								rs.getString("content"),
								rs.getInt("readcount"),
								rs.getDate("regdate"),
								rs.getDate("updatedate"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		return phone;
	}
	
	public int orderPhone(Order order,int totalCnt) {
		PreparedStatement pstmt=null;
		int OrderSuccess=0;
		String sql="insert into orderphone values(null,?,?,?,?,?,?,?,?,?,?,?,now())";
			
		try {
			pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, order.getId());
				pstmt.setString(2, order.getUserid());
				pstmt.setString(3, order.getPhoneName());
				pstmt.setString(4, order.getName());
				pstmt.setString(5, order.getPostcd());
				pstmt.setString(6, order.getAddr1());
				pstmt.setString(7, order.getAddr2());
				pstmt.setInt(8, order.getPhone());
				pstmt.setString(9, order.getMemo());
				pstmt.setInt(10, order.getPrice());
				pstmt.setInt(11, order.getCnt());
				OrderSuccess=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return OrderSuccess;
	}
	
	public int cancelPhone(int id) {
		PreparedStatement pstmt=null;
		String sql="delete from orderphone where id=?";
		int cancelCount=0;
		try {
			pstmt=con.prepareStatement(sql);

			pstmt.setInt(1, id);

			cancelCount=pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return cancelCount;
	}
	
	public int reviewPhone(Review review) {
		int ReviewSuccess=0;
		
		PreparedStatement pstmt=null;
		String sql="insert into review values(null,?,?,?,?,now())";
		try {
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, review.getId());
			pstmt.setString(2, review.getUserid());
			pstmt.setString(3, review.getReview());
			pstmt.setString(4, review.getPhoneName());
			ReviewSuccess=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return ReviewSuccess;
	}
	
	
	public ArrayList<Phone> select(String findStr) {
		Connection con = getConnection();
		
		phoneDAO.setConnection(con);
		ArrayList<Phone> list = new ArrayList<Phone>();
		try {
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql = "SELECT * FROM phone where name LIKE ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%" + findStr + "%");
			rs= pstmt.executeQuery();
			while(rs.next()) {
				Phone vo = new Phone();
				vo.setId(rs.getInt("id"));
				vo.setKind(rs.getString("kind"));
				vo.setName(rs.getString("name"));
				vo.setPrice(rs.getInt("price"));
				vo.setImage(rs.getString("Image"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return list;
	}
	
	//재고 떨구기
	public int downPhone(Order order,int cnt) {
		PreparedStatement pstmt=null;
		int stockdown=0;
		String sql="update phone set stockqty=stockqty-? where id=? and stockqty>0";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cnt);
			pstmt.setInt(2, order.getId());
			stockdown=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return stockdown;
	}
	
	// 취소시 재고 올리기
	public int stockup(int id) {
		PreparedStatement pstmt=null;
		int stockCount=0;
		String sql="update phone set stockqty=stockqty+1 where id=?";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, id);
			stockCount=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return stockCount;
	}
	
	public int removeReview(int num) {
		PreparedStatement pstmt=null;
		String sql="delete from review where review_num=?";
		int removeCount=0;
		try {
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			removeCount=pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return removeCount;
	}
	
	public int updateReview(Review review,int num) {
		PreparedStatement pstmt=null;
		String sql="update review set review=? where review_num=?";
		int updateCount=0;
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getReview());
			pstmt.setInt(2, num);
			
			updateCount=pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("수정에러:"+e.getMessage());
		}finally {
			close(pstmt);
		}
		return updateCount;
	}
	
	
}