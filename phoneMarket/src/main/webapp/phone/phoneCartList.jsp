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
		border:1px;
		margin:auto;
	}
	h2{
		text-align:center;
	}
	table{
		width:550px;
		margin:auto;
	}
	.div_empty{
		text-align:center;
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
<script src="http://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script>
	//장바구니 화면에서 체크박스체크 하지 않았을때 처리
	function removeSubmit() {
		var Form = document.listForm;
		if($("input:checkbox[name=remove]").is(":checked") == true){
			Form.action="phoneCartRemove.phone";
		    Form.submit();
		}else{
			if(confirm("삭제할 항목을 선택하지 않았습니다. 장바구니 전체를 비우게 됩니다. 전부 삭제하시겠습니까?")) {
			       alert("장바구니를 비웁니다.");
			       document.getElementById("allCheck").click();
			       Form.action="phoneCartRemove.phone";
			       Form.submit();
			}else {
			       alert("삭제할 항목을 선택해주세요.");
			}
		}
		
	 } 
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
	function checkQty(name,qty){
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
	<br><br>
	<div style="text-align:center;">
		<img src="http://cdn6-kinx.makeshop.co.kr/design/smblue111/wib_2020/img/cart/step1.png">
	</div>
	
	<br><br>
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
			<h2>장바구니</h2>
			<form action="phoneOrder.jsp" method="post" name="listForm">
				<table class="table">
					<tr id="select">
						<td colspan="6">
							<select id="startMoney" name="startMoney">
								<option>=최하=</option>
								<c:choose>
									<c:when test="${startMoney==1000}">
										<option selected="selected">0</option>
										<option>300000</option>
										<option>600000</option>
										<option>100000</option>
									</c:when>
									<c:when test="${startMoney==300000 }">
										<option>0</option>
										<option selected="selected">300000</option>
										<option>600000</option>
										<option>1000000</option>
									</c:when>
									<c:when test="${startMoney==600000 }">
										<option>0</option>
										<option>300000</option>
										<option selected="selected">600000</option>
										<option>1000000</option>
									</c:when>
									<c:when test="${startMoney==1000000 }">
										<option>0</option>
										<option>300000</option>
										<option>600000</option>
										<option selected="selected">1000000</option>
									</c:when>
									<c:otherwise>
										<option>0</option>
										<option>300000</option>
										<option>600000</option>
										<option>1000000</option>
									</c:otherwise>
								</c:choose>
							</select>
							<select id="endMoney" name="endMoney">
								<option>=최고=</option>
								<c:choose>
									<c:when test="${endMoney==300000 }">
										<option selected="selected">300000</option>
										<option>600000</option>
										<option>1000000</option>
										<option>1300000</option>
									</c:when>
									<c:when test="${endMoney==600000 }">
										<option>300000</option>
										<option selected="selected">600000</option>
										<option>1000000</option>
										<option>1300000</option>
									</c:when>
									<c:when test="${endMoney==1000000 }">
										<option>300000</option>
										<option>600000</option>
										<option selected="selected">1000000</option>
										<option>1300000</option>
									</c:when>
									<c:when test="${endMoney==1300000 }">
										<option>300000</option>
										<option>600000</option>
										<option>1000000</option>
										<option selected="selected">1300000</option>
									</c:when>
									<c:otherwise>
										<option>300000</option>
										<option>600000</option>
										<option>1000000</option>
										<option>1300000</option>
									</c:otherwise>
								</c:choose>
							</select>
							<input type="submit" value="검색" formaction="phoneCartSearch.phone">
						</td>
					</tr>
							
					<colgroup>
						<col width="75">
						<col width="100">
						<col width="130">
						<col width="130">
						<col width="130">
						<col width="130">
						
					</colgroup>
					<tr class="tr_top" class="table-info">
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
							<input type="button" id="removeph" value="삭제" onclick="removeSubmit();" class="btn btn-warning">
						</td>
					</tr>
				</table>
				<input type="hidden" name="totalAmt" value="<c:out value='${totalMoney}'/>">
				<button class="btn btn-success" onclick="location.href='phoneList.phone'">쇼핑 계속하기</button>&nbsp;&nbsp;&nbsp;
				<input type="submit" value="주문" style="text-align:center;" class="btn btn-primary">
			</form>
		</c:if>
		<c:if test="${cartList.size()==0 }">
			<div style="text-align:center;">
				<h3>상품정보가 없습니다</h3>
				<button class="btn btn-success" onclick="location.href='http://localhost:8080/phoneMarket/phone/phoneList.phone'">상품목록으로 가기</button>
			</div>
		</c:if>
		<nav id="commandList">
	
		</nav>
		
	</section>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>