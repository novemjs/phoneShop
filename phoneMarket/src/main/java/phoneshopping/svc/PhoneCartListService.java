package phoneshopping.svc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import phoneshopping.vo.Cart;

public class PhoneCartListService {

	public ArrayList<Cart> getCartList(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		
		//장바구니 내역을 가지고 있는 세션 속성값을 리턴받아
		//ArrayList에 대입후 리턴처리
		ArrayList<Cart> cartList = (ArrayList<Cart>)session.getAttribute("cartList");
		
		return cartList;
		
	}
}

