<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phoneMarket.vo.BoardBean" %>      
<!DOCTYPE html>
<html>
<head>
<script>
	function modifyboard(){
		modifyform.submit();
	}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#registForm {
		width:500px;
		border:1px solid black;
		margin:auto;
	}
	
	h2 {
		text-align:center;
	}
	
	table {
		margin:auto;
		width:450px;
	}
	
	.td_left {
		width:150px;
		background:orange;
		text-align:center;
	}
	
	.td_right {
		width:300px;
		background:skyblue;
	}
	
	#commandCell {
		text-align:center;
	}
</style>
</head>
<body>
	<%@ include file="top.jsp" %>
	<%
		BoardBean article = (BoardBean)request.getAttribute("article");	
		String nowPage=(String)request.getAttribute("page");
		if(session.getAttribute("sessionId")!=null){
	%>
	
	<section id="registForm">
		<h2>게시판 수정</h2>
		<form name="modifyform" 
		      action="boardModifyPro.bo" 
			  method="post">
			  
			<input type="hidden" name="board_num" value="<%=article.getBoard_num()%>"/>  
			<input type="hidden" name="page" value="<%=nowPage %>">
			  
			<table class="table table-striped">
				<tr>
					<td class="td_left">
						<label for="board_name">작성자</label>
					</td>
					<td class="td_right">
						<input type="text" name="board_name" 
							   id="board_name"	
							   required="required"
				   	           value="<%=article.getBoard_name()%>"/>
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="board_pass">비밀번호</label>
					</td>
					<td class="td_right">
						<input type="password" name="board_pass"
							   id="board_pass"
							   required="required"/>
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="board_subject">제목</label>
					</td>
					<td class="td_right">
						<input type="text" name="board_subject"
							   id="board_subject"
							   required="required"
							   value="<%=article.getBoard_subject()%>"/>
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="board_content">내용</label>
					</td>
					<td class="td_right">
						<textarea name="board_content" 
								  id="board_content" 
							      cols="40" rows="15" 
							      required="required"><%=article.getBoard_content()%></textarea>
					</td>
				</tr>
			</table>
			<section id="commandCell">
				<a href="javascript:modifyboard()">[수정]</a>&nbsp;&nbsp;
				<a href="javascript:history.go(-1)">[뒤로]</a>
			</section>
		</form>
	</section>	
	<%}else{ 
		out.println("<script>");
		out.println("alert('로그인이 필요합니다!')");
		out.println("location.href='http://localhost:8080/phoneMarket/member/loginMember.jsp'");
		out.println("</script>");
	}
	%>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>







