package phoneMarket.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneMarket.svc.BoardReplyProService;
import phoneMarket.vo.ActionForward;
import phoneMarket.vo.BoardBean;
//특정 게시물에 대한 댓글 입력처리
public class BoardReplyProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=null;
		String nowPage=request.getParameter("page");
		BoardBean article=new BoardBean();
		article.setBoard_num(Integer.parseInt(request.getParameter("board_num")));
		article.setBoard_name(request.getParameter("board_name"));
		article.setBoard_pass(request.getParameter("board_pass"));
		article.setBoard_subject(request.getParameter("board_subject"));
		article.setBoard_content(request.getParameter("board_content"));
		//댓글 번호
		article.setBoard_re_ref(Integer.parseInt(request.getParameter("board_re_ref")));
		//댓글 레벨
		article.setBoard_re_lev(Integer.parseInt(request.getParameter("board_re_lev")));
		//댓글 일련번호
		article.setBoard_re_seq(Integer.parseInt(request.getParameter("board_re_seq")));
		
		BoardReplyProService boardReplyProService=new BoardReplyProService();
		
		//댓글 입력 처리
		boolean isReplySuccess=boardReplyProService.replyArticle(article);
		
		if(isReplySuccess) {//댓글처리 성공true
			forward=new ActionForward();
			forward.setRedirect(true);
			//게시물 리스트로 이동
			forward.setPath("boardList.bo?page="+nowPage);
		}else {//댓글 등록 실패 false
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('답장실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return forward;
	}

}
