package phoneshopping.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneCancelService;
import phoneshopping.vo.ActionForward;

public class PhoneCancelAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PhoneCancelService phoneCancelService=new PhoneCancelService();

		int id=Integer.parseInt(request.getParameter("id"));

		boolean isCancelSuccess=phoneCancelService.cancel(id);
		
		boolean stockup=phoneCancelService.stockup(id);

		ActionForward forward=null;

		if(isCancelSuccess&&stockup) {//성공

			forward = new ActionForward();

			forward.setRedirect(true);
			//핸드폰 목록 리스트로 이동
			forward.setPath("phoneList.phone");

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