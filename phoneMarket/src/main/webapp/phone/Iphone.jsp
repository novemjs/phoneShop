<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<body>
	<%@ include file="top.jsp" %>
	<sql:query var="an" dataSource="${conn }">
		select * from phone where kind='아이폰'
	</sql:query>
	<section class="py-1" style="font-family: 'Jua', sans-serif;">
		<div class="container px-4 px-lg-5 mt-5" >
			<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
				<c:forEach var="phone" items="${an.rows }" varStatus="status">
					<div class="card h-100" style="margin:10px;">
						<%-- 이미지를 클릭하면 phoneView.phone(상세보기 url)로 이동  --%>
						<a href="phoneView.phone?id=${phone.id }">
							<img class="card-img-top" style="height:300px;" src="${pageContext.request.contextPath}/resources/images/${phone.image}" id="productImage">
						</a>
						<div class="card-body p-4">
                               <div class="text-center">
                                   <!-- Product name-->
                                   <h5 class="fw-bolder">상품명:${phone.name }</h5>
                                   <!-- Product price-->
                                  	가격:<fmt:formatNumber value="${phone.price }" pattern="#,###,###" />원
                               </div>
                        </div>
					 </div>
					 </c:forEach>
	                </div>
				</div>
	</section>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>