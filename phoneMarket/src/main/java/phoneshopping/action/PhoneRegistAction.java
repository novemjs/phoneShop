package phoneshopping.action;

import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import phoneshopping.svc.PhoneRegistService;
import phoneshopping.vo.ActionForward;
import phoneshopping.vo.Phone;

//핸드폰 정보 신규 등록 처리
public class PhoneRegistAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PhoneRegistService phoneRegistService = 
				              new PhoneRegistService();
		
		String realFolder = "";
		//String saveFolder = "/images";
		String encType = "UTF-8";
		int maxSize = 5*1024*1024;//5M
		
		//ServletContext context = request.getServletContext();
		//이미지가 업로드 되는 폴더
		realFolder = "D:\\jspStudy\\phoneMarket\\src\\main\\webapp\\resources\\images";
		
		MultipartRequest multi = new MultipartRequest(
				   					request,//내장객체
				   					realFolder,//업로드위치
				   					maxSize,//5M
				   					encType,
				   					new DefaultFileRenamePolicy());
		
		//업로드 이미지 이름
		String image = multi.getFilesystemName("image");
		
		Phone phone = new Phone(
						0,
						multi.getParameter("kind"),
						multi.getParameter("name"),
						multi.getParameter("color"),
						multi.getParameter("size"),
						multi.getParameter("camera"),
						image,
						Integer.parseInt(multi.getParameter("price")),
						multi.getParameter("stockqty"),
						multi.getParameter("content"),
						0,new Date(),null
);
		
		//핸드폰 정보 등록처리
		boolean isRegistSuccess = phoneRegistService.registphone(phone);
		
		ActionForward forward = null;
		
		if(isRegistSuccess) {//성공
			
			forward = new ActionForward();
			
			forward.setRedirect(true);
			//핸드폰 목록 리스트로 이동
			forward.setPath("phoneList.phone");
			
		}else { //등록 실패
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('등록 실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return forward;
		
	}

}