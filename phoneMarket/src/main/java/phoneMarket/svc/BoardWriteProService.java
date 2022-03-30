package phoneMarket.svc;

import static phoneMarket.db.JdbcUtil.*;

import java.sql.Connection;

import phoneMarket.dao.BoardDAO;
import phoneMarket.vo.BoardBean;

//신규 게시물 등록처리
public class BoardWriteProService {
	//신규 게시물 등록 메서드 선언
	public boolean registArticle(BoardBean boardBean) throws Exception{
		
		boolean isWriteSuccess=false;
		Connection con=getConnection();
		//getInstance() : 싱글톤 패턴
		BoardDAO boardDAO=BoardDAO.getInstance();
		//데이터베이스 연결
		boardDAO.setConnection(con);
	
		//insertArticle 메서드:게시물 등록
		int insertCount=boardDAO.insertArticle(boardBean);
		
		if(insertCount>0) { //정상적으로 게시물 등록처리
			commit(con);
			isWriteSuccess=true;
		}else {
			rollback(con);
		}
		close(con);
		return isWriteSuccess;
	}
}
