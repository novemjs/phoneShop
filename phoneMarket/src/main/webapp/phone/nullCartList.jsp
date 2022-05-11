<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="top.jsp" %>
	<div style="text-align:center;">
		<h3>상품정보가 없습니다</h3>
		<button onclick="location.href='http://localhost:8080/phoneMarket/phone/phoneList.phone'">상품목록으로 가기</button>
	</div>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>