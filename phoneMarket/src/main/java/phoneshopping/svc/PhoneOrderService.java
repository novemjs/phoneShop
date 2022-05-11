package phoneshopping.svc;

import java.sql.Connection;

import static phoneshopping.db.JdbcUtil.*;

import phoneshopping.dao.PhoneDAO;
import phoneshopping.vo.Order;

public class PhoneOrderService {
	public boolean orderAmt(Order order,int totalCnt) {
		
		Connection con=getConnection();
		
		PhoneDAO phoneDAO=PhoneDAO.getInstance();
		
		boolean isOrderSuccess=false;
		
		phoneDAO.setConnection(con);
		
		int OrderSuccess=phoneDAO.orderPhone(order,totalCnt);
		
		if(OrderSuccess>0) {
			commit(con);
			isOrderSuccess=true;
		}else {
			rollback(con);
		}
		
		return isOrderSuccess;
	}
		
	
	public boolean down(Order order,int cnt) {
		Connection con=getConnection();
		
		PhoneDAO phoneDAO=PhoneDAO.getInstance();
		
		boolean stockdown=false;
		
		phoneDAO.setConnection(con);
		
		int downSuccess=phoneDAO.downPhone(order,cnt);
		
		if(downSuccess>0) {
			commit(con);
			stockdown=true;
		}else {
			rollback(con);
		}
		
		return stockdown;
		
	}
}
