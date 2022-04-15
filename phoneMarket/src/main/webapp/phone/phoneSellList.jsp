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
		ArrayList<Phone> sellList=(ArrayList<Phone>)request.getAttribute("phoneList");
		int orderPrice=0;
		ArrayList<Order> orderlist=new ArrayList<>();
		for(int i=0;i<orderlist.size();i++){
			orderPrice+=orderlist.get(i).getOrderPrice();
		}
		
		String nameList="";//초기값
    	String priceList="";
    	
    	for(int i=0;i<sellList.size();i++){
    		 if(sellList.get(i).getName() != null){
    			 nameList += sellList.get(i).getName()+" ";
    		 }
    		 priceList+=sellList.get(i).getPrice()+" ";
    		
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