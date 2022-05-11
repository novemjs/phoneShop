<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		String id=request.getParameter("id");
	%>
	
	<sql:update dataSource="${conn }">
		delete from member where id=?
		<sql:param value="${param.id }"/>
	</sql:update>
	<% session.invalidate(); %>
	<c:redirect url="resultMember.jsp?gubun=delete"/>
</body>
</html>