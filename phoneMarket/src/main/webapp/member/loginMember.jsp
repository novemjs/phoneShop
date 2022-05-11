<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<%@ include file="top.jsp" %>
	<div class="jumbotron">
		<div class="container" style="font-family: 'Jua', sans-serif;">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
	
	<div class="container" align="center" style="font-family: 'Jua', sans-serif;">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Please Sign In</h3>
			<%
				String error = request.getParameter("error");
			
				if(error != null){//에러가 있으면
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인하세요!");
					out.println("</div>");
				}
			%>
			<form class="form-signin" 
			      action="processLoginMember.jsp"
			      method="post">
				<div class="form-group">
					<label for="inputUserName" class="sr-only" style="font-size:20px;">
						아이디:
					</label>
					<input type="text" class="form-control"
					       placeholder="ID"
					       name="id" required autofocus style="font-size:20px;">
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only" style="font-size:20px;">
						비밀번호:
					</label>
					<input type="password" class="form-control"
					       placeholder="password"
					       name="passwd" required style="font-size:20px;">
				</div>
				
				<button class="btn btn btn-lg btn-success btn-block"
				        type="submit">로그인</button>
			</form>
		</div>
	</div>
	<%@include file="bottom.jsp" %>
</body>
</html>