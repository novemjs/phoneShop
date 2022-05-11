package phoneMarket.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import phoneMarket.svc.BoardListService;
import phoneMarket.vo.ActionForward;
import phoneMarket.vo.BoardBean;
import phoneMarket.vo.PageInfo;
//게시물 리스트 처리
public class BoardListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//게시물을 대입하기 위해 ArrayList선언
		ArrayList<BoardBean> articleList=new ArrayList<>();
		int page=1;//시작페이지
		int limit=10;//페이지당 보여지는 행수
		
		if(request.getParameter("page")!=null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		BoardListService boardListService=new BoardListService();
		//getListCount()메서드는 전체 리스트 행수를 리턴하게 만들것
		int listCount=boardListService.getListCount();
		//getArticleList()? 해당 페이지에 대한 게시물 리스트를 리턴하는 메서드
		articleList=boardListService.getArticleList(page,limit);
		//게시물을 출력하기 위한 최대 페이지수
		int maxPage=(int)((double)listCount/limit+0.95);
		//각 페이지의 하단에 출력하는 시작페이지 번호
		int startPage=(((int)((double)page/10+0.9))-1) * 10+1;
		//각 페이지의 하단에 출력하는 종료페이지 번호
		int endPage=startPage+10-1;
		
		if(endPage>maxPage) {
			endPage=maxPage;
		}
		//페이징 처리를 하기위한 인스턴스 생성
		PageInfo pageInfo=new PageInfo();
		
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		//현재 페이지 정보와 게시물 리스트 내역을 속성으로 지정하여 jsp로 전달
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("articleList", articleList);
		ActionForward forward=new ActionForward();
		forward.setPath("/board/qna_board_list.jsp");
		return forward;
	}

}
