package phoneMarket.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneMarket.action.Action;
import phoneMarket.action.AdminDeleteAction;
import phoneMarket.action.BoardDeleteProAction;
import phoneMarket.action.BoardDetailAction;
import phoneMarket.action.BoardListAction;
import phoneMarket.action.BoardModifyFormAction;
import phoneMarket.action.BoardModifyProAction;
import phoneMarket.action.BoardReplyFormAction;
import phoneMarket.action.BoardReplyProAction;
import phoneMarket.action.BoardWriteProAction;
import phoneMarket.vo.ActionForward;

@WebServlet("*.bo")
public class BoardFrontController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    protected void doProcess(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
    	request.setCharacterEncoding("utf-8");
    	
    	//프로젝트 명을 포함한 전체 url명
    	//http://localhost:8080/phoneMarket/boardList.bo
    	String RequestURI=request.getRequestURI();
    	
    	//url에서 프로젝트 명만 리턴(phoneMarket)
    	String contextPath=request.getContextPath();
 
    	//substring으로 phoneMarket까지 끊고 그이후~
    	//url에서 실제로 처리하는 주소만 리턴(/boardList.bo)
    	String command=RequestURI.substring(contextPath.length());
    	
    	ActionForward forward=null;
    	Action action=null;
    	
    	//게시판 신규 등록 화면 처리
    	if(command.equals("/boardWriteForm.bo")) {
    		forward=new ActionForward();
    		//게시판 등록 jsp로 이동
    		forward.setPath("/board/qna_board_write.jsp");
    	}
    	//게시물 등록 화면에서 등록버튼을 클릭하면 처리
    	else if(command.equals("/boardWritePro.bo")) {
    		action=new BoardWriteProAction();
    		try {
    			forward=action.execute(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	}
    	//게시물 리스트 url
    	else if(command.equals("/boardList.bo")) {
    		action=new BoardListAction();
    		try {
    			forward=action.execute(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	}
    	//게시물 상세보기 처리
    	else if(command.equals("/boardDetail.bo")) {
    		String nowPage=request.getParameter("page");
    		request.setAttribute("page",nowPage);
    		action=new BoardDetailAction();
    		try {
    			forward=action.execute(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	}
    	//게시물에 대한 댓글 입력 화면 처리
    	else if(command.equals("/boardReplyForm.bo")) {
    		action=new BoardReplyFormAction();
    		try {
    			forward=action.execute(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	}
    	//댓글을 실제로 입력 처리
    	else if(command.equals("/boardReplyPro.bo")) {
    		action=new BoardReplyProAction();
    		try {
    			forward=action.execute(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	}
    	//게시물 수정 화면 처리 url
    	else if(command.equals("/boardModifyForm.bo")) {
    		action=new BoardModifyFormAction();
    		try {
    			forward=action.execute(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	}
    	//게시물 수정 처리
    	else if(command.equals("/boardModifyPro.bo")) {
    		action=new BoardModifyProAction();
    		try {
    			forward=action.execute(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	}
    	//게시물 삭제 화면처리
    	else if(command.equals("/boardDeleteForm.bo")) {
    		//현재페이지 번호
    		String nowPage=request.getParameter("page");
    		
    		//삭제하려는 게시물 번호
    		int board_num=Integer.parseInt(request.getParameter("board_num"));
    		//scope 4개
    		//page:현재 page에서만 속성값이 유효
    		//request:서버가 응답처리해주기 전까지 속성값 유효
    		//session:같은 브라우저 혹은 로그아웃 전까지 속성값 유효
    		//application:톰캣 서버 restart 혹은 stop전까지 속성값 유효
    		request.setAttribute("page", nowPage);
    		request.setAttribute("board_num",board_num);
    		forward=new ActionForward();
    		forward.setPath("/board/qna_board_delete.jsp");
    	}
    	//게시물 삭제 처리
    	else if(command.equals("/boardDeletePro.bo")) {
    		action=new BoardDeleteProAction();
    		try {
    			forward=action.execute(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	//관리자모드에서 삭제
    	}else if(command.equals("/adminDelete.bo")) {
    		action=new AdminDeleteAction();
    		try {
    			forward=action.execute(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	}
    	
    	if(forward!=null) {
    		//강제로 다른 jsp로 이동(sendRedirect)
    		if(forward.isRedirect()) {
    			response.sendRedirect(forward.getPath());
    		}else {//dispatcher방식을 사용하여 다른 jsp로 이동
    			RequestDispatcher dispatcher=request.getRequestDispatcher(forward.getPath());
    			//주소는 원래 url주소가 표시되고 속성값들은 제어권이 넘어가면서 같이 전송되므로 사용가능하다
    			dispatcher.forward(request,response);
    		}
    	}
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
    
}
