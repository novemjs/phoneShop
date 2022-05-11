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
	<%@ include file="top.jsp" %>
	<sql:query var="rs" dataSource="${conn }">
		select * from review where userid=?
		<sql:param value="${sessionId }"></sql:param>
	</sql:query>
	<h3 style="text-align:center">나의 리뷰</h3>
				
	<c:if test="${empty rs.rows }">
		<div style="text-align:center;">
			<h4 >내가 작성한 리뷰가 없습니다!</h4>
			<button class="btn btn-primary" onclick="location.href='phoneList.phone'">구매하러 가기</button>
		</div>
	</c:if>
	<form action="reviewDelete.phone" method="post">
		<c:forEach var="re" items="${rs.rows }" varStatus="status">
			<table class="table table-striped">
				<tr id="tr_top">
					<th>#</th>
					<th>작성자</th>
					<th>핸드폰명</th>
					<th>리뷰내용</th>
					<th>등록일자</th>
					<th>리뷰수정</th>
					<th>리뷰삭제</th>
				</tr>
				<tr>
					<td>${status.count }</td>
					<td>${re.userid }</td>
					<td>${re.phonename }</td>
					<td>${re.review }</td>
					<td>${re.regdate }</td>
					<td>
						<input type="hidden" name="id" value="${re.id }">
						<input type="hidden" name="userId" value="${re.userid }">
						<input type="hidden" name="phoneName" value="${re.phonename }">
						<input type="hidden" name="num" value="${re.review_num }">
						<textarea rows="3" cols="30" name="reviewUpdate"></textarea>
						<input type="submit" value="리뷰수정" formaction="reviewUpdate.phone"> 
					</td>
					<td><input type="submit" value="리뷰삭제"></td>
				</tr>
			</table>
		</c:forEach>
	</form>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>