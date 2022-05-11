package phoneMarket.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneMarket.svc.BoardModifyProService;
import phoneMarket.vo.ActionForward;
import phoneMarket.vo.BoardBean;
//특정 게시물 수정처리
public class BoardModifyProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=null;
		//수정처리 확인을 위한 변수
		boolean isModifySuccess=false;
		//수정하려는 게시물 번호를 변수에 대입
		int board_num=Integer.parseInt(request.getParameter("board_num"));
		String nowPage=request.getParameter("page");
		
		System.out.println("페이지이지이지:"+nowPage);
		
		BoardBean article=new BoardBean();
		BoardModifyProService boardModifyProService=new BoardModifyProService();
		
		//특정 게시물 수정처리시 게시물 등록시 입력했던 비밀번호를 확인하여
		//비밀번호가 맞으면 true 아니면 false
		boolean isRightUser=boardModifyProService.isArticleWriter(board_num,request.getParameter("board_pass"));
		
		//false일때
		if(!isRightUser) {//비밀번호가 틀리면
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('수정할 권한이 없습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}else {
			
			article.setBoard_num(board_num);
			//게시물 제목
			article.setBoard_subject(request.getParameter("board_subject"));
			//게시물 내용
			article.setBoard_content(request.getParameter("board_content"));
			isModifySuccess=boardModifyProService.modifyArticle(article);
			
			//false
			if(!isModifySuccess) {//게시물 수정이 실패하면
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('수정 실패');");
				out.println("history.back();");
				out.println("</script>");
			}else {
				//정상적으로 수정처리가 되면 상세보기 화면으로 이동
				forward=new ActionForward();
				//http://localhost:8080/phoneMarket/boardDetail.bo?board_num=XX
				forward.setRedirect(true);
				forward.setPath("boardDetail.bo?board_num="+article.getBoard_num()+"&page="+nowPage);
			}
		}
		
		return forward;
	}
	
}
