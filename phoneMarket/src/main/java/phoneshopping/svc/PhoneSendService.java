package phoneshopping.svc;

import static phoneshopping.db.JdbcUtil.commit;
import static phoneshopping.db.JdbcUtil.getConnection;
import static phoneshopping.db.JdbcUtil.rollback;

import java.sql.Connection;

import phoneshopping.dao.PhoneDAO;

public class PhoneSendService {
	public boolean send(int ordersnt) {
		Connection con=getConnection();
		
		PhoneDAO phoneDAO=PhoneDAO.getInstance();
		
		boolean isSend=false;
		
		phoneDAO.setConnection(con);
		
		int sendSuccess=phoneDAO.sendIt(ordersnt);
		
		if(sendSuccess>0) {
			commit(con);
			isSend=true;
		}else {
			rollback(con);
		}
		
		return isSend;
	}
}
