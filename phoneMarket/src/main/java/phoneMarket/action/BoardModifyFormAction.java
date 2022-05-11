package phoneMarket.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneMarket.svc.BoardDetailService;
import phoneMarket.vo.ActionForward;
import phoneMarket.vo.BoardBean;
//특정 게시물 수정 화면 처리
public class BoardModifyFormAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=new ActionForward();
		
		//특정 게시물 번호
		int board_num=Integer.parseInt(request.getParameter("board_num"));
		
		String page=request.getParameter("page");
		
		BoardDetailService boardDetailService=new BoardDetailService();
		BoardBean article=boardDetailService.getArticle(board_num);
		
		request.setAttribute("article", article);
		request.setAttribute("page", page);
		//특정 게시물 수정 화면 jsp로 이동
		forward.setPath("/board/qna_board_modify.jsp");
		return forward;
	}
	
}
