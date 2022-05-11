package phoneshopping.svc;

import static phoneshopping.db.JdbcUtil.commit;
import static phoneshopping.db.JdbcUtil.getConnection;
import static phoneshopping.db.JdbcUtil.rollback;

import java.sql.Connection;

import phoneshopping.dao.PhoneDAO;
import phoneshopping.vo.Review;

public class PhoneReviewService {
	public boolean createReview(Review review) {

		Connection con=getConnection();
		
		PhoneDAO phoneDAO=PhoneDAO.getInstance();
		
		boolean isReviewSuccess=false;
		
		phoneDAO.setConnection(con);
		
		int ReviewSuccess=phoneDAO.reviewPhone(review);
		
		if(ReviewSuccess>0) {
			commit(con);
			isReviewSuccess=true;
		}else {
			rollback(con);
		}
		
		return isReviewSuccess;
	}
}
