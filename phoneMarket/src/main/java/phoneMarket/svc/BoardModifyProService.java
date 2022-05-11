package phoneMarket.svc;

import static phoneMarket.db.JdbcUtil.*;
import java.sql.Connection;

import phoneMarket.dao.BoardDAO;
import phoneMarket.vo.BoardBean;
//특정 게시물 수정 처리
public class BoardModifyProService {
	//특정 게시물 수정시 입력당시의 비밀번호를 체크하는 메서드
	public boolean isArticleWriter(int board_num,String pass) throws Exception{
		boolean isArticleWriter=false;
		Connection con=getConnection();
		BoardDAO boardDAO=BoardDAO.getInstance();
		boardDAO.setConnection(con);
		isArticleWriter=boardDAO.isArticleBoardWriter(board_num,pass);
		close(con);
		return isArticleWriter;
	}
	
	public boolean modifyArticle(BoardBean article) throws Exception{
		
		boolean isModifySuccess=false;
		Connection con=getConnection();
		BoardDAO boardDAO=BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		//특정 게시물 수정 처리
		int updateCount=boardDAO.updateArticle(article);
		
		if(updateCount>0) {
			commit(con);
			isModifySuccess=true;
		}else {
			rollback(con);
		}
		return isModifySuccess;
	}
}
