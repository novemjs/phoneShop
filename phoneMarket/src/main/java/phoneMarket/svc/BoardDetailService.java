package phoneMarket.svc;

import static phoneMarket.db.JdbcUtil.*;
import phoneMarket.dao.BoardDAO;
import java.sql.Connection;

import phoneMarket.vo.BoardBean;

public class BoardDetailService {
	//특정 게시물 번호에 대한 게시물 내역을 가져오는 메서드
	public BoardBean getArticle(int board_num) throws Exception{
		
		BoardBean article=null;
		Connection con=getConnection();
		BoardDAO boardDAO=BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		//상세보기 클릭을 하면 조회수 1증가
		int updateCount=boardDAO.updateReadCount(board_num);
		
		if(updateCount>0) {
			commit(con);
		}else {
			rollback(con);
		}
		//특정 게시물 번호에 대한 게시물 내역을 가져와서 
		//BoardBean 형태의 변수에 대입
		article=boardDAO.selectArticle(board_num);
		close(con);
		return article;
	}
}
