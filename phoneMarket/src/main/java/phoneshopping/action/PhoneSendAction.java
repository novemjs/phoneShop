package phoneshopping.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneSendService;
import phoneshopping.vo.ActionForward;

public class PhoneSendAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PhoneSendService phoneSendService=new PhoneSendService();
		
		int ordersnt=Integer.parseInt(request.getParameter("ordersnt"));
		
		boolean isSend=false;
		isSend=phoneSendService.send(ordersnt);
		ActionForward forward=null;
		
		if(isSend) {
			forward = new ActionForward();
			
			forward.setRedirect(true);
			//핸드폰 판매목록 리스트로 이동
			forward.setPath("adminPhoneList.jsp");
			
			
		}else { //결제 실패
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('결제 실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return forward;
	}

}
