package phoneshopping.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneCartQtyUpService;
import phoneshopping.vo.ActionForward;

public class PhoneCartQtyUpAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String kind = request.getParameter("name");
		
		PhoneCartQtyUpService phoneCartQtyUpService = new PhoneCartQtyUpService();
		
		//같은 품종을 선택시 장바구니에 새로운 행이 추가되는 것이 아니라
		//수량만 변경시킨다.
		phoneCartQtyUpService.upCartQty(kind,request);
		
		//장바구니 목록 URL로 이동
		ActionForward forward = 
				new ActionForward("phoneCartList.phone",true);
		
		return forward;
	}

}
