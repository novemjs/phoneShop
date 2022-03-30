<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="phoneshopping.vo.Phone" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<style>
	#listForm{
		width:700px;
		height:500px;
		border:1px solid red;
		margin:auto;
		background-color:lightgreen;
	}
	h2{
		text-align:center;
	}
	table{
		
		margin:auto;
		width:550px;
		border-collapse:collapse;
	}
	td{
		text-align:center;
		border:1px solid;
	}
	.div_empty{
		background-color:red;
		width:100%;
		height:100%;
		text-align:center;
	}
	#todayImageList{
		text-align:center;
	}
	#productImage{
		width:150px;
		height:150px;
		border:none;
		object-fit:cover;
	}
	#todayImage{
		width:100px;
		height:100px;
		border:none;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="top.jsp" %>
	<section id="listForm">
		<c:if test="${phoneList!=null }">
			
			<table>
				<tr>
					<%-- varStatus:행의 상태값을 가져올수 잇다 --%>
					<c:forEach var="phone" items="${phoneList }" varStatus="status">
						<td style="text-align:cetner">
							<%-- 이미지를 클릭하면 phoneView.phone(상세보기 url)로 이동  --%>
							<a href="phoneView.phone?id=${phone.id }">
								<img style="" src="${pageContext.request.contextPath}/resources/images/${phone.image}" id="productImage">
							</a>
							상품명:${phone.name }<br>
							가격:${phone.price }<br>
						</td>
						<%-- 강아지 목록을 4개씩 화면에 출력 mod=%와 같다 --%>
						<c:if test="${((status.index+1)mod 4)==0 }">
				</tr>
				<tr>
						</c:if>
					</c:forEach>
				</tr>
			</table>
		</c:if>
		<c:if test="${phoneList==null }">
			<div class="div_empty">
				휴대폰이 없습니다.
			</div>
		</c:if>
		<%-- 강아지 목록 화면 하단에 오늘 클릭한 강아지 내역을 보여주기 위한 처리 --%>
		<c:if test="${todayImageList!=null }">
			<div id="todayImageList">
				<h2>오늘 본 상품 목록</h2>
				<table>
					<tr>
						<c:forEach var="todayImage" items="${todayImageList }" varStatus="status">
						<td>
							<img src="../resources/images/${todayImage }" id="todayImage"/>
						</td>
							<%-- 오늘 클릭한 강아지 정보도 한행에 4개씩 출력 --%>
							<c:if test="${((status.index+1)mod 4)==0 }">
					</tr>
					<tr>
							</c:if>
						</c:forEach>
					</tr>
				</table>
			</div>
		</c:if>
	</section>
</body>
</html>