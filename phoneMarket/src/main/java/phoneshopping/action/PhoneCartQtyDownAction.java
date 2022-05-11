package phoneshopping.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneCartQtyDownService;
import phoneshopping.vo.ActionForward;

public class PhoneCartQtyDownAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String name = request.getParameter("name");
		
		PhoneCartQtyDownService phoneCartQtyDownService = new PhoneCartQtyDownService();
		
		//장바구니에서 삭제처리되면 수량 감소 처리
		phoneCartQtyDownService.downCartQty(name,request);
		
		//핸드폰 목록으로 이동
		ActionForward forward = 
				new ActionForward("phoneCartList.phone",true);
		
		return forward;
	}

}
