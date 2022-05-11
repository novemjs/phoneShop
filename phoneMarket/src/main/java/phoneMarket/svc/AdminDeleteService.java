package phoneMarket.svc;

import static phoneshopping.db.JdbcUtil.close;
import static phoneshopping.db.JdbcUtil.commit;
import static phoneshopping.db.JdbcUtil.getConnection;
import static phoneshopping.db.JdbcUtil.rollback;

import java.sql.Connection;

import phoneMarket.dao.BoardDAO;

public class AdminDeleteService {
	public boolean remove(int num) {
		Connection con=getConnection();
		
		BoardDAO boardDAO=BoardDAO.getInstance();
		
		boolean isRemoveSuccess=false;
		
		boardDAO.setConnection(con);
		
		int removeCount=boardDAO.removeAdmin(num);
		
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
