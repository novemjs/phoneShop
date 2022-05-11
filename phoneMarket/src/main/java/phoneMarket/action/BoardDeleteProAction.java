package phoneMarket.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import phoneMarket.svc.BoardDeleteProService;
import phoneMarket.vo.ActionForward;

public class BoardDeleteProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward=null;
		//삭제 하려는 게시물 번호,현재페이지 번호를 변수에 대입
		int board_num=Integer.parseInt(request.getParameter("board_num"));
		String nowPage=request.getParameter("page");
		System.out.println("페이지이지이지이"+nowPage);
		BoardDeleteProService boardDeleteProService=new BoardDeleteProService();
		//비밀번호 확인 맞으면 true or 틀리면 false
		boolean isArticleWriter=boardDeleteProService.isArticleWriter(board_num,request.getParameter("board_pass"));

		
		if(!isArticleWriter) {//비밀번호 틀리면
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('삭제할 권한이 없습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}else {
			//특정 게시물을 삭제 처리
			boolean isDeleteSuccess=boardDeleteProService.removeArticle(board_num);
			
			if(!isDeleteSuccess) {//false 삭제실패
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('삭제실패');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}else {
				//정상적으로 삭제처리가 되면 삭제전 페이지로 이동
				forward=new ActionForward();
				forward.setRedirect(true);
				//http://localhost:8080/boardinformation/boardList.bo?page=XX
				forward.setPath("boardList.bo?page="+nowPage);
			}
		}
		return forward;
	}

}
