<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="phoneMarket.vo.PageInfo" %>
<%@ page import="phoneMarket.vo.BoardBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<style>
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
</head>
<body>

	<%@ include file="top.jsp" %>
	<%
		ArrayList<BoardBean> articleList=(ArrayList<BoardBean>)request.getAttribute("articleList");
		PageInfo pageInfo=(PageInfo)request.getAttribute("pageInfo");
		int listCount=pageInfo.getListCount();
		int nowPage=pageInfo.getPage();
		int maxPage=pageInfo.getMaxPage();
		int startPage=pageInfo.getStartPage();
		int endPage=pageInfo.getEndPage();
	%>
	<section id="listForm" style="text-align:center;font-family: 'Jua', sans-serif;">
		<h2>글목록&nbsp;&nbsp;&nbsp;<a href="boardWriteForm.bo">게시판글쓰기</a></h2>
		<table class="table table-striped">
			<%
				if(articleList!=null&&listCount>0){
			%>
			
			<tr id="tr_top" class="table-primary">
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>날짜</td>
				<td>조회수</td>
			</tr>
			<%		for(int i=0;i<articleList.size();i++){ %>
			<tr>
				<td><%=articleList.get(i).getBoard_num() %></td>
				<td>
					<%
						if(articleList.get(i).getBoard_re_lev()!=0){
							for(int a=0;a<=articleList.get(i).getBoard_re_lev()*2;a++){
					%>
					&nbsp;
					<%		} %> ▶
					<%	}else{ %> ▶<%} %>
						<a href="boardDetail.bo?board_num=<%=articleList.get(i).getBoard_num() %>&page=<%=nowPage %>">
							<%=articleList.get(i).getBoard_subject() %>
						</a>
				</td>
				<td><%=articleList.get(i).getBoard_name() %></td>
				<td><%=articleList.get(i).getBoard_date() %></td>
				<td><%=articleList.get(i).getBoard_readcount() %></td>
			</tr>
			
			<%
				} 
			%>
			
		</table>
	</section>
	<section id="pageList" style="text-align:center;">
		<%if(nowPage<=1){ %>
			[이전]&nbsp;
		<%}else{ %>
			<a href="boardList.bo?page=<%=nowPage-1 %>">[이전]</a>&nbsp;
		<%} %>
		
		<%for(int a=startPage;a<=endPage;a++){
			if(a==nowPage){%>
				[<%=a %>]
			<%}else{ %>
				<a href="boardList.bo?page=<%=a %>">[<%=a %>]</a>&nbsp;
			<%} %>
		<%} %>
		<%if(nowPage>=maxPage){ %>
			[다음]
		<%}else{ %>
			<a href="boardList.bo?page=<%=nowPage+1 %>">[다음]</a>
		<%} %>
	</section>
	<%}else{ %>
		<section id="emptyArea">등록된 글이 없습니다.</section>
	<%} %>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>