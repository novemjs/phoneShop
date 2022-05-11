package phoneshopping.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneCartListService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Cart;

//장바구니 목록 처리
public class PhoneCartListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PhoneCartListService phoneCartListService 
		                = new PhoneCartListService();
		
		//핸드폰 장바구니 목록을 가져와서 ArrayList에 대입
		ArrayList<Cart> cartList = 
				 phoneCartListService.getCartList(request);
		ActionForward forward = null;
		
		try {
			
			if(cartList == null ) {
				
				request.setAttribute("cartList", cartList);
				forward = new ActionForward("nullCartList.jsp", false);
				
			} else {
				
				int totalMoney = 0;
				int money = 0;
				
				for(int i=0;i<cartList.size();i++) {
					money = cartList.get(i).getPrice()*cartList.get(i).getQty();
					totalMoney += money;
				}
				
				request.setAttribute("totalMoney", totalMoney);
				request.setAttribute("cartList", cartList);
				forward = new ActionForward("phoneCartList.jsp", false);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return forward;
	}

}