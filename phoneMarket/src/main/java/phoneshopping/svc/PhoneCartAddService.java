package phoneshopping.svc;

import static phoneshopping.db.JdbcUtil.close;
import static phoneshopping.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import phoneshopping.dao.PhoneDAO;
import phoneshopping.vo.Cart;
import phoneshopping.vo.Phone;

//장바구에 추가 처리
public class PhoneCartAddService {

	public Phone getCartphone(int id){
		
		PhoneDAO phoneDAO = PhoneDAO.getInstance();
		
		Connection con = getConnection();
		
		phoneDAO.setConnection(con);
		
		Phone phone = phoneDAO.selectphone(id);
		
		close(con);
		
		return phone;
	}//
	
	//장바구니에 추가
	public void addCart(HttpServletRequest request,
						Phone cartphone) {
		
		//세션 속성을 지정하기 위해 선언
		HttpSession session = request.getSession();
		
		ArrayList<Cart> cartList = 
				(ArrayList<Cart>)session.getAttribute("cartList");
		
		if(cartList == null) {
			//장바구니에 담을 ArrayList 생성
			cartList = new ArrayList<Cart>();
			
			//세션 속성을 생성
			session.setAttribute("cartList",cartList);
		}
		
		boolean isNewCart = true;
		
		for(int i=0;i<cartList.size();i++) {
			if(cartphone.getName().equals(cartList.get(i).getName())) {
				isNewCart = false;
				cartList.get(i).setQty(cartList.get(i).getQty()+1);
				break;
			}
		}//
		
		if(isNewCart) {//장바구니에 새로 추가된 품종이면
			
			Cart cart = new Cart();
			cart.setId(cartphone.getId());//핸드폰 상품번호
			cart.setImage(cartphone.getImage());//이미지 파일명
			cart.setName(cartphone.getName());//품종
			cart.setPrice(cartphone.getPrice());//가격
			cart.setQty(1);//수량
			
			//신규 강아지 품종을 ArrayList에 추가
			cartList.add(cart);
		}
		
	}
}