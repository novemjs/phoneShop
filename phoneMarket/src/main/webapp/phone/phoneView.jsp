<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="phoneshopping.vo.Phone" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
	
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<body>
<%@ include file="top.jsp" %>

 <sql:query dataSource="${conn }" var="rs">
	select * from review where id=?
	<sql:param value="${param.id }"></sql:param>
</sql:query> 
	<sql:query var="ip" dataSource="${conn }">
		select * from phone where kind='아이폰'
	</sql:query>
	<sql:query var="an" dataSource="${conn }">
	select * from phone where kind='안드로이드'
	</sql:query>

	<section id="listForm">
		<section id="content_left">
			<%-- <img src="../resources/images/${phone.image }"/> --%>
		</section>
		<section id="content_right">
		<%
			if(session.getAttribute("sessionId")!=null && session.getAttribute("sessionId").equals("admin")){
		%>
		<form action="phoneUpdate.phone?id=${phone.id }" method="post">
		<div class="table-responsive">
			<table class="table table-hover" style="text-align:center;">
				<tr>
					<td>기종:<input type="text" value="${phone.kind }" name="kind"></td>
				</tr>
				<tr>
					<td>이름:<input type="text" value="${phone.name }" name="name"></td>
				</tr>
				<tr>
					<td>색깔:<input type="text" value="${phone.color }" name="color"></td>
				</tr>
				<tr>
					<td>크기:<input type="text" value="${phone.size }" name="size"></td>
				</tr>
				<tr>	
					<td>화질:<input type="text" value="${phone.camera }" name="camera"></td>
				</tr>
				<tr>
					<td>가격:<input type="text" value="${phone.price }" name="price"></td>
				</tr>
				<tr>	
					<td>재고:<input type="text" value="${phone.stockqty }" name="stockqty"></td>
				</tr>
				<tr>	
					<td>내용:<textarea style="height:100px;" rows="13" cols="40" name="content">${phone.content }</textarea></td>
				</tr>
				<tr>	
					<td>이미지:<input type="file" value="${phone.image }" name="image"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="수정">
						<input type="submit" value="삭제" formaction="phoneRemove.phone?id=${phone.id }">
					</td>
					
				</tr>
			</table>
			</div>
		</form>
		<%
			}else if(session.getAttribute("sessionId")!=null && session.getAttribute("sessionId")!="admin"){
		%>
		
		 <section class="py-5" style="font-family: 'Jua', sans-serif;">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" src="../resources/images/${phone.image }" alt="..." /></div>
                    <div class="col-md-6">
                        <div class="small mb-1">CITIZEN:</div>
                        <h2 class="display-5 fw-bolder">${phone.name }</h2>
                        <div class="fs-5 mb-5">
                            <span>기종:${phone.kind }</span><br>
                            <span>크기:${phone.size}</span><br>
                            <span>색깔:${phone.color }</span><br>
                            <span>가격:<fmt:formatNumber value="${phone.price }" pattern="#,###,###" />원</span>
                          
                        </div>
                        
                        <p class="lead">${phone.content }</p>
                        <div class="d-flex">
                        	<button class="btn btn-outline-dark flex-shrink-0" onclick="location.href='http://localhost:8080/phoneMarket/phone/phoneList.phone'">쇼핑 계속하기</button>&nbsp;&nbsp;&nbsp;
                            <c:if test="${phone.stockqty!=0 }">
	                            <button class="btn btn-outline-dark flex-shrink-0" type="button" onclick="location.href='phoneCartAdd.phone?id=${phone.id }'">
	                                <i class="bi-cart-fill me-1"></i>
	                                장바구니 추가
	                            </button>
	                        </c:if>
                            <c:if test="${phone.stockqty==0 }">
                            	<h4 style="color:red;">품절되었습니다!</h4>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </section>
		<%
			}else {
				out.println("<script>");
				out.println("alert('로그인이 필요합니다!')");
				out.println("location.href='../member/loginMember.jsp'");
				out.println("</script>");
			}
		%>
		</section>
		<div style="clear:both"></div>
		
		<br>
		<c:if test="${phone.kind=='안드로이드' }">
			<section class="py-5 bg-light" style="font-family: 'Jua', sans-serif;">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">관련 상품들</h2>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                	<c:forEach var="andro" items="${an.rows }">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="../resources/images/${andro.image }" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${andro.name }</h5>
                                    <!-- Product price-->
                                    가격:<fmt:formatNumber value="${andro.price }" pattern="#,###,###" />원
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="phoneView.phone?id=${andro.id }">상세보기</a></div>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
             </div>
        </section>
		</c:if>
		<c:if test="${phone.kind=='아이폰' }">
			<section class="py-5 bg-light" style="font-family: 'Jua', sans-serif;">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">관련 상품들</h2>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                	<c:forEach var="iphone" items="${ip.rows }">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="../resources/images/${iphone.image }" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${iphone.name }</h5>
                                    <!-- Product price-->
                                    가격:<fmt:formatNumber value="${iphone.price }" pattern="#,###,###" />원
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="phoneView.phone?id=${iphone.id }">상세보기</a></div>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
             </div>
        </section>
		</c:if>
		
		
	</section>
	<hr>
	<div style="font-family: 'Jua', sans-serif;">
		<h2 style="text-align:center; background-color:lightgrey;height:50px;">Review</h2><br>
			<c:forEach var="re" items="${rs.rows }" varStatus="status">
				<table class="table table-striped">
					<tr id="tr_top" class="table-primary" style="text-align:center" >
						<th>#</th>
						<th>작성자</th>
						<th>리뷰내용</th>
						<th>등록일자</th>
						<c:if test="${sessionId=='admin' }">
							<th>리뷰삭제</th>
						</c:if>
					</tr>
					<tr style="text-align:center">
						<td>${status.count }</td>
						<td>${re.userid }</td>
						<td>${re.review }</td>
						<td>${re.regdate }</td>
						<c:if test="${sessionId=='admin' }">
							<td>
							<form action="reviewDelete.phone" method="post">
								<input type="hidden" value="${re.review_num }" name="num">
								<input type="submit" value="리뷰삭제" formaction="reviewDelete.phone">
							</form>
							</td>
						</c:if>
					</tr>
				</table>
			</c:forEach>
	</div>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>