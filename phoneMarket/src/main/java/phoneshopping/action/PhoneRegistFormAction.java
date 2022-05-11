package phoneshopping.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.vo.ActionForward;

//핸드폰 정보 입력 화면 처리
public class PhoneRegistFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = 
				new ActionForward("phoneRegistForm.jsp",false);
		
		return forward;
	}

}