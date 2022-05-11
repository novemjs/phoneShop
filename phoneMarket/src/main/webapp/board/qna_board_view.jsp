<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="phoneMarket.vo.BoardBean" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<style>
	
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="top.jsp" %>
	<%
		BoardBean article=(BoardBean)request.getAttribute("article");
		String nowPage=(String)request.getAttribute("page");
	%>
	<table class="table" id="wrapper" style="font-family: 'Jua', sans-serif;">
		<section id="articleForm">
			<h2 style="text-align:center;">글 내용 상세보기</h2>
			<section id="basicInfoArea">
			
				<tr class="table-primary">
					<td>제목:</td>
					<td>내용:</td>
					<td>첨부파일:</td>
				</tr>
				<tr>
					<td><%=article.getBoard_subject() %></td>
					<td><%=article.getBoard_content() %></td>
					<td>
						<%if(!(article.getBoard_file()==null)){ %>
						<a href="boardUpload/<%=article.getBoard_file() %>" download >
							<%=article.getBoard_file() %>
						</a>
				<%} %></td>
					
				</tr>
			</section>
		</section>
	</table>
	<section id="commandList" style="text-align:center;">
		<a href="boardReplyForm.bo?board_num=<%=article.getBoard_num() %>&page=<%=nowPage %>">[답변]</a>
		<a href="boardModifyForm.bo?board_num=<%=article.getBoard_num() %>&page=<%=nowPage %>">[수정]</a>
		<a href="boardDeleteForm.bo?board_num=<%=article.getBoard_num() %>&page=<%=nowPage %>">[삭제]</a>
		<a href="boardList.bo?page=<%=nowPage %>">[목록]</a>&nbsp;&nbsp;
	</section>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>