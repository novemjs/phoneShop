package phoneMarket.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneMarket.svc.BoardDetailService;
import phoneMarket.vo.ActionForward;
import phoneMarket.vo.BoardBean;
//특정 게시물 상세보기
public class BoardDetailAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//특정 게시물 번호
		int board_num=Integer.parseInt(request.getParameter("board_num"));
		//상세보기 후 현재 페이지로 이동하기 위함
		String page=request.getParameter("page");
		System.out.println("페이지:"+page);
		BoardDetailService boardDetailService=new BoardDetailService();
		//특정 게시물 번호에 대한 내역을 getArticle() 메서드로 처리하여
		//BoardBean 형태의 참조변수에 대입한다.
		BoardBean article=boardDetailService.getArticle(board_num);
		ActionForward forward=new ActionForward();
		request.setAttribute("page", page);
		request.setAttribute("article", article);
		//특정게시물 상세보기 jsp로 이동한다.
		forward.setPath("/board/qna_board_view.jsp");
		return forward;
	}
	
}
