package phoneshopping.svc;

import static phoneshopping.db.JdbcUtil.*;
import java.sql.Connection;

import phoneshopping.dao.PhoneDAO;


public class PhoneRemoveService {
	public boolean remove(int id) {
		Connection con=getConnection();
		
		PhoneDAO phoneDAO=PhoneDAO.getInstance();
		
		boolean isRemoveSuccess=false;
		
		phoneDAO.setConnection(con);
		
		int removeCount=phoneDAO.removePhone(id);
		
		if(removeCount>0) {
			commit(con);
			isRemoveSuccess=true;
		}else {
			rollback(con);
		}
		close(con);
		
		return isRemoveSuccess;
	}

}
