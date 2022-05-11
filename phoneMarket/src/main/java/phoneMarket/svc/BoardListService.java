package phoneMarket.svc;

import static phoneMarket.db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;
import phoneMarket.dao.BoardDAO;
import phoneMarket.vo.BoardBean;

//게시물 리스트를 출력하는 클래스
public class BoardListService {
	public int getListCount() throws Exception{
		int listCount=0;
		Connection con=getConnection();
		BoardDAO boardDAO=BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		//게시물 목록 리스트 수
		listCount=boardDAO.selectListCount();
		close(con);
		return listCount;
	}
	
	//특정 페이지에 대한 게시물 리스트 내역을 가져오는 메서드
	public ArrayList<BoardBean> getArticleList(int page,int limit) throws Exception{
		
		ArrayList<BoardBean> articleList=null;
		Connection con=getConnection();
		BoardDAO boardDAO=BoardDAO.getInstance();
		boardDAO.setConnection(con);
		//특정 페이지에 대한 게시물 리스트를 가져와서 ArrayList에 대입
		articleList=boardDAO.selectArticleList(page,limit);
		close(con);
		return articleList;
		
	}
}
