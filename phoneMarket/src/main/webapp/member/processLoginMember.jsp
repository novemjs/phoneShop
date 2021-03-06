<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
	%>
	<%@ include file="dbconn.jsp" %>
	 <sql:query
	      dataSource="${conn}"
	      var="resultSet">
	      
	      select * 
	        from member
	       where id = ?
	         and passwd = ? 

		  <sql:param value="<%=id %>" />
		  <sql:param value="<%=passwd %>" />
	 </sql:query>
 
	 <c:if test="${resultSet.rowCount > 0}">
	  <%
	 	session.setAttribute("sessionId",id);
	   %>
	 <c:redirect url="resultMember.jsp?gubun=login"/>
	 </c:if>
	 
	 <c:if test="${resultSet.rowCount == 0}">
	 	<c:redirect url="resultMember.jsp?gubun=loginError"/>
	 </c:if>
</body>
</html>

