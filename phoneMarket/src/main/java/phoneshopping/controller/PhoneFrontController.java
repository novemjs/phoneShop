package phoneshopping.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneshopping.action.Action;
import phoneshopping.action.PhoneCancelAction;
import phoneshopping.action.PhoneCartAddAction;
import phoneshopping.action.PhoneCartListAction;
import phoneshopping.action.PhoneCartQtyDownAction;
import phoneshopping.action.PhoneCartQtyUpAction;
import phoneshopping.action.PhoneCartRemoveAction;
import phoneshopping.action.PhoneCartSearchAction;
import phoneshopping.action.PhoneListAction;
import phoneshopping.action.PhoneOrderAction;
import phoneshopping.action.PhoneRegistAction;
import phoneshopping.action.PhoneRegistFormAction;
import phoneshopping.action.PhoneRemoveAction;
import phoneshopping.action.PhoneReviewAction;
import phoneshopping.action.PhoneReviewDeleteAction;
import phoneshopping.action.PhoneReviewModifyAction;
import phoneshopping.action.PhoneSendAction;
import phoneshopping.action.PhoneUpdateAction;
import phoneshopping.action.PhoneViewAction;
import phoneshopping.dao.PhoneDAO;
import phoneshopping.vo.ActionForward;

@WebServlet("*.phone")
public class PhoneFrontController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}
	
	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		//http://localhost:8080/phoneShopping/phoneList.phone
		String requestURI = req.getRequestURI();
		//phoneShopping 프로젝트명만 리턴
		String contextPath = req.getContextPath();
		// 실행하려는 URL(/phoneList.phone)만 리턴
		String command = requestURI.substring(contextPath.length());
		
		System.out.println("command"+command);
		
		Action action = null;
		ActionForward forward = null;
		
		//쇼핑몰 상품 리스트
		if(command.equals("/phone/phoneList.phone")) {
			action = new PhoneListAction();
			try {
				forward = action.execute(req,resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//상품 상세보기 처리	
		}else if(command.equals("/phone/phoneView.phone")) {
			action = new PhoneViewAction();
			try {
				forward = action.execute(req,resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//장바구니 추가 처리	
		}else if(command.equals("/phone/phoneCartAdd.phone")) {
			action = new PhoneCartAddAction();
			try {
				forward = action.execute(req,resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//장바구니 목록 처리	
		}else if(command.equals("/phone/phoneCartList.phone")) {
			action = new PhoneCartListAction();
			try {
				forward = action.execute(req,resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//장바구니 상품 검색 처리	
		}else if(command.equals("/phone/phoneCartSearch.phone")) {
			action = new PhoneCartSearchAction();
			try {
				forward = action.execute(req,resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//장바구니 상품 삭제 처리	
		}else if(command.equals("/phone/phoneCartRemove.phone")) {
			action = new PhoneCartRemoveAction();
			try {
				forward = action.execute(req,resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//장바구니 상품 수량 증가 처리	
		}else if(command.equals("/phone/phoneCartQtyUp.phone")) {
			action = new PhoneCartQtyUpAction();
			try {
				forward = action.execute(req,resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//장바구니 상품 수량 감소 처리		
		}else if(command.equals("/phone/phoneCartQtyDown.phone")) {
			action = new PhoneCartQtyDownAction();
			try {
				forward = action.execute(req,resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//상품 신규 등록 처리	
		}else if(command.equals("/phone/phoneRegist.phone")) {
			action = new PhoneRegistAction();
			try {
				forward = action.execute(req,resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//상품 입력 화면 처리	
		}else if(command.equals("/phone/phoneRegistForm.phone")) {
			action = new PhoneRegistFormAction();
			try {
				forward = action.execute(req,resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//삭제 처리
		}else if(command.equals("/phone/phoneRemove.phone")) {
			action=new PhoneRemoveAction();
			try {
				forward=action.execute(req, resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//수정 처리
		}else if(command.equals("/phone/phoneUpdate.phone")) {
			action=new PhoneUpdateAction();
			try {
				forward=action.execute(req, resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//주문 처리
		}else if(command.equals("/phone/phoneOrder.phone")) {
			action=new PhoneOrderAction();
			try {
				forward=action.execute(req, resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//주문취소처리
		}else if(command.equals("/phone/phoneCancel.phone")){
			action=new PhoneCancelAction();
			try {
				forward=action.execute(req, resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
			//리뷰
		}else if(command.equals("/phone/reviewPhone.phone")) {
			action=new PhoneReviewAction();
			try {
				forward=action.execute(req, resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
			//리뷰삭제
		}else if(command.equals("/phone/reviewDelete.phone")) {
			action=new PhoneReviewDeleteAction();
			try {
				forward=action.execute(req, resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/phone/reviewUpdate.phone")) {
			action=new PhoneReviewModifyAction();
			try {
				forward=action.execute(req, resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//배송여부확인 처리
		}else if(command.equals("/phone/phoneSend.phone")) {
			action=new PhoneSendAction();
			try {
				forward=action.execute(req, resp);
			}catch(Exception e) {
				e.printStackTrace();
			}
		//아이디 중복체크 ajax
		}else if(command.equals("/member/IdCheckService.phone")) {
			
			PhoneDAO dao=PhoneDAO.getInstance();
			String userId=req.getParameter("userId");
			
			PrintWriter out=resp.getWriter();
			
			int idCheck=dao.checkId(userId);
			if(idCheck==0) {
				System.out.println("이미 존재하는 아이디");
			}else if(idCheck==1){
				System.out.println("사용 가능한 아이디");
			}
			
			out.write(idCheck+"");
		}
		
		if(forward != null) {
		
			if(forward.isRedirect()) {
				resp.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dispatcher = req.getRequestDispatcher(forward.getPath());
				dispatcher.forward(req,resp);
			}
		}
	}
}