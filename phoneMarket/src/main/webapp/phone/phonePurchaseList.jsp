<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="java.util.*" %>
<%@ page import="phoneshopping.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="top.jsp" %>
	<sql:setDataSource
		var="conn"
		driver="com.mysql.cj.jdbc.Driver"
		url="jdbc:mysql://localhost/phoneshop?serverTimezone=Asia/Seoul"
		user="phone"
		password="phone1234"/>
	<sql:query dataSource="${conn}" var="rs">
		select * from orderphone where userid=?
		<sql:param value="<%=sessionId %>"/>
	</sql:query>
	<h2>나의 구매목록</h2>
	<c:forEach var="par" items="${rs.rows }">
			<table class="table table-striped" style="text-align:center">
				<tr id="tr_top">
					<td>핸드폰 이름</td>
					<td>가격</td>
					<td>요청사항</td>
					<td>입력주소</td>
					<td>상세주소</td>
				</tr>
				<tr>
					<td><c:out value="${par.phoneName }"/></td>
					<td><c:out value="${par.orderPrice }"/></td>
					<td><c:out value="${par.memo }"/></td>
					<td><c:out value="${par.postcd }"/></td>
					<td><c:out value="${par.addr2 }"/></td>
				</tr>
			</table>
	</c:forEach>
	</body>
</html>