<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	
	<sql:update dataSource="${conn }">
		insert into member values(?,?,?,?,?,?,?,?,?,?,now(),null,1)
		<sql:param value="${param.id }"/>
		<sql:param value="${param.passwd }"/>
		<sql:param value="${param.name }"/>
		<sql:param value="${param.age }"/>
		<sql:param value="${param.gender }"/>
		<sql:param value="${param.email }"/>
		<sql:param value="${param.phone }"/>
		<sql:param value="${param.postcd }"/>
		<sql:param value="${param.addr1 }"/>
		<sql:param value="${param.addr2 }"/>
	</sql:update>
	
	<%
		response.sendRedirect("resultMember.jsp?gubun=insert");
	%>
	
	
</body>
</html>