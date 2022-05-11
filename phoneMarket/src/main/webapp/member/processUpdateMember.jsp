<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		update member
		   set name = ?,
		       age = ?,
		       gender = ?,
		       email = ?,
		       phone = ?,
		       postcd = ?,
		       addr1 = ?,
		       addr2 = ?,
		       updatedate = now()
		 where id = ?
		 <sql:param value="${param.name }"/>
		 <sql:param value="${param.age }"/>
		 <sql:param value="${param.gender }"/>
		 <sql:param value="${param.email }"/>
		 <sql:param value="${param.phone }"/>
		 <sql:param value="${param.postcd }"/>
		 <sql:param value="${param.addr1 }"/>
		 <sql:param value="${param.addr2 }"/>
		 <sql:param value="${param.id }"/>
	</sql:update>
	<c:redirect url="resultMember.jsp?gubun=update"/>
</body>
</html>