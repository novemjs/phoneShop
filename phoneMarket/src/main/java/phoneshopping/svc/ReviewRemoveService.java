package phoneshopping.svc;

import static phoneshopping.db.JdbcUtil.close;
import static phoneshopping.db.JdbcUtil.commit;
import static phoneshopping.db.JdbcUtil.getConnection;
import static phoneshopping.db.JdbcUtil.rollback;

import java.sql.Connection;

import phoneshopping.dao.PhoneDAO;

public class ReviewRemoveService {
	public boolean remove(int num) {
		Connection con=getConnection();
		
		PhoneDAO phoneDAO=PhoneDAO.getInstance();
		
		boolean isRemoveSuccess=false;
		
		phoneDAO.setConnection(con);
		
		int removeCount=phoneDAO.removeReview(num);
		
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
