package phoneshopping.svc;

import static phoneshopping.db.JdbcUtil.close;
import static phoneshopping.db.JdbcUtil.commit;
import static phoneshopping.db.JdbcUtil.getConnection;
import static phoneshopping.db.JdbcUtil.rollback;

import java.sql.Connection;

import phoneshopping.dao.PhoneDAO;
import phoneshopping.vo.Phone;

public class PhoneRegistService {

	//강아지 신규 등록 처리 메서드
	public boolean registphone(Phone phone) {
				
		Connection con = getConnection();
		
		PhoneDAO phoneDAO = PhoneDAO.getInstance();
		
		boolean isRegistSuccess = false;
		
		phoneDAO.setConnection(con);

		//phoneDAO 클래스의 insertphone 메서드에서 신규 등록 처리
		int insertCount = phoneDAO.insertphone(phone);
		
		if(insertCount > 0) {
			commit(con);
			isRegistSuccess = true;
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isRegistSuccess;
	
	}
}