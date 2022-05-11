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
<sql:query dataSource="${conn}" var="as">
   select sum(orderPrice) as totalPrice from orderphone 
</sql:query>
	
	<table class="table table-striped" style="text-align:center;">
		
		<tr id="tr_top" class="table-primary">
			<td>주문번호</td>
			<td>주문한 핸드폰</td>
			<td>주문 갯수</td>
			<td>주문한 유저 아이디</td>
			<td>주문한고객 이름</td>
			<td>주문 일자</td>
			<td>주문 금액</td>
		</tr>
		<c:forEach var="sell" items="${rs.rows }">
			<tr>
				<td><c:out value="${sell.ordersnt }"/></td>
				<td><c:out value="${sell.phoneName }"/></td>
				<td><c:out value="${sell.cnt }개"/></td>
				<td><c:out value="${sell.userid }"/></td>
				<td><c:out value="${sell.name }"/></td>
				<td><c:out value="${sell.orderDate }"/></td>
				<td><c:out value="${sell.orderPrice }원"/></td>
			</tr>
		</c:forEach>
	</table>
	<c:forEach var="all" items="${as.rows }">
		<h4 style="text-align:center">총 판매금액:<c:out value="${all.totalPrice }원"/></h4>
	</c:forEach>
	<%@ include file="googleChart.jsp" %>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>