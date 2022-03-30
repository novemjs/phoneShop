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
		
		//강아지 장바구니 목록을 가져와서 ArrayList에 대입
		ArrayList<Cart> cartList = 
				 phoneCartListService.getCartList(request);
		
		int totalMoney = 0;
		int money = 0;
		
		for(int i=0;i<cartList.size();i++) {
			//강아지별 소계
			money = cartList.get(i).getPrice()*cartList.get(i).getQty();
			//총계
			totalMoney += money;
		}
		
		//총계 & 장바구니 내역을 속성으로 지정
		request.setAttribute("totalMoney",totalMoney);
		request.setAttribute("cartList",cartList);
		
		ActionForward forward = 
				new ActionForward("phoneCartList.jsp",false);
		
		return forward;
		
	}

}