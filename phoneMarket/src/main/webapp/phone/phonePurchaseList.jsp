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
	<br>
	<div style="text-align:center;">
		<img src="http://cdn6-kinx.makeshop.co.kr/design/smblue111/wib_2020/img/cart/step3.png">
	</div>
	<br>
	
	<h2 style="text-align:center">나의 구매목록</h2>
	<c:forEach var="par" items="${rs.rows }">
		<form action="phoneCancel.phone" method="post">
			<input type="hidden" name="id" value="${par.id }">
			<table class="table table-striped" style="text-align:center">
				<tr id="tr_top">
					<td>핸드폰 이름</td>
					<td>가격</td>
					<td>요청사항</td>
					<td>입력주소</td>
					<td>상세주소</td>
					<td>취소여부</td>
					<td>구매일자</td>
					<td>리뷰</td>
					
				</tr>
				<tr>
					<td><c:out value="${par.phoneName }"/></td>
					<td><c:out value="${par.orderPrice }"/></td>
					<td><c:out value="${par.memo }"/></td>
					<td><c:out value="${par.addr1 }"/></td>
					<td><c:out value="${par.addr2 }"/></td>
					<td><input type="submit" value="주문취소"></td>
					<td><c:out value="${par.orderDate }"></c:out></td>
					</form>
					<form action="reviewPhone.phone" method="post">
					<td>
						<input type="hidden" value="${par.id }" name="id">
						<input type="hidden" value="${sessionId }" name="userId">
						<input type="hidden" value="${par.phoneName }" name="phoneName">
						<textarea rows="3" cols="30" name="review"></textarea>
						<input type="submit" value="리뷰하기" onclick="review()">
					</td>
					</form>
				</tr>
			</table>
			</form>
			</c:forEach>
			<c:if test="${empty rs.rows }">
				<div style="text-align:center;">
					<h4>구매한 제품이 없습니다!</h4>
					<button class="btn btn-primary" onclick="location.href='phoneList.phone'">구매하러 가기</button>
				</div>
			</c:if>
			<%@ include file="../member/bottom.jsp" %>
	</body>
	<script>
		function review(){
			alert('리뷰 작성 완료되었습니다!!');
		}
	</script>
	
</html>