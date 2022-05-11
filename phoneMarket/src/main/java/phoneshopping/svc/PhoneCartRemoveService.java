package phoneshopping.svc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import phoneshopping.vo.Cart;

//장바구니에서 선택된 항목 삭제처리
public class PhoneCartRemoveService {

	//삭제하려는 품종 배열
	public void cartRemove(HttpServletRequest request,
				String[] kindArray) {
		
		HttpSession session = request.getSession();
		ArrayList<Cart> cartList = (ArrayList<Cart>)session.getAttribute("cartList");
		
		//매개변수로 넘어온 품종 배열에 있는 품종에 대해
		//반복문을 실행하여 장바구니에 있는 해당 품종을 찾아서 삭제처리
		for(int i=0;i<kindArray.length;i++) {
			for(int j=0;j<cartList.size();j++) {
				if(cartList.get(j).getName().equals(kindArray[i])) {
					cartList.remove(cartList.get(j));
				}
			}
		}
	}
}
