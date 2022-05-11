package phoneshopping.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneCartAddService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Phone;

//장바구니 추가 처리
public class PhoneCartAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PhoneCartAddService phoneCartAddService 
						= new PhoneCartAddService();
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		//장바구니 등록처리
		Phone cartphone = phoneCartAddService.getCartphone(id);
		phoneCartAddService.addCart(request, cartphone);
		//장바구니 목록 URL로 이동
		ActionForward forward = 
				new ActionForward("phoneCartList.phone",true);
		
		return forward;
		
	}

}
