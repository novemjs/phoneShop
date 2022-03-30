package phoneshopping.vo;

//Controller에서 클라이언트의 요청을 받앗허 처리한 후
//데이터를 보여줄 최종 View jsp로 이동시 url과 forward방식을
//결정하는 클래스
public class ActionForward {

	//Servlet에서 클라이언트의 요청을 처리후 Forward될
	//최종 view page url이 저장되는 필드
	private String path;
	private boolean redirect;//리다이렉트 방식사용 여부
	
	//기본생성자
	public ActionForward() {}

	//매개변수 2개 생성자
	public ActionForward(String path, boolean redirect) {
		this.path = path;
		this.redirect = redirect;
	}

	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isRedirect() {
		return redirect;
	}
	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}
 
}
