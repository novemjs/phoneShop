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
	<div id="_chatbox" style="text-align:center">
		<h4>궁금한 점을 실시간으로 물어보세요</h4>
		<iframe src="https://service.dongledongle.com/chat" frameborder="0" width="100%" height="500"></iframe>
		<input type="submit" id="btnBack" value="뒤로가기" onClick="history.back()">
	</div>
</body>
</html>