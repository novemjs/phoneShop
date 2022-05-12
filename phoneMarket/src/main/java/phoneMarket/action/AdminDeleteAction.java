package phoneMarket.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneMarket.svc.AdminDeleteService;
import phoneMarket.vo.ActionForward;

public class AdminDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int numb=Integer.parseInt(request.getParameter("numb"));
		System.out.println("번호야 넘어와라"+numb);

		AdminDeleteService adminDeleteService=new AdminDeleteService();
		
		boolean isRemoveSuccess = adminDeleteService.remove(numb);
		
		ActionForward forward = null;
		
		if(isRemoveSuccess) {//성공
			
			forward = new ActionForward();
			
			forward.setRedirect(true);
			forward.setPath("http://localhost:8080/phoneMarket/phone/adminBoard.jsp");
			
		}else { //삭제 실패
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('삭제 실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return forward;
	}

}
