<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.HashMap" %>
<%@ page import="phoneshopping.vo.Phone" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="phoneshopping.dao.PhoneDAO" %>
<%@page import="java.sql.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	/* #product_list{
		display:flex;
		flex:0 1 100px;
	} */
	#product_total{
		text-align:center;
	}
</style>
<body>
	<%@ include file="top.jsp" %>
	
	<div id="cont-wrap" style="text-align:center;font-family: 'Jua', sans-serif;">
		<div class="cate_top_txt"><h3>Search</h3></div>
    </div>
	<div class="search_bar" style="text-align:center;font-family: 'Jua', sans-serif;">
		<form method="get" class="search-form" >
			<input type="search" class="search-field" placeholder="상품명" value="${param.findStr }" name="findStr" />
			<input type="submit"  name="btnFind" class="search-submit" value = "검색"/>
			<input type="hidden" name="nowPage" value="${(empty param.nowPage)? 1: param.nowPage}" size="10">
			<input type="hidden" name="serial" size="10" >
			<input type="hidden" name="search" value="select">
        </form>
	</div>
	
        <div class = "product_middle">	
			<div id = "product_total">
				<p>Total&nbsp;:&nbsp;&nbsp;<span>${fn:length(list) }</span></p>
			</div>
		</div>
		
		<div id = "product_list" style="text-align:center;font-family: 'Jua', sans-serif;">
		<% if(list.isEmpty()) {%>
			검색결과없음
		<%}else {%>
	<section class="py-1" style="font-family: 'Jua', sans-serif;" >
		<div class="container px-4 px-lg-5 mt-5" >
			<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
				<c:forEach var="vo" items="${list }" varStatus="status">
					<div class="card h-100" style="margin:10px;">
						<img class="card-img-top" style="" src="../resources/images/${vo.image}" id="productImage">
						<div class="card-body p-4">
                               <div class="text-center">
                                   <!-- Product name-->
                                   ${vo.name}<br>
                                   <button onclick="location.href='phoneView.phone?id=${vo.id }' " class="btn btn-primary">상세보기</button>
	                  			   <div id="detail"><br><fmt:formatNumber value="${vo.price }" pattern="#,###" />원</div>
                               </div>
                        </div>
					 </div>
					 </c:forEach>
	                </div>
				</div>
	</section>
	<%} %>
	
		<%@ include file="../member/bottom.jsp" %>
</body>
</html>