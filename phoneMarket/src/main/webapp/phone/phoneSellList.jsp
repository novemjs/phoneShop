<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="phoneshopping.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int orderPrice=0;
		ArrayList<Order> orderlist=new ArrayList<>();
		for(int i=0;i<orderlist.size();i++){
			orderPrice+=orderlist.get(i).getOrderPrice();
		}
	%>
	<form action="#" method="post">
		<table>
			<tr>
				<td>총 팔린 금액:</td>
				<td><%=orderPrice %></td>
			</tr>
			<tr>
				<td>남은재고:</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
			</tr>
			<tr>
				
			</tr>
		</table>
	</form>
</body>
</html>