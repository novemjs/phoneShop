package phoneshopping.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import phoneshopping.svc.PhoneOrderService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Cart;
import phoneshopping.vo.Order;

public class PhoneOrderAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session=request.getSession();
		
		PhoneOrderService phoneOrderService=new PhoneOrderService();
		int phoneId=Integer.parseInt(request.getParameter("phoneId"));
		
		int totalCnt=Integer.parseInt(request.getParameter("totalCnt"));
		
		int cnt=Integer.parseInt(request.getParameter("cnt"));
		
		boolean isOrderSuccess=false;
		boolean stockdown=false;
		ArrayList<Cart> orderList=(ArrayList<Cart>) session.getAttribute("cartList");
		for(int i=0;i<orderList.size();i++) {
			Order order=new Order(orderList.get(i).getId(),
					request.getParameter("userId"),
					orderList.get(i).getName(),
					request.getParameter("name"),
					request.getParameter("postcd"),
					request.getParameter("addr1"),
					request.getParameter("addr2"),
					Integer.parseInt(request.getParameter("phone")),
					request.getParameter("memo"),
					orderList.get(i).getPrice(),
					cnt);
			isOrderSuccess=phoneOrderService.orderAmt(order,totalCnt);
			stockdown=phoneOrderService.down(order,cnt);
		}
		
		
		
		ActionForward forward=null;
		
		if(isOrderSuccess&&stockdown) {
			forward = new ActionForward();
			
			session.removeAttribute("cartList");
			
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
