package phoneMarket.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import phoneMarket.svc.BoardWriteProService;
import phoneMarket.vo.ActionForward;
import phoneMarket.vo.BoardBean;
//신규 게시물 등록 처리
public class BoardWriteProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward=null;
		BoardBean boardBean=null;
		String realFolder="";
		//String saveFolder="";
		int fileSize=5*1024*1024;//업로드 파일 크기:5M
		
		//ServletContext context=request.getServletContext();
		
		realFolder="D:\\jspStudy\\phoneMarket\\src\\main\\webapp\\boardUpload";
		//첨부파일 업로드 처리 선언
		MultipartRequest multi=new MultipartRequest(request,realFolder,fileSize,"utf-8",new DefaultFileRenamePolicy());
		
		//BoardBean 인스턴스 생성
		boardBean=new BoardBean();
		//입력화면에서 입력받은 값들을 BoardBean 클래스에 대입
		boardBean.setBoard_name(multi.getParameter("board_name"));
		boardBean.setBoard_pass(multi.getParameter("board_pass"));
		boardBean.setBoard_subject(multi.getParameter("board_subject"));
		boardBean.setBoard_content(multi.getParameter("board_content"));
		boardBean.setBoard_file(multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
		//신규 게시물 등록처리를 Service에서 처리
		BoardWriteProService boardWriteProService=new BoardWriteProService();
		boolean isWriteSuccess=boardWriteProService.registArticle(boardBean);
		
		if(!isWriteSuccess) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('등록실패')");
			out.println("history.back();");
			out.println("</script>");
		}else {//정상적으로 게시물 등록처리
			forward=new ActionForward();
			forward.setRedirect(true);
			//http://localhost:8080/boarinformation/boardList.bo
			forward.setPath("boardList.bo");
		}
		
		return forward;
	}
}
