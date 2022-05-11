package phoneshopping.action;

import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneListService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Phone;

//핸드폰 목록을 처리하는 클래스
public class PhoneListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//핸드폰 이미지 파일 이름을 관리
		ArrayList<String> todayImageList = new ArrayList<String>();
		//쿠키를 관리
		Cookie[] cookieArray = request.getCookies();
		
		
		if (cookieArray != null) {
			for(int i=0;i<cookieArray.length;i++) {
				//쿠키 정보중에서 오늘 본 핸드폰 이미지파일명인 쿠키
				//정보만 가져와서 ArrayList에 대입
				if(cookieArray[i].getName().startsWith("today")) {
					todayImageList.add(cookieArray[i].getValue());
				}
			}
		}//
		
		PhoneListService phoneListService = new PhoneListService();
		ArrayList<Phone> phoneList = phoneListService.getphoneList();
		
		//테이블에 있는 모든 핸드폰 목록 정보
		request.setAttribute("phoneList",phoneList);
		//오늘본 핸드폰 목록 정보
		request.setAttribute("todayImageList",todayImageList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("phoneList.jsp");
		
		return forward;
		
	}

}