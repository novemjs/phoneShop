<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phoneshopping.vo.Cart" %>
<%@ page import="phoneshopping.dao.PhoneDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
	#listForm{
		width:640px;
		border:1px solid red;
		margin:auto;
	}
	h2{
		text-align:center;
	}
	table{
		width:550px;
		margin:auto;
	}
	.tr_top{
		background-color:lime;
	}
	.div_empty{
		text-align:center;
		background-color:
	}
	.td_command{
		text-align:right;
	}
	#todayImageList{
		text-align:center;
	}
	#productImage{
		width:150px;
		height:150px;
		border:none;
	}
	#cartImage{
		width:70px;
		height:70px;
		border:none;
	}
	#select{
		text-align:center;
	}
	#commandList{
		text-align:center;
	}
	#upImage{
		width:15px;
	}
	#downImage{
		width:15px;
	}
</style>
<script>
	//장바구니 화면에서 삭제처리시 체크박스 체크여부를 확인하는 함수
	function checkAll(theForm){
		if(theForm.remove.length==undefined){
			theForm.remove.checked=theForm.allCheck.checked;
		}else{
			for(var i=0;i<theForm.remove.length;i++){
				theForm.remove[i].checked=theForm.allCheck.checked;
			}
		}
	}
	
	//매개변수(개품종,수량)
	function checkQty(kind,qty){
		if(qty!=1){
			location.href="phoneCartQtyDown.phone?name="+name; //encodeURIComponent(kind)
		}
	}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="top.jsp" %>

	<%-- 장바구니를 강아지 단가로 검색 --%>
	<c:if test="${startMoney!=null }">
		<c:set var="startMoney" value="${startMoney }"></c:set>
	</c:if>
	<c:if test="${endMoney!=null }">
		<c:set var="endMoney" value="${endMoney }"></c:set>
	</c:if>
	<section id="listForm">
		<%-- 장바구니에 내역이 존재하면 --%>
		<c:if test="${cartList!=null && cartList.size()>0 }">
			<h2>장바구니 목록</h2>
			<form action="phoneOrder.jsp" method="post">
				<table>
					<tr id="select">
						<td colspan="6">
							<select id="startMoney" name="startMoney">
								<option>=최하=</option>
								<c:choose>
									<c:when test="${startMoney==1000}">
										<option selected="selected">1000</option>
										<option>2000</option>
										<option>3000</option>
										<option>4000</option>
									</c:when>
									<c:when test="${startMoney==2000 }">
										<option>1000</option>
										<option selected="selected">2000</option>
										<option>3000</option>
										<option>4000</option>
									</c:when>
									<c:when test="${startMoney==3000 }">
										<option>1000</option>
										<option>2000</option>
										<option selected="selected">3000</option>
										<option>4000</option>
									</c:when>
									<c:when test="${startMoney==4000 }">
										<option>1000</option>
										<option>2000</option>
										<option>3000</option>
										<option selected="selected">4000</option>
									</c:when>
									<c:otherwise>
										<option>1000</option>
										<option>2000</option>
										<option>3000</option>
										<option>4000</option>
									</c:otherwise>
								</c:choose>
							</select>
							<select id="endMoney" name="endMoney">
								<option>=최고=</option>
								<c:choose>
									<c:when test="${endMoney==1000 }">
										<option selected="selected">1000</option>
										<option>2000</option>
										<option>3000</option>
										<option>4000</option>
									</c:when>
									<c:when test="${endMoney==2000 }">
										<option>1000</option>
										<option selected="selected">2000</option>
										<option>3000</option>
										<option>4000</option>
									</c:when>
									<c:when test="${endMoney==3000 }">
										<option>1000</option>
										<option>2000</option>
										<option selected="selected">3000</option>
										<option>4000</option>
									</c:when>
									<c:when test="${endMoney==4000 }">
										<option>1000</option>
										<option>2000</option>
										<option>3000</option>
										<option selected="selected">4000</option>
									</c:when>
									<c:otherwise>
										<option>1000</option>
										<option>2000</option>
										<option>3000</option>
										<option>4000</option>
									</c:otherwise>
								</c:choose>
							</select>
							<input type="submit" value="검색" formaction="phoneCartSearch.phone">
						</td>
					</tr>
					<tr class="tr_top">
						<td><input type="checkbox" id="allCheck" name="allCheck" onclick="checkAll(this.form)"></td>
						<td>번호</td>
						<td>상품 이미지</td>
						<td>상품명</td>
						<td>가격</td>
						<td>수량</td>
					</tr>
					<%-- 장바구니 내역을 출력 --%>
					<c:forEach var="cart" items="${cartList }" varStatus="status">
						<tr>
							
							<td>
								<input type="checkbox" id="remove" name="remove" value="${cart.name }">
							</td>
							<td>
								${status.index+1 } <%-- 장바구니 일련번호  index+1을 count로 표기해도됨--%>
							</td>
							<td>
								<img src="../resources/images/${cart.image }" id="cartImage">
							</td>
							<td>
								${cart.name }
							</td>
							<td>
								${cart.price }
							</td>
							<td>
								<a href="phoneCartQtyUp.phone?name=${cart.name }">
									<img src="../resources/images/up.jpg" id="upImage" border=0>
								</a><br>
								${cart.qty }<br>
								<a href="javascript:checkQty('${cart.name }',${cart.qty })">
									<img src="../resources/images/down.jpg" id="downImage" border=0>
								</a>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="5" style="text-align:center;">
							총 금액:${totalMoney }원
						</td>
					</tr>
					<tr>
						<td colspan="5" style="text-align:center;">
							<input type="submit" value="삭제" formaction="phoneCartRemove.phone">
						</td>
					</tr>
				</table>
				<input type="hidden" name="totalAmt" value="<c:out value='${totalMoney}'/>">
				<a style="text-align:center" href="phoneList.phone">쇼핑 계속하기</a>&nbsp;&nbsp;&nbsp;
				<input type="submit" value="주문" style="text-align:center;">
			</form>
		</c:if>
		<c:if test="${cartList==null }">
			<section class="div_empty">
				상품 정보가 없습니다.
			</section>
		</c:if>
		<nav id="commandList">

		</nav>
	</section>
</body>
</html>