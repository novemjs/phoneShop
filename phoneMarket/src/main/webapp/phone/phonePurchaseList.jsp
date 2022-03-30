<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="java.util.*" %>
<%@ page import="phoneshopping.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="top.jsp" %>
	<%
    	
    	ArrayList<Cart> alist=(ArrayList<Cart>)session.getAttribute("cartList");
    	
    	String nameList="";//초기값
    	String priceList="";
    	String image="";
    	
    	for(int i=0;i<alist.size();i++){
    		 if(alist.get(i).getName() != null){
    			 nameList += alist.get(i).getName()+" ";
    		 }
    		 priceList+=alist.get(i).getPrice()+" ";
    		 image+=alist.get(i).getImage(); 
    		 
    	}
    %>
		<h2>나의 구매목록</h2>
		<table>
			<tr>
				<td>핸드폰 이름:</td>
				<td><%=nameList %></td>
			</tr>
			<tr>
				<td>가격:</td>
				<td><%=priceList %></td>
			</tr>
			<tr>
				<td>사진:</td>
				<td><img src="../resources/images/<%=image %>"></td>
			</tr>
		</table>
	</body>
</html>