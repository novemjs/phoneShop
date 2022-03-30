<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="phoneMarket.vo.BoardBean" %>
<!DOCTYPE html>
<html>
<head>
<style>
	#articleForm{
		width:500px;
		height:500px;
		border:1px solid red;
		margin:auto;
	}
	h2{
		text-align:center;
	}
	#basicInfoArea{
		height:40px;
		text-align:center;
	}
	#articleContentArea{
		background:orange;
		margin-top:20px;
		height:350px;
		text-align:center;
		overflow:auto;
	}
	#commandList{
		margin:auto;
		width:500px;
		text-align:center;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		BoardBean article=(BoardBean)request.getAttribute("article");
		String nowPage=(String)request.getAttribute("page");
	%>
	<section id="articleForm">
		<h2>글 내용 상세보기</h2>
		<section id="basicInfoArea">
			제목:
			<%=article.getBoard_subject() %>
			첨부파일:
			<%if(!(article.getBoard_file()==null)){ %>
				<a href="file_down?downFile=<%=article.getBoard_file() %>">
					<%=article.getBoard_file() %>
				</a>
			<%} %>
		</section>
		<section id="articleContentArea">
			<%=article.getBoard_content() %>
		</section>
	</section>
	<section id="commandList">
		<a href="boardReplyForm.bo?board_num=<%=article.getBoard_num() %>&page=<%=nowPage %>">[답변]</a>
		<a href="boardModifyForm.bo?board_num=<%=article.getBoard_num() %>">[수정]</a>
		<a href="boardDeleteForm.bo?board_num=<%=article.getBoard_num() %>&page=<%=nowPage %>">[삭제]</a>
		<a href="boardList.bo?page=<%=nowPage %>">[목록]</a>&nbsp;&nbsp;
	</section>
	
</body>
</html>