package phoneshopping.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneReviewService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Review;

public class PhoneReviewAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PhoneReviewService phoneReviewService=new PhoneReviewService();
		int id=Integer.parseInt(request.getParameter("id"));
		Review review=new Review(id,request.getParameter("userId"),request.getParameter("review"),request.getParameter("phoneName"));
		
		boolean isReviewSuccess=phoneReviewService.createReview(review);
		
		ActionForward forward=null;
		
		if(isReviewSuccess) {
			forward = new ActionForward();
			
			forward.setRedirect(true);
			
			forward.setPath("phoneView.phone?id="+id);
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('리뷰 성공')");
			out.println("</script>");
						
			
		}else { //결제 실패
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('리뷰 실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return forward;
	}

}
