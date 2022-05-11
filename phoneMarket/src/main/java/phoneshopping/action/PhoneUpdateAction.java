package phoneshopping.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.svc.PhoneUpdateService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Phone;

public class PhoneUpdateAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PhoneUpdateService phoneUpdateService=new PhoneUpdateService();
		
		int id=Integer.parseInt(request.getParameter("id"));
		Phone phone=new Phone();
		phone.setId(id);
		phone.setKind(request.getParameter("kind"));
		phone.setName(request.getParameter("name"));
		phone.setColor(request.getParameter("kind"));
		phone.setSize(request.getParameter("size"));
		phone.setCamera(request.getParameter("camera"));
		phone.setImage(request.getParameter("image"));
		phone.setPrice(Integer.parseInt(request.getParameter("price")));
		phone.setStockqty(request.getParameter("stockqty"));
		phone.setContent(request.getParameter("content"));
		
		boolean isUpdateSuccess=phoneUpdateService.update(phone);
		
		ActionForward forward = null;
		
		if(isUpdateSuccess) {//성공
			
			forward = new ActionForward();
			
			forward.setRedirect(true);
			//핸드폰 목록 리스트로 이동
			forward.setPath("phoneList.phone");
			
		}else { //수정 실패
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('수정 실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return forward;
	}

}
