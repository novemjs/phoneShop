package phoneMarket.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneMarket.svc.BoardDetailService;
import phoneMarket.vo.ActionForward;
import phoneMarket.vo.BoardBean;
//특정 게시물에 대한 댓글 입력 화면처리
public class BoardReplyFormAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=new ActionForward();
		String nowPage=request.getParameter("page");
		int board_num=Integer.parseInt(request.getParameter("board_num"));
		
		BoardDetailService boardDetailService=new BoardDetailService();
		
		BoardBean article=boardDetailService.getArticle(board_num);
		request.setAttribute("article",article);
		request.setAttribute("page", nowPage);
		forward.setPath("/board/qna_board_reply.jsp");
		return forward;
	}

}
