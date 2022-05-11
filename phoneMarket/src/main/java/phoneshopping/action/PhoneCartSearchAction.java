package phoneshopping.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneCartSearchService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Cart;

public class PhoneCartSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PhoneCartSearchService phoneCartSearchService 
							= new PhoneCartSearchService();
		
		//장바구니 내역중 시작금액 종료금액 사이의 내역을 보여준다.
		int startMoney = Integer.parseInt(request.getParameter("startMoney"));
		int endMoney = Integer.parseInt(request.getParameter("endMoney"));
		
		ArrayList<Cart> cartList = phoneCartSearchService.getCartSearchList(startMoney,endMoney,request);
		
		request.setAttribute("cartList",cartList);
		request.setAttribute("startMoney",startMoney);
		request.setAttribute("endMoney",endMoney);
		
		int totalMoney = 0;
		int money = 0;
		
		for(int i=0;i<cartList.size();i++) {
			//핸드폰별 소계
			money = cartList.get(i).getPrice()*cartList.get(i).getQty();
			//총계
			totalMoney += money;
		}
		
		request.setAttribute("totalMoney",totalMoney);
		
		ActionForward forward = 
				new ActionForward("phoneCartList.jsp",false);
		
		return forward;
		
	}

}