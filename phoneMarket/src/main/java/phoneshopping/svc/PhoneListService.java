package phoneshopping.svc;

import static phoneshopping.db.JdbcUtil.close;
import static phoneshopping.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import phoneshopping.dao.PhoneDAO;
import phoneshopping.vo.Phone;

//강아지 목록 처리하는 서비스
public class PhoneListService {

	//강아지 목록을 리턴하는 메서드
	public ArrayList<Phone> getphoneList(){
		
		PhoneDAO phoneDAO = PhoneDAO.getInstance();
		
		Connection con = getConnection();
		
		phoneDAO.setConnection(con);
		
		ArrayList<Phone> phoneList = phoneDAO.selectphoneList();
		
		close(con);
		
		return phoneList;
		
	}
}