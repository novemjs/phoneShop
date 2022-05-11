<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="phoneshopping.vo.Cart" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="java.util.List" %>
    <%@ page import="phoneshopping.vo.Cart" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script>
	function order(){
		alert("주문 완료 되었습니다!");	
	}
</script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function Postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("addr2").value = extraAddr;
                
                } else {
                    document.getElementById("addr2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcd').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("postcd").focus();
            }
        }).open();
    }
</script>
<body>
<%@ include file="top.jsp" %>
	<sql:query dataSource="${conn}" var="rs">
		select * from member where id=?
		<sql:param value="<%=sessionId %>"/>
	</sql:query>
	

    <%
    	String userId=(String)session.getAttribute("sessionId");
    	int totalAmt=Integer.parseInt(request.getParameter("totalAmt"));
    	ArrayList<Cart> alist=(ArrayList<Cart>)session.getAttribute("cartList");

    	String nameList="";//초기값
    	int idList=0;
    	int totalCnt=0;
    	
    	for(int i=0;i<alist.size();i++){
    		totalCnt += alist.get(i).getQty();
    		if(alist.get(i).getName() != null){
    			nameList = alist.get(i).getName()+" ";
    			idList=alist.get(i).getId();
    		}
    		alist.get(i).getId();
    	}
    	session.setAttribute("nameList", nameList);
    	if(userId!=null){
    %>
    <br>
    <div style="text-align:center;">
		<img src="http://cdn6-kinx.makeshop.co.kr/design/smblue111/wib_2020/img/cart/step2.png">
	</div>
	<br>
    <c:forEach var="ord" items="${rs.rows }">
	<h2 style="text-align:center;">주문자 정보</h2>
		<form action="phoneOrder.phone" method="post">
			<c:forEach var="cart" items="${cartList }">
			<table class="table table-hover" style="width:500px;margin:auto;">
				<tr>
					<td>주문한 핸드폰:</td>
					<td>
						<input type="text" name="phoneName" value="${cart.name }" readonly="readonly">
						<input type="hidden" name="phoneId" value="${cart.id }">
					</td>
				</tr>
				<tr>
					<td>아이디:</td>
					<td>
						<input type="text" name="userId" value="${ord.id }" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>
						이름:
					</td>
					<td>
						<input type="text" name="name" value="${ord.name }" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>우편번호:</td>
					<td>
						<input type="text" name="postcd" id="postcd" value="${ord.postcd }">
						<input type="button" value="우편번호 찾기" onclick="Postcode()">
					</td>
				</tr>
				<tr>
					<td>주소:</td>
					<td><input type="text" name="addr1" id="addr1" value="${ord.addr1 }"></td>
				</tr>
				<tr>
					<td>상세주소:</td>
					<td><input type="text" name="addr2" id="addr2" value="${ord.addr2 }"></td>
				</tr>
				<tr>
					<td>연락처:</td>
					<td><input type="text" name="phone" value="${ord.phone }"></td>
				</tr>
				<tr>
					<td>메모:</td>
					<td><textarea rows="5" cols="30" name="memo"></textarea></td>
				</tr>
				<tr>
					<td>주문갯수:</td>
					<td>
						<input type="text" name="cnt" value="${cart.qty }" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>주문 금액:</td>
					<td>
						<input type="text" name="price" value="${cart.price }" readonly="readonly">
					</td>
				</tr>
				<br><hr>
				</c:forEach>
				
				<tr>
					<td>총 주문갯수:</td>
					<td><input type="text" name="totalCnt" value="<%=totalCnt %>"></td>
				</tr>
				
				<tr>
					<td>총 주문금액:</td>
					<td><%=totalAmt %>원 <input type="hidden" name="orderPrice" value="<%=totalAmt %>"> 
				</tr>
				<tr>
					<td colspan="2" align=center>
						<input type="submit" value="결제" onclick="order();">
						<input type="reset" value="다시작성">
					</td>
				</tr>
			</table>
		</form>
	</c:forEach>
		
	<%}%>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>