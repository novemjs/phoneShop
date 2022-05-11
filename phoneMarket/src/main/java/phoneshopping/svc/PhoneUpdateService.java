package phoneshopping.svc;

import static phoneshopping.db.JdbcUtil.close;
import static phoneshopping.db.JdbcUtil.commit;
import static phoneshopping.db.JdbcUtil.getConnection;
import static phoneshopping.db.JdbcUtil.rollback;

import java.sql.Connection;

import phoneshopping.dao.PhoneDAO;
import phoneshopping.vo.Phone;

public class PhoneUpdateService {
	public boolean update(Phone phone) {

		Connection con=getConnection();
		
		PhoneDAO phoneDAO=PhoneDAO.getInstance();
		
		boolean isUpdateSuccess=false;
		
		phoneDAO.setConnection(con);

		int updateCount=phoneDAO.updatePhone(phone);
		
		
		if(updateCount>0) {
			commit(con);
			isUpdateSuccess=true;
		}else {
			rollback(con);
		}
		close(con);
		
		return isUpdateSuccess;
	}
}
