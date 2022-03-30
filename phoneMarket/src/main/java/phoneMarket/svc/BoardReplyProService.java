package phoneMarket.svc;

import static phoneMarket.db.JdbcUtil.close;
import static phoneMarket.db.JdbcUtil.commit;
import static phoneMarket.db.JdbcUtil.getConnection;
import static phoneMarket.db.JdbcUtil.rollback;

import java.sql.Connection;

import phoneMarket.dao.BoardDAO;
import phoneMarket.vo.BoardBean;

//특정 게시물 댓글 입력 처리
public class BoardReplyProService {
	
	public boolean replyArticle(BoardBean article) throws Exception{
		
		boolean isReplySuccess=false;
		int insertCount=0;
		Connection con=getConnection();
		BoardDAO boardDAO=BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		//댓글 입력 처리
		insertCount=boardDAO.insertReplyArticle(article);
		
		if(insertCount>0) {
			commit(con);
			isReplySuccess=true;
		}else {
			rollback(con);
		}
		close(con);
		return isReplySuccess;
	}
}
