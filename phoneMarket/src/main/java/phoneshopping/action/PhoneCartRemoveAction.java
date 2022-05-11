package phoneshopping.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneCartRemoveService;
import phoneshopping.vo.ActionForward;

//장바구니 삭제 처리
public class PhoneCartRemoveAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//장바구니에서 삭제하려는 핸드폰 품목을 가져와서 문자열 배열에 대입
		String[] kindArray = 
				request.getParameterValues("remove");
		
		PhoneCartRemoveService phoneCartRemoveService = 
				new PhoneCartRemoveService();
		
		//장바구니에 체크된 내역 삭제처리
		phoneCartRemoveService.cartRemove(request,kindArray);
		ActionForward forward=null;
		//삭제 처리후 장바구니 내역 URL로 이동
		forward = new ActionForward("phoneCartList.phone",true);
		
		return forward;
		
	}

}