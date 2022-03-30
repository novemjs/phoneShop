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

    <%
    	String userId=(String)session.getAttribute("sessionId");
    	int totalAmt=Integer.parseInt(request.getParameter("totalAmt"));
    	ArrayList<Cart> alist=(ArrayList<Cart>)session.getAttribute("cartList");
    	
    	String nameList="";//초기값
    	
    	for(int i=0;i<alist.size();i++){
    		 if(alist.get(i).getName() != null){
    			 nameList += alist.get(i).getName()+" ";
    		 }
    		 
    	}
    	if(userId!=null){
    %>
	<h2 style="text-align:center;">주문자 정보</h2>
		<form action="phoneOrder.phone" method="post">
			<table style="margin:auto;">
				<tr>
					<td>주문한 핸드폰:</td>
					<td><%=nameList %></td>
				</tr>
				<tr>
					<td>아이디:</td>
					<td>
						<input type="text" name="id">
					</td>
				</tr>
				<tr>
					<td>
						이름:
					</td>
					<td>
						<input type="text" name="name">
					</td>
				</tr>
				<tr>
					<td>우편번호:</td>
					<td>
						<input type="text" name="postcd" id="postcd">
						<input type="button" value="우편번호 찾기" onclick="Postcode()">
					</td>
				</tr>
				<tr>
					<td>주소:</td>
					<td><input type="text" name="addr1" id="addr1" ></td>
				</tr>
				<tr>
					<td>상세주소:</td>
					<td><input type="text" name="addr2" id="addr2" ></td>
				</tr>
				<tr>
					<td>연락처:</td>
					<td><input type="text" name="phone" ></td>
				</tr>
				<tr>
					<td>메모:</td>
					<td><textarea rows="5" cols="30" name="memo"></textarea></td>
				</tr>
				<tr>
					<td>주문금액:</td>
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
		
	<%}%>
</body>
</html>