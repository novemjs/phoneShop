package phoneshopping.svc;

import java.sql.Connection;

import static phoneshopping.db.JdbcUtil.*;

import phoneshopping.dao.PhoneDAO;
import phoneshopping.vo.Order;

public class PhoneOrderService {
	public boolean orderAmt(Order order) {
		
		Connection con=getConnection();
		
		PhoneDAO phoneDAO=PhoneDAO.getInstance();
		
		boolean isOrderSuccess=false;
		
		phoneDAO.setConnection(con);
		
		int OrderSuccess=phoneDAO.orderPhone(order);
		
		if(OrderSuccess>0) {
			commit(con);
			isOrderSuccess=true;
		}else {
			rollback(con);
		}
		
		return isOrderSuccess;
	}
		
}
