package phoneshopping.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import phoneshopping.svc.PhoneOrderService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Order;

public class PhoneOrderAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PhoneOrderService phoneOrderService=new PhoneOrderService();
		
		Order order=new Order(request.getParameter("id"),
							request.getParameter("phoneName"),
							request.getParameter("name"),
							request.getParameter("postcd"),
							request.getParameter("addr1"),
							request.getParameter("addr2"),
							Integer.parseInt(request.getParameter("phone")),
							request.getParameter("memo"),
							Integer.parseInt(request.getParameter("orderPrice")));
		
		
		boolean isOrderSuccess=phoneOrderService.orderAmt(order);
		
		ActionForward forward=null;
		
		if(isOrderSuccess) {
			forward = new ActionForward();
			
			forward.setRedirect(true);
			//핸드폰 판매목록 리스트로 이동
			forward.setPath("phonePurchaseList.jsp");
			
			
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
