package phoneMarket.vo;

public class PageInfo {
	private int page;//현재 페이지 번호
	private int maxPage;//총 게시물에 대해 필요한 총 페이지수
	private int startPage;//현재 페이지에서 시작페이지 번호
	private int endPage;//현재 페이지에서 종료페이지 번호
	private int listCount;//총 게시물 건수
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	
	
}
