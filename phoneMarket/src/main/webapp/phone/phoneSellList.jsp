<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="phoneshopping.vo.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<script type="text/javascript">
   
	$(document).ready(function () {
    	
            $.datepicker.setDefaults($.datepicker.regional['ko']); 
            $( "#startDate" ).datepicker({
            	 showOn:"button",
            	 buttonImage:"../resources/images/달력아이콘.png",
            	 buttonImageOnly:true,
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yymmdd",
                 maxDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
                 onClose: function( selectedDate ) {    
                      //시작일(startDate) datepicker가 닫힐때
                      //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                     $("#endDate").datepicker( "option", "minDate", selectedDate );
                 }    
 
            });
            $( "#endDate" ).datepicker({
            	 showOn:"button",
            	 buttonImage:"../resources/images/달력아이콘.png",
            	 buttonImageOnly:true,
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yymmdd",
                 maxDate: 0,                       // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
                 onClose: function( selectedDate ) {    
                     // 종료일(endDate) datepicker가 닫힐때
                     // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
                     $("#startDate").datepicker( "option", "maxDate", selectedDate );
                 }    
 
            });    
    });
	function sub(){
		var x = frm.sel1.value;
		$('input[name=pid]').attr('value',x);
		
	}
	
</script>
<body>
<%@ include file="top.jsp" %>


<form method="get">
<table class="table table-striped" style="margin:auto; text-align:center;font-family: 'Jua', sans-serif;">
	<tr>
		<td>기간</td>	
	</tr>
	<tr>
		<td>
			<input type="hidden" value="" name="pid">
			<input type="text" id="startDate" name="startDate" value="${param.startDate }" readonly="readonly">  -
			<input type="text" id="endDate" name="endDate" value="${param.endDate }" readonly="readonly">
			<input type="submit" value="검색" class="btn btn-primary">
		</td>
	</tr>
</table>
</form>
	<%
		String startDate="";
		String endDate="";
		String pcode="";
		if(request.getParameter("startDate") != null && request.getParameter("endDate") != null && request.getParameter("pid")!=null) {
			startDate = request.getParameter("startDate");
			endDate=request.getParameter("endDate");
			pcode=request.getParameter("pid");
		}
		 
		ArrayList<Order> sellList = phoneDAO.searchDate(startDate,endDate,pcode);
		request.setAttribute("sellList", sellList);
	
	%>
	<sql:query dataSource="${conn}" var="as">
	   select sum(orderPrice) as totalPrice from orderphone where DATE_FORMAT(orderDate, '%Y%m%d') between ? and ? and cast(id as char) like ?
	   <sql:param value="${param.startDate }"/> 
	   <sql:param value="${param.endDate }"/> 
	   <sql:param value="<%=pcode %>"/>
	</sql:query>
	<% 
		String driverName="com.mysql.jdbc.Driver";
	    String url="jdbc:mysql://localhost:3306/phoneshop";
	    String user="phone";
	    String pw="phone1234";
    %>
	<form name="frm">
		<%
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try{
			Class.forName(driverName);
			con=DriverManager.getConnection(url,user,pw);
			int id=0;
			String pname=null;
			
			String sql="select * from phone";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
		 %>
		<p style="text-align:center;font-family: 'Jua', sans-serif;">휴대폰 선택 : 
		<select name="sel1" id="selectlist" onchange="sub();">
				<option value="">종류를 선택하십시오</option>
	            <option value="%">전체</option>
			<%
				while (rs.next()) {
					id = rs.getInt("id");
					pname=rs.getString("name");
			%>
	
			<option value="<%=id%>"><%=pname%></option>
			<%
				}
			%>
		</select>
		<%
		}catch(Exception e){
			out.println(e);
		}
		%>
	</form>	
	<br>
	<%if(sellList.isEmpty()){ %>
		<p style="text-align:center;font-family: 'Jua', sans-serif;">검색결과가 없습니다.
	<%}else{ %> 
	<c:forEach var="sell" items="${sellList }">
		<table class="table table-striped">
			<tr id="tr_top" class="table-primary">
				<td>주문번호</td>
				<td>주문한 핸드폰</td>
				<td>주문 갯수</td>
				<td>주문한 유저 아이디</td>
				<td>주문한고객 이름</td>
				<td>주문 일자</td>
				<td>주문 금액</td>
				<td>배송 여부</td>
			</tr>
			<tr>
				<td><c:out value="${sell.ordersnt }"/></td>
				<td><c:out value="${sell.phoneName }"/></td>
				<td><c:out value="${sell.cnt }개"/></td>
				<td><c:out value="${sell.userid }"/></td>
				<td><c:out value="${sell.name }"/></td>
				<td><c:out value="${sell.orderDate }"/></td>
				<td><c:out value="${sell.price }원"/></td>
				<!-- 주문 상태 -->
				<c:if test="${sell.ordering eq '배송준비중' }">
					<form action="phoneSend.phone" method="post">
					<td>
						<input type="hidden" value="${sell.ordersnt }" name="ordersnt">
						<input type="submit" value="배송하기">
					</td>
					</form>
				</c:if>
				<c:if test="${sell.ordering ne '배송준비중' }">
					<td><c:out value="배송완료"/></td>
				</c:if>
			</tr>
		</table>
	</c:forEach>
	<%} %>
	
	<c:forEach var="all" items="${as.rows }">
		<h4 style="text-align:center;font-family: 'Jua', sans-serif;">총 판매금액:<c:out value="${all.totalPrice }원"/></h4>
	</c:forEach>
	<%@ include file="googleChart.jsp" %> 
	<%@ include file="../member/bottom.jsp" %>

</body>
</html>