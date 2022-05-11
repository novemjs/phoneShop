package phoneMarket.svc;

import static phoneMarket.db.JdbcUtil.close;
import static phoneMarket.db.JdbcUtil.commit;
import static phoneMarket.db.JdbcUtil.getConnection;
import static phoneMarket.db.JdbcUtil.rollback;

import java.sql.Connection;

import javax.servlet.http.HttpSession;

import phoneMarket.dao.BoardDAO;

public class BoardDeleteProService {
	//삭제시 비밀번호 체크 
	public boolean isArticleWriter(int board_num,String pass) throws Exception{
		
		boolean isArticleWriter=false;
		Connection con=getConnection();
		BoardDAO boardDAO=BoardDAO.getInstance();
		boardDAO.setConnection(con);
	
		isArticleWriter=boardDAO.isArticleBoardWriter(board_num,pass);
		close(con);
		return isArticleWriter;
	}
	
	public boolean removeArticle(int board_num) throws Exception{
		
		boolean isRemoveSuccess=false;
		Connection con=getConnection();
		BoardDAO boardDAO=BoardDAO.getInstance();
		boardDAO.setConnection(con);
		int deleteCount=boardDAO.deleteArticle(board_num);
		
		if(deleteCount>0) {
			commit(con);
			isRemoveSuccess=true;
		}else {
			rollback(con);
		}
		return isRemoveSuccess;
	}
}
