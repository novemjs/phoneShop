<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="phoneshopping.vo.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="top.jsp"

%>
<sql:setDataSource
		var="conn"
		driver="com.mysql.cj.jdbc.Driver"
		url="jdbc:mysql://localhost/phoneshop?serverTimezone=Asia/Seoul"
		user="phone"
		password="phone1234"/>

<sql:query dataSource="${conn}" var="rs">
   select * from orderphone 
</sql:query>
	<form></form> 
	<select>
		<option></option>
		<option></option>
		<option></option>
		<option></option>
	</select>
	<table class="table table-striped" style="text-align:center;">
		
		<tr id="tr_top">
			<td>주문한 유저 아이디</td>
			<td>주문한고객 이름</td>
			<td>주문 금액</td>
		</tr>
		<c:forEach var="sell" items="${rs.rows }">
		<tr>
			<td><c:out value="${sell.userid }"/></td>
			<td><c:out value="${sell.name }"/></td>
			<td><c:out value="${sell.orderPrice }원"/></td>
		</tr>
		</c:forEach>
	</table>


</body>
</html>