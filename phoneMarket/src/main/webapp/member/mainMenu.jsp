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
				<li style="padding-top:8px; padding-right:30px; color:black;font-size:30px"><c:forEach var="row" items="${result.rows}"><c:out value="${row.name}"/></c:forEach>님</li>
			      <li class="dropdown"><a class="btn-lg dropdown-toggle" data-toggle="dropdown" href="#">관리자용</a>
			        <ul class="dropdown-menu">
		              <li class="list-group-item" style="font-size:20px;"><a href="<c:url value="../phone/phoneRegistForm.jsp"/>">상품 등록</a></li>		
		              <li class="list-group-item" style="font-size:20px;"><a href="<c:url value="http://localhost:8080/phoneMarket/phone/phoneList.phone"/>">상품 목록</a></li>
		              <li class="list-group-item" style="font-size:20px;"><a href="<c:url value="memberList.jsp"/>">회원목록</a></li>
			          <li class="list-group-item" style="font-size:20px;"><a href="<c:url value="logoutMember.jsp"/>">로그아웃 </a></li>
				      <li class="list-group-item" style="font-size:20px;"><a href="<c:url value="deleteMember.jsp"/>">회원 삭제</a></li>
			        </ul>
			      </li>  
			</c:when>
			<c:when test="${sessionId!='admin'}">
				<li style="padding-top:8px; color:black;font-size:22px"><c:forEach var="row" items="${result.rows}"><c:out value="${row.name}"/></c:forEach>님</li>
				<li style="font-weight:bold" class="nav-item"><a class="btn-lg nav-link" href="<c:url value="logoutMember.jsp"/>">로그아웃 </a></li>
				<li style="font-weight:bold" class="nav-item"><a class="btn-lg nav-link" href="<c:url value="updateMember.jsp?id=${sessionId }"/>">회원수정</a></li>
				<li style="font-weight:bold" class="nav-item"><a class="btn-lg nav-link" href="<c:url value="deleteMember.jsp?id=${sessionId }"/>">회원삭제</a></li>
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
                        <li class="nav-item" style="font-size:20px;"><a class="nav-link active" aria-current="page" href="mainMenu.jsp">Home</a></li>
                        <li class="nav-item" style="font-size:20px;"><a class="nav-link" href="#!">About</a></li>
                        <li class="nav-item dropdown"  style="font-size:20px;">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a  style="font-size:20px;" class="dropdown-item" href="http://localhost:8080/phoneMarket/phone/phoneList.phone">모든 제품</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a  style="font-size:20px;" class="dropdown-item" href="#!">인기상품</a></li>
                              
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"  style="font-size:20px;">게시판</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a  style="font-size:20px;" class="dropdown-item" href="http://localhost:8080/phoneMarket/boardList.bo">자유 게시판</a></li>
                            </ul>
                        </li>
                        
                    </ul>
                    <form class="d-flex">
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="bi-cart-fill me-1"></i>
                            <a href="http://localhost:8080/phoneMarket/phone/phoneCartList.phone">장바구니</a>
                            <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                        </button>
                    </form>
                </div>
            </div>
        </nav>
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Shop in style</h1>
                    <p class="lead fw-normal text-white-50 mb-0">ddd</p>
                </div>
            </div>
        </header>
        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=4"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/아이폰13.jfif" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">아이폰 13</h5>
                                    <!-- Product price-->
                                    1300000
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=13"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/아이폰11pro.jfif" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">아이폰 11pro</h5>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">1500000</span>
                                    1400000
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=10"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/z플립.jfif" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">갤럭시 z플립</h5>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">1500000</span>
                                    1400000
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=4"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/s22.jfif" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">갤럭시 s22</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    <!-- Product price-->
                                    800000
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=9"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/s21.jfif" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">아이폰se2</h5>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">$50.00</span>
                                    700000
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=11"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/a12.jfif" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">갤럭시 a12</h5>
                                    <!-- Product price-->
                                    250000
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p style="font-size:20px;" class="m-0 text-center text-white">Copyright &copy; Citizen Inc address:010-9078-2535</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
