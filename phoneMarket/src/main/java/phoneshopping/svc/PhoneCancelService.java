package phoneshopping.svc;

import static phoneshopping.db.JdbcUtil.close;
import static phoneshopping.db.JdbcUtil.commit;
import static phoneshopping.db.JdbcUtil.getConnection;
import static phoneshopping.db.JdbcUtil.rollback;

import java.sql.Connection;

import phoneshopping.dao.PhoneDAO;

public class PhoneCancelService {
	public boolean cancel(int id) {

		Connection con=getConnection();

		PhoneDAO phoneDAO=PhoneDAO.getInstance();

		boolean isCancelSuccess=false;

		phoneDAO.setConnection(con);

		int cancelCount=phoneDAO.cancelPhone(id);

		if(cancelCount>0) {
			commit(con);
			isCancelSuccess=true;
		}else {
			rollback(con);
		}
		close(con);

		return isCancelSuccess;

	}
	
	public boolean stockup(int id) {
		Connection con=getConnection();

		PhoneDAO phoneDAO=PhoneDAO.getInstance();

		boolean stockup=false;

		phoneDAO.setConnection(con);
		
		int stockCount=phoneDAO.stockup(id);

		if(stockCount>0) {
			commit(con);
			stockup=true;
		}else {
			rollback(con);
		}
		close(con);

		return stockup;
	}
}
