<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
	/* 로그인 화면에서 정상적으로 로그인 사용자에 대해 아이디값을 
	속성으로 지정하는데 이 속성값을 가져와 변수에 대입 */
	String sessionId = (String) session.getAttribute("sessionId");
%>

<!-- mysql 데이터베이스 연결 설정 -->
<sql:setDataSource
		var="conn"
		driver="com.mysql.cj.jdbc.Driver"
		url="jdbc:mysql://localhost/phoneshop?serverTimezone=Asia/Seoul"
		user="phone"
		password="phone1234"/>

<sql:query dataSource="${conn}" 
            var="result">
   select * from member where id = ?
   
   <sql:param value="${sessionId}"/>         

</sql:query> 

<!DOCTYPE html>
<html lang="ko">
    <head>
    <style>
	    footer {
	    width: 100%;
	    font-size:20px;
	     /* footer의 높이 */
	    position: absolute;  
	    bottom: 0;
	    left: 0;
	}
    </style>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title></title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    </head>
    <body>
    <ul class="nav navbar-nav navbar-right">
    <c:choose>
	    <c:when test="${empty sessionId}">
	    	<li><a  class="btn-lg dropdown-toggle" href="<c:url value="loginMember.jsp"/>"><span class="glyphicon glyphicon-user"></span>로그인</a></li>
	    	<li><a  class="btn-lg dropdown-toggle" href="<c:url value="addMember.jsp"/>"><span class="glyphicon glyphicon-log-in"></span>회원가입</a></li>
	    </c:when>
			<c:when test="${sessionId=='admin'}">
				<li style="padding-top:8px; color:black;font-size:22px"><c:forEach var="row" items="${result.rows}"><c:out value="${row.name}"/></c:forEach>님</li>
			      <li class="dropdown"><a class="btn-lg dropdown-toggle" data-toggle="dropdown" href="#">관리자용</a>
			        <ul class="dropdown-menu">
		              <li class="list-group-item" style="font-size:20px;"><a href="<c:url value="../phone/phoneRegistForm.jsp"/>">상품 등록</a></li>
		              <li class="list-group-item" style="font-size:20px;"><a href="<c:url value="../member/memberList.jsp"/>">회원목록</a></li>
			          <li class="list-group-item" style="font-size:20px;"><a href="<c:url value="../member/logoutMember.jsp"/>">로그아웃 </a></li>
				      <li class="list-group-item" style="font-size:20px;"><a href="<c:url value="../member/deleteMember.jsp"/>">회원 삭제</a></li>
			        </ul>
			      </li>  
			</c:when>
			<c:when test="${sessionId!='admin'}">
				<li style="padding-top:8px; color:black;font-size:22px"><c:forEach var="row" items="${result.rows}"><c:out value="${row.name}"/></c:forEach>님</li>
				<li style="font-weight:bold" class="nav-item"><a class="btn-lg nav-link" href="<c:url value="../phone/phonePurchaseList.jsp"/>">내 구매목록 </a></li>
				<li style="font-weight:bold" class="nav-item"><a class="btn-lg nav-link" href="<c:url value="../member/logoutMember.jsp"/>">로그아웃 </a></li>
				<li style="font-weight:bold" class="nav-item"><a class="btn-lg nav-link" href="<c:url value="../member/updateMember.jsp?id=${sessionId }"/>">회원수정</a></li>
				<li style="font-weight:bold" class="nav-item"><a class="btn-lg nav-link" href="<c:url value="../member/deleteMember.jsp?id=${sessionId }"/>">회원삭제</a></li>
			</c:when>	
		 </c:choose>
    </ul>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#!" style="font-size:40px;">Citizen</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a style="font-size:20px;" class="nav-link active" aria-current="page" href="http://localhost:8080/phoneMarket/member/mainMenu.jsp">Home</a></li>
                        <li class="nav-item dropdown"  style="font-size:20px;">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a  style="font-size:20px;" class="dropdown-item" href="http://localhost:8080/phoneMarket/phone/phoneList.phone">모든 제품</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a  style="font-size:20px;" class="dropdown-item" href="#!">인기상품</a></li>
                              
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a style="font-size:20px;" class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">게시판</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li style="font-size:20px;"><a class="dropdown-item" href="qna_board_list.jsp">자유 게시판</a></li>
                                <li style="font-size:20px;"><a class="dropdown-item" href="#!">New Arrivals</a></li>
                            </ul>
                        </li>
                        
                    </ul>
                    <form class="d-flex">
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="bi-cart-fill me-1"></i>
                            Cart
                            <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                        </button>
                    </form>
                </div>
            </div>
        </nav>
       <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Citizen Inc address:010-9078-2535</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- Bootstrap core JS-->
       
     </body>
</html>