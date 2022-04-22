package phoneshopping.action;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneViewService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Phone;

//특정 강아지 상세보기 처리
public class PhoneViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		PhoneViewService phoneViewService = new PhoneViewService();
		
		//강아지 아이디 번호
		int id = Integer.parseInt(request.getParameter("id"));
		
		//특정 아이디번호에 대한 강아지 내역을 리턴
		Phone phone = phoneViewService.getphoneView(id);
		//가져온 강아지 정보를 jsp에서 출력하기 위해 속성 지정
		request.setAttribute("phone", phone);
		
//		//오늘 상세보기를 한 강아지 이미지를 모두 쿠키로 생성
//		Cookie todayImageCookie = 
//				 new Cookie("today"+id,phone.getImage());
//		
//		//쿠키 유효시간(1일)
//		todayImageCookie.setMaxAge(60*60*24);
//		
//		//생성된 쿠키를 클라이언트로 전송
//		response.addCookie(todayImageCookie);
//		
		ActionForward forward = 
				new ActionForward("phoneView.jsp",false);
		
		return forward;
		
	}
	
}