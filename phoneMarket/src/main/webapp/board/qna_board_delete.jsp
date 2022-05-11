<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#passForm{
		width:400px;
		margin:auto;
		border:1px solid orange;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="top.jsp" %>
	<%
		int board_num=(Integer)request.getAttribute("board_num");
		String nowPage=(String)request.getAttribute("page");
	%>
	<section id="passForm">
		<form name="deleteForm" action="boardDeletePro.bo?board_num=<%=board_num %>&page=<%=nowPage %>" method="post">
			
			<table>
				<tr>
					<td><label>글 비밀번호:</label></td>
					<td><input type="password" name="board_pass">
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="삭제">
						<input type="button" value="돌아가기" onclick="javascript:history.go(-1)">
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>