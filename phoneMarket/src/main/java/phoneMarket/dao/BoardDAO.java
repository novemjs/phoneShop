package phoneMarket.dao;

import static phoneMarket.db.JdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import phoneMarket.vo.BoardBean;

//데이터베이스 연동 처리 하는 클래스
public class BoardDAO {
	DataSource ds;
	Connection con;
	private static BoardDAO boardDAO;
	
	//기본 생성자
	private BoardDAO() {}
	
	//싱글톤 패턴으로 데이터베이스 연결과 같은 것은 매번 new연산자를 사용하여
	//인스턴스를 생성하는 것이 아니라 최초 한번만 생성하고 이후부터는 재사용하는 개념으로 static으로
	//선언하면 메서드 영역에 발생
	public static BoardDAO getInstance() {
		if(boardDAO==null) {
			boardDAO=new BoardDAO();
		}
		return boardDAO;
	}
	
	//데이터베이스 연결 정보
	public void setConnection(Connection con) {
		this.con=con;
	}
	
	//게시물 총건수를 구하는 메서드
	public int selectListCount() {
		int listCount=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			pstmt=con.prepareStatement("select count(*) as rowCount from board");
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				listCount=rs.getInt("rowCount");
			}
		}catch(Exception ex) {
			System.out.println("getListCount 에러:"+ex);
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	//특정 페이지에 대한 게시물 내역을 리턴하는 메서드
	public ArrayList<BoardBean> selectArticleList(int page,int limit){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String board_list_sql="select*from board order by board_re_ref desc,board_re_seq asc limit ?,10";
		
		//게시물을 대입하기 위한 ArrayList선언
		ArrayList<BoardBean> articleList=new ArrayList<>();
		BoardBean board=null;
		int startrow=(page-1)*10; //읽기 시작할 row번호
		
		try {
			pstmt=con.prepareStatement(board_list_sql);
			pstmt.setInt(1, startrow);
			rs=pstmt.executeQuery();
			
			//게시물을 반복문을 통해 BoardBean 형태의 ArrayList에 대입
			while(rs.next()) {
				board=new BoardBean();
				board.setBoard_num(rs.getInt("board_num"));
				board.setBoard_name(rs.getString("board_name"));
				board.setBoard_subject(rs.getString("board_subject"));
				board.setBoard_content(rs.getString("board_content"));
				board.setBoard_file(rs.getString("board_file"));
				board.setBoard_re_ref(rs.getInt("board_re_ref"));
				board.setBoard_re_lev(rs.getInt("board_re_lev"));
				board.setBoard_re_seq(rs.getInt("board_re_seq"));
				board.setBoard_readcount(rs.getInt("board_readcount"));
				board.setBoard_date(rs.getDate("board_date"));
				articleList.add(board);
			}
		}catch(Exception ex) {
			System.out.println("getBoardList 에러:"+ex);
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return articleList;
	}
	
	//특정 게시물 내역을 리턴하는 메서드
	public BoardBean selectArticle(int board_num) {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardBean boardBean=null;
		
		try {
			pstmt=con.prepareStatement("select*from board where board_num=?");
			pstmt.setInt(1, board_num);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				boardBean=new BoardBean();
				boardBean.setBoard_num(rs.getInt("board_num"));
				boardBean.setBoard_name(rs.getString("board_name"));
				boardBean.setBoard_subject(rs.getString("board_subject"));
				boardBean.setBoard_content(rs.getString("board_content"));
				boardBean.setBoard_file(rs.getString("board_file"));
				boardBean.setBoard_re_ref(rs.getInt("board_re_ref"));
				boardBean.setBoard_re_lev(rs.getInt("board_re_lev"));
				boardBean.setBoard_re_seq(rs.getInt("board_re_seq"));
				boardBean.setBoard_readcount(rs.getInt("board_readcount"));
				boardBean.setBoard_date(rs.getDate("board_date"));
			}
		}catch(Exception ex) {
			System.out.println("getDetail 에러:"+ex);
		}finally {
			close(rs);
			close(pstmt);
		}
		return boardBean;
	}
	
	//신규 게시물 추가 처리
	public int insertArticle(BoardBean article) {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int num=0;
		String sql="";
		int insertCount=0;
		
		try {
			//마지막 게시물 번호를 받아서 num에 +1을 더하면 신규 게시물번호가 되고 없으면 num=1이된다.
			pstmt=con.prepareStatement("select max(board_num) from board");
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				num=rs.getInt(1)+1;
			}else {
				num=1;
			}
			//now():mysql 서버시간
			//sysdate:오라클 서버시간
			sql="insert into board values(?,?,?,?,?,?,?,?,?,?,now())";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, article.getBoard_name());
			pstmt.setString(3, article.getBoard_pass());
			pstmt.setString(4, article.getBoard_subject());
			pstmt.setString(5, article.getBoard_content());
			pstmt.setString(6, article.getBoard_file());
			//댓글 처리 관련 필드 초기값 지정
			pstmt.setInt(7, num);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			//조회수 초기값 0로 지정
			pstmt.setInt(10, 0);
			
			insertCount=pstmt.executeUpdate();
		}catch(Exception ex) {
			System.out.println("boardInsert 에러:"+ex);
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}
	
	//신규 댓글 입력 처리
	public int insertReplyArticle(BoardBean article) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String board_max_sql="select max(board_num) from board";
		String sql="";
		int num=0;
		int insertCount=0;
		int re_ref=article.getBoard_re_ref();
		int re_lev=article.getBoard_re_lev();
		int re_seq=article.getBoard_re_seq();
		
		try {
			pstmt=con.prepareStatement(board_max_sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1)+1;
			}else {
				num=1;
			}
			//특정 게시물에 대한 댓글 추가시 신규 댓글을 먼저 표시하기
			//위해 기존 댓글의 댓글 순번을 1씩 증가시켜 하단에 표시하게 한다.
			sql="update board set board_re_seq=board_re_seq+1 where board_re_ref=? and board_re_seq>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			pstmt.setInt(2, re_seq);
			int updateCount=pstmt.executeUpdate();
			
			if(updateCount>0) {
				commit(con);
			}
			
			re_seq=re_seq+1;
			re_lev=re_lev+1;
			sql="insert into board(board_num,board_name,board_pass,board_subject,";
			sql+="board_content,board_file,board_re_ref,board_re_lev,board_re_seq,";
			sql+="board_readcount,board_date) values(?,?,?,?,?,?,?,?,?,?,now())";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, article.getBoard_name());
			pstmt.setString(3, article.getBoard_pass());
			pstmt.setString(4, article.getBoard_subject());
			pstmt.setString(5, article.getBoard_content());
			pstmt.setString(6, ""); //댓글 입력시 첨부파일은 처리안함
			pstmt.setInt(7, re_ref);
			pstmt.setInt(8, re_lev);
			pstmt.setInt(9, re_seq);
			pstmt.setInt(10, 0);//조회수 0으로 초기화
			
			insertCount=pstmt.executeUpdate();
		}catch(SQLException ex) {
			System.out.println("boardReply에러: "+ex);
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}
	
	//글 수정
	public int updateArticle(BoardBean article) {
		int updateCount=0;
		PreparedStatement pstmt=null;
		String sql="update board set board_subject=?,board_content=? where board_num=?";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, article.getBoard_subject());
			pstmt.setString(2, article.getBoard_content());
			pstmt.setInt(3, article.getBoard_num());
			updateCount=pstmt.executeUpdate();
		}catch(Exception ex) {
			System.out.println("boardModify 에러: "+ex);
		}finally {
			close(pstmt);
		}
		
		return updateCount;
	}
	
	//글 삭제
	public int deleteArticle(int board_num) {
		PreparedStatement pstmt=null;
		String board_delete_sql="delete from board where board_num=?";
		int deleteCount=0;
		
		try {
			pstmt=con.prepareStatement(board_delete_sql);
			pstmt.setInt(1, board_num);
			deleteCount=pstmt.executeUpdate();
		}catch(Exception ex) {
			System.out.println("boardDelete 에러: "+ex);
		}finally {
			close(pstmt);
		}
		
		return deleteCount;
		
	}
	
	//조회수 업데이트
	public int updateReadCount(int board_num) {
		PreparedStatement pstmt=null;
		int updateCount=0;
		String sql="update board set board_readcount="+
				" board_readcount+1 where board_num= "+board_num;
		
		try {
			pstmt=con.prepareStatement(sql);
			updateCount=pstmt.executeUpdate();
		}catch(SQLException ex) {
			System.out.println("setReadCountUpdate 에러: "+ex);
		}finally {
			close(pstmt);
		}
		
		return updateCount;
	}
	
	//글쓴이인지 확인
	public boolean isArticleBoardWriter(int board_num,String pass) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String board_sql="select*from board where board_num=?";
		boolean isWriter=false;
		
		try {
			pstmt=con.prepareStatement(board_sql);
			pstmt.setInt(1, board_num);
			rs=pstmt.executeQuery();
			rs.next();
			
			//게시물 등록시 입력한 비밀번호가 맞는지 체크
			if(pass.equals(rs.getString("board_pass"))) {
				isWriter=true;
			}
		}catch(SQLException ex) {
			System.out.println("isBoardWriter 에러: "+ex);
		}finally {
			close(pstmt);
		}
		return isWriter;
	}
	//관리자 모드 삭제
	public int removeAdmin(int num) {
		int removeCount=0;
		PreparedStatement pstmt=null;
		String sql="delete from board where board_num=?";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			removeCount=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return removeCount;
	}
}
