package phoneshopping.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.ReviewModifyService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Review;

public class PhoneReviewModifyAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ReviewModifyService reviewModifyService=new ReviewModifyService();
		
		int num=Integer.parseInt(request.getParameter("num"));
		
		Review review=new Review(Integer.parseInt(request.getParameter("id")),
								request.getParameter("userId"),
								request.getParameter("reviewUpdate"),
								request.getParameter("phoneName"));
		
		boolean isUpdateSuccess=reviewModifyService.update(review,num);
		
		ActionForward forward = null;
		
		if(isUpdateSuccess) {//성공
			
			forward = new ActionForward();
			
			forward.setRedirect(true);
			//핸드폰 목록 리스트로 이동
			forward.setPath("phoneReview.jsp");
			
		}else { //수정 실패
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('수정 실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return forward;
	}

}
