<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="java.util.*" %>
<%@ page import="phoneshopping.vo.Phone" %>
<%@ page import="phoneshopping.dao.*" %>
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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    </head>
    <style>
    	.chat {
		    position: fixed;
		    right: 50px;
		    bottom: 50px;
		    width: 110px;
		    height: 100px;
		}
			ul{
			   list-style:none;
			   }
    </style>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top" style="font-family: 'Jua', sans-serif;">
        	
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#!" style="font-size:40px;"><i class="bi bi-phone"></i>Citizen</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item" style="font-size:20px;"><a class="nav-link active" aria-current="page" href="mainMenu.jsp">Home</a></li>
                        <li class="nav-item" style="font-size:20px;"><a class="nav-link" href="about.jsp">About</a></li>
                        <li class="nav-item dropdown"  style="font-size:20px;">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a  style="font-size:20px;" class="dropdown-item" href="http://localhost:8080/phoneMarket/phone/phoneList.phone">모든 제품</a></li>
                                <li><a  style="font-size:20px;" class="dropdown-item" href="../phone/androidPhone.jsp">안드로이드</a></li>
                                <li><a  style="font-size:20px;" class="dropdown-item" href="../phone/Iphone.jsp">아이폰</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown"  style="font-size:20px;">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">게시판</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a  style="font-size:20px;" class="dropdown-item" href="http://localhost:8080/phoneMarket/boardList.bo">자유 게시판</a></li>
                            </ul>
                        </li>

                    </ul>
                    <div class="navbar" style="margin:auto" >
                    	<div >
							<form method="get" class="search-form" action="../phone/searchPhone.jsp" >
								<input type="search" class="search-field" placeholder="상품명을 입력하세요" value="${param.findStr }" name="findStr" />
								<input class="btn btn-primary" type="submit"  name="btnFind" class="btn btn-default" value = "검색" />
								<input type="hidden" name="nowPage" value="${(empty param.nowPage)? 1: param.nowPage}" size="10">
								<input type="hidden" name="serial" size="10" >
								<input type="hidden" name="search" value="select">
					        </form>
				        </div>
					</div>
                    
					<%
						String findStr = "";
						if(request.getParameter("findStr") != null) {
							findStr = request.getParameter("findStr");
						}
						
						PhoneDAO phoneDAO=PhoneDAO.getInstance(); 
						ArrayList<Phone> list = phoneDAO.select(findStr);
						request.setAttribute("list", list);
				
					%>	
                    <form class="d-flex">
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="bi-cart-fill me-1"></i>
                            <a href="http://localhost:8080/phoneMarket/phone/phoneCartList.phone">장바구니</a>
                        </button>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
				    	<c:choose>
					    <c:when test="${empty sessionId}">
					    	<li><a  class="btn-lg " href="<c:url value="loginMember.jsp"/>"><span class="glyphicon glyphicon-user"></span><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-door-open" viewBox="0 0 16 16">
							  <path d="M8.5 10c-.276 0-.5-.448-.5-1s.224-1 .5-1 .5.448.5 1-.224 1-.5 1z"/>
							  <path d="M10.828.122A.5.5 0 0 1 11 .5V1h.5A1.5 1.5 0 0 1 13 2.5V15h1.5a.5.5 0 0 1 0 1h-13a.5.5 0 0 1 0-1H3V1.5a.5.5 0 0 1 .43-.495l7-1a.5.5 0 0 1 .398.117zM11.5 2H11v13h1V2.5a.5.5 0 0 0-.5-.5zM4 1.934V15h6V1.077l-6 .857z"/>
							  </svg>로그인</a></li>
					    	<li><a  class="btn-lg " href="<c:url value="addMember.jsp"/>"><span class="glyphicon glyphicon-log-in"></span><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-apple" viewBox="0 0 16 16">
							  <path d="M11.182.008C11.148-.03 9.923.023 8.857 1.18c-1.066 1.156-.902 2.482-.878 2.516.024.034 1.52.087 2.475-1.258.955-1.345.762-2.391.728-2.43zm3.314 11.733c-.048-.096-2.325-1.234-2.113-3.422.212-2.189 1.675-2.789 1.698-2.854.023-.065-.597-.79-1.254-1.157a3.692 3.692 0 0 0-1.563-.434c-.108-.003-.483-.095-1.254.116-.508.139-1.653.589-1.968.607-.316.018-1.256-.522-2.267-.665-.647-.125-1.333.131-1.824.328-.49.196-1.422.754-2.074 2.237-.652 1.482-.311 3.83-.067 4.56.244.729.625 1.924 1.273 2.796.576.984 1.34 1.667 1.659 1.899.319.232 1.219.386 1.843.067.502-.308 1.408-.485 1.766-.472.357.013 1.061.154 1.782.539.571.197 1.111.115 1.652-.105.541-.221 1.324-1.059 2.238-2.758.347-.79.505-1.217.473-1.282z"/>
							  <path d="M11.182.008C11.148-.03 9.923.023 8.857 1.18c-1.066 1.156-.902 2.482-.878 2.516.024.034 1.52.087 2.475-1.258.955-1.345.762-2.391.728-2.43zm3.314 11.733c-.048-.096-2.325-1.234-2.113-3.422.212-2.189 1.675-2.789 1.698-2.854.023-.065-.597-.79-1.254-1.157a3.692 3.692 0 0 0-1.563-.434c-.108-.003-.483-.095-1.254.116-.508.139-1.653.589-1.968.607-.316.018-1.256-.522-2.267-.665-.647-.125-1.333.131-1.824.328-.49.196-1.422.754-2.074 2.237-.652 1.482-.311 3.83-.067 4.56.244.729.625 1.924 1.273 2.796.576.984 1.34 1.667 1.659 1.899.319.232 1.219.386 1.843.067.502-.308 1.408-.485 1.766-.472.357.013 1.061.154 1.782.539.571.197 1.111.115 1.652-.105.541-.221 1.324-1.059 2.238-2.758.347-.79.505-1.217.473-1.282z"/>
							  </svg>회원가입</a></li>
					    </c:when>
							<c:when test="${sessionId=='admin'}">
								<li style="padding-top:8px; color:black;font-size:22px"><c:forEach var="row" items="${result.rows}"><c:out value="${row.name}"/></c:forEach>님</li>
							      <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">관리자용</a>
							        <ul class="dropdown-menu"  aria-labelledby="navbarDropdown">
						              <li><a class="dropdown-item" href="<c:url value="../phone/phoneRegistForm.jsp"/>">상품 등록</a></li>		
						              <li><a class="dropdown-item" href="<c:url value="http://localhost:8080/phoneMarket/phone/adminPhoneList.jsp"/>">상품 목록</a></li>
						              <li><a class="dropdown-item" href="<c:url value="memberList.jsp"/>">회원목록</a></li>
							          <li><a class="dropdown-item" href="<c:url value="logoutMember.jsp"/>">로그아웃 </a></li>
								      <li><a class="dropdown-item" href="<c:url value="http://localhost:8080/phoneMarket/phone/adminBoard.jsp"/>">게시판 관리</a></li>
								      <li><a class="dropdown-item" href="<c:url value="../phone/phoneSellList.jsp"/>">판매 현황</a></li>
							        </ul>
							      </li>  
							</c:when>
							<c:when test="${sessionId!='admin'}">
								<li style="padding-top:8px; color:black;font-size:22px"><c:forEach var="row" items="${result.rows}"><c:out value="${row.name}"/></c:forEach>님</li>
								<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">마이 페이지</a>
							        <ul class="dropdown-menu"  aria-labelledby="navbarDropdown">
						              <li><a class="dropdown-item" href="<c:url value="logoutMember.jsp"/>">로그아웃</a></li>		
						              <li><a class="dropdown-item" href="<c:url value="updateMember.jsp?id=${sessionId }"/>">회원 수정</a></li>
						              <li><a class="dropdown-item" href="<c:url value="deleteMember.jsp?id=${sessionId }"/>">회원 삭제 </a></li>              
						              <li><a class="dropdown-item" href="<c:url value="../phone/phonePurchaseList.jsp"/>">내 구매목록</a></li>
						              <li><a class="dropdown-item" href="<c:url value="../phone/phoneReview.jsp"/>">내 리뷰목록</a></li>
							        </ul>
							    </li>  
							</c:when>	
						 </c:choose>
				    </ul>
                </div>
            </div>
        </nav>
        <div id="carouselExampleIndicators" class="carousel slide carousel-dark" data-bs-ride="carousel">
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
		  </div>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="https://image.shop.kt.com/upload/link/577/1650526811694.png" class="d-block w-100" alt="...">
		      <map name="mapBig2">
				<area shape="rect" role="button" coords="419,245,558,283" onclick="location.href='http://localhost:8080/phoneMarket/phone/phoneView.phone?id=27'" alt="자세히보기">
				</map>
		    </div>
		    <div class="carousel-item">
		      <img src="https://image.shop.kt.com/upload/link/577/1643160932991.png" class="d-block w-100" alt="...">
		      <map name="mapBig8">
				<area shape="rect" role="button" coords="767,282,889,320" onclick="location.href='http://localhost:8080/phoneMarket/phone/phoneView.phone?id=24" target="_self" alt="자세히보기">
			  </map>
		    </div>
		    <div class="carousel-item">
		      <img src="https://image.shop.kt.com/upload/link/577/1648106397802.png" class="d-block w-100" alt="...">
		      <map name="mapBig2">
				<area shape="rect" role="button" coords="419,245,558,283" onclick="location.href='http://localhost:8080/phoneMarket/phone/phoneView.phone?id=25'" alt="자세히보기">
				</map>
		    </div>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
        
        <!-- Section-->
        <section class="py-5" style="font-family: 'Jua', sans-serif;">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=24"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/아이폰13pro.png" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">아이폰 13pro</h5>
                                    <!-- Product price-->
                                    가격:1,100,000원
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="http://localhost:8080/phoneMarket/phone/phoneCartAdd.phone?id=24">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=23"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/갤럭시 A32.png" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">갤럭시 A32</h5>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">600,000원</span>
                                    가격:580,000원
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="http://localhost:8080/phoneMarket/phone/phoneCartAdd.phone?id=23">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=29"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/z플립.jfif" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">갤럭시 z플립</h5>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">1,500,000원</span>
                                    가격:1,400,000원
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="http://localhost:8080/phoneMarket/phone/phoneCartAdd.phone?id=29">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=25"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/아이폰 se3세대.png" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">아이폰 se3</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    <!-- Product price-->
                                    가격:1,100,000원
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="http://localhost:8080/phoneMarket/phone/phoneCartAdd.phone?id=25">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=28"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/13미니.jfif" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">아이폰13미니</h5>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">900,000원</span>
                                    가격:800,000원
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="http://localhost:8080/phoneMarket/phone/phoneCartAdd.phone?id=28">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <a href="http://localhost:8080/phoneMarket/phone/phoneView.phone?id=27"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/갤럭시 jump.png" alt="..." /></a>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">갤럭시 jump</h5>
                                    <!-- Product price-->
                                    가격:340,000원
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="http://localhost:8080/phoneMarket/phone/phoneCartAdd.phone?id=27">장바구니 담기</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <img class="chat" src="${pageContext.request.contextPath}/resources/images/채팅이모티콘.png" onclick="location.href='chatting.jsp'">
        <!-- Footer-->
        <footer class="py-4 bg-dark " >
            <div class="container"><p style="font-size:20px;" class="m-0 text-center text-white"><i aria-hidden="true">Copyright &copy; Citizen Inc</i><br><i class="bi bi-telephone-inbound" aria-hidden="true"> Address:010-9078-2535</i><br><i class="bi bi-envelope" aria-hidden="true"> Email:wndtn94@naver.com</i></p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>

</html>