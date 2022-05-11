package phoneshopping.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneRemoveService;
import phoneshopping.svc.ReviewRemoveService;
import phoneshopping.vo.ActionForward;

public class PhoneReviewDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ReviewRemoveService reviewRemoveService=new ReviewRemoveService();
		
		int num=Integer.parseInt(request.getParameter("num"));
		
		boolean isRemoveSuccess = reviewRemoveService.remove(num);
		
		ActionForward forward = null;
		
		if(isRemoveSuccess) {//성공
			
			forward = new ActionForward();
			
			forward.setRedirect(true);
			
			forward.setPath("http://localhost:8080/phoneMarket/member/mainMenu.jsp");
			
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
