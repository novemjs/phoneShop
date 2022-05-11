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
	<sql:query var="board" dataSource="${conn }">
		select * from board
	</sql:query>
	<h3 style="text-align:center;">게시판 관리</h3>
		<form action="/phoneMarket/adminDelete.bo" method="post" name="listForm">
			<table class="table table-striped">
				<c:forEach var="bo" items="${board.rows }" varStatus="status">
					<tr class="table-primary">
						<td>#</td>
						<td>제목</td>
						<td>작성자</td>
						<td>내용</td>
						<td>등록일자</td>
						<td>조회수</td>
						<td>#삭제</td>
					</tr>
					<tr>
						<td>${status.count }</td>
						<td>${bo.board_subject }</td>
						<td>${bo.board_name }</td>
						<td>${bo.board_content }</td>
						<td>${bo.board_date }</td>
						<td>${bo.board_readcount }</td>
						<td>
							<input type="hidden" name="num" value="${bo.board_num }">
							<input type="button" value="삭제하기" onclick="deletego();">
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>
	<%@ include file="../member/bottom.jsp" %>
	<script>
		function deletego(){
			var Form = document.listForm;
			if(confirm("정말로 삭제하시겠습니까?")){
				alert("삭제하였습니다");
				Form.submit();
			}else{
				alert("이전 페이지로 돌아갑니다.");
			}
		}
	</script>
</body>
</html>