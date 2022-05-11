<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#writeForm{
		width:500px;
		
		border:1px solid ;
		margin:auto;
	}
	h2{
		text-align:center;
	}
	table{
		margin:auto;
		width:450px;
	}
	.td_left{
		width:150px;
		background:orange;
	}
	.td_right{
		width:300px;
		background:skyblue;
	}
	#commandCell{
		text-align:center;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%@ include file="top.jsp" %>
	<% if(session.getAttribute("sessionId")!=null){ %>
	<section id="writeForm">
		<h2>게시판글등록</h2>
		<form action="boardWritePro.bo" method="post" enctype="multipart/form-data" name="boardform">
			<table class="table table-striped">
				<tr>
					<td class="td_left"><label for="board_name">글쓴이</label></td>
					<td class="td_right"><input type="text" name="board_name" id="board_name" required="required" value="${sessionId }" readonly="readonly"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="board_pass">비밀번호</label></td>
					<td class="td_right"><input type="password" name="board_pass" id="board_pass" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="board_subject">제목</label></td>
					<td class="td_right"><input type="text" name="board_subject" id="board_subject" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="board_content">내용</label></td>
					<td><textarea id="board_content" name="board_content" cols="40" rows="15" required="required"></textarea></td>
				</tr>
				<tr>
					<td class="td_left"><label for="board_file">파일 첨부</label></td>
					<td class="td_right"><input type="file" name="board_file" id="board_file" required="required"></td>
				</tr>
			</table>
			<section id="commandCell">
				<input type="submit" value="등록">&nbsp;&nbsp;
				<input type="reset" value="다시쓰기">
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