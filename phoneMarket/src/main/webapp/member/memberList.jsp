<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	table{
		text-align:center;	
	}
		
	.button{
		margin-bottom:20px;
		font:12px 맑은고딕;
		color:blue;
		width:100px;
		height:20px;
	}
	td{
		border:1px solid black;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%@ include file="top.jsp" %>
	
	<sql:query var="rs" dataSource="${conn }">
		select*from member order by id
	</sql:query>
	<h1 style="text-align:center;">회원관리</h1>
	<table class="table table-striped">
		
		<tr>
			<th width="10%">아이디</th>
			<th width="10%">이름</th>
			<th width="10%">나이</th>
			<th width="10%">성별</th>
			<th width="20%">이메일</th>
			<th width="20%">연락처</th>
			<th width="10%">수정</th>
			<th width="10%">삭제</th>
		</tr>
		<%-- row에 rs에있는 모든 rows들을 대입 --%>
		<c:forEach var="row" items="${rs.rows }">
			<tr>
				<td><c:out value="${row.id }"/></td>
				<td><c:out value="${row.name }"/></td>
				<td><c:out value="${row.age }"/></td>
				<td><c:out value="${row.gender }"/></td>
				<td><c:out value="${row.email }"/></td>
				<td><c:out value="${row.phone }"/></td>
				<td>
					<a href="updateMember.jsp?id=<c:out value='${row.id }'/>">수정</a>
				</td>
				<td>
					<a href="deleteMember.jsp?id=<c:out value='${row.id }'/>">삭제</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>