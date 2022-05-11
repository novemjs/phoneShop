package phoneshopping.svc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import phoneshopping.vo.Cart;

//장바구니에 같은 품종을 선택하면 수량만 감소 시켜준다.
public class PhoneCartQtyDownService {

	public void downCartQty(String name,HttpServletRequest request) {
		HttpSession session = request.getSession();
		ArrayList<Cart> cartList = (ArrayList<Cart>)session.getAttribute("cartList");
		
		for(int i=0;i<cartList.size();i++) {
			if(cartList.get(i).getName().equals(name)) {
				cartList.get(i).setQty(cartList.get(i).getQty()-1);
			}
		}
	}
}
