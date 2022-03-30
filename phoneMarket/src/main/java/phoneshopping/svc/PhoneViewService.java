package phoneshopping.svc;

import static phoneshopping.db.JdbcUtil.close;
import static phoneshopping.db.JdbcUtil.commit;
import static phoneshopping.db.JdbcUtil.getConnection;
import static phoneshopping.db.JdbcUtil.rollback;

import java.sql.Connection;

import phoneshopping.dao.PhoneDAO;
import phoneshopping.vo.Phone;

//특정 아이디 번호에 대한 상세보기
public class PhoneViewService {

	public Phone getphoneView(int id){
		PhoneDAO phoneDAO = PhoneDAO.getInstance();
		Connection con = getConnection();
		phoneDAO.setConnection(con);
		
		//상세보기를 하면 조회수 증가
		int updateCount = phoneDAO.updateReadCount(id);
		
		if(updateCount > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		//특정 강아지 내역을 리턴하여 변수에 대입
		Phone phone = phoneDAO.selectphone(id);
		
		close(con);
		
		return phone;
		
		
	}
}
