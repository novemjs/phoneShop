package phoneMarket.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneMarket.vo.ActionForward;

public interface Action {
	//추상 메서드
	ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception;
}
