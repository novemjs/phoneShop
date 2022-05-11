<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
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
   select * from phone
</sql:query>
	<table class="table table-sm" style="text-align:center;">
		<tr id="tr_top" class="table-primary">
			<th scope="col">#</th>
			<td scope="col">핸드폰 종류</td>
			<td>핸드폰명</td>
			<td>핸드폰 설명</td>
			<td>가격</td>
			<td>등록 일자</td>
			<td>재고</td>
			<td>관리</td>
		</tr>
		<c:forEach var="ad" items="${rs.rows }" varStatus="status">
			<tr>	
				<td>${status.count }</td>
				<td><c:out value="${ad.kind }"/></td>
				<td><c:out value="${ad.name }"/></td>
				<td><c:out value="${ad.content }"/></td>
				<td><c:out value="${ad.price }"/></td>
				<td><c:out value="${ad.regdate }"/></td>
				<td><c:out value="${ad.stockqty }개"/></td>
				<td>
					<button onclick="location.href='http://localhost:8080/phoneMarket/phone/phoneView.phone?id=${ad.id}'">수정</button>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>