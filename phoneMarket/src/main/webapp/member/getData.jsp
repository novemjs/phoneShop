<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>
<%

Connection con = null;
try {
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/phoneshop?servertimezone=Asia/Seoul", "phone", "phone1234");

	ResultSet rs = null;
	List phoneList = new LinkedList();
	JSONObject responseObj = new JSONObject();

	String query = "SELECT orderPrice,phoneName from orderphone";
	PreparedStatement pstm = con.prepareStatement(query);

	rs = pstm.executeQuery();
	JSONObject empObj = null;

	while (rs.next()) {
		
		int orderPrice=rs.getInt("orderPrice");
		String phoneName=rs.getString("phoneName");
		
		//테이블에서 가져온 데이터를 JSON 형태로 대입하기 위해 선언
		empObj = new JSONObject();
		
		empObj.put("orderPrice",orderPrice);
		empObj.put("phoneName",phoneName);
		
		//JSON 에 추가
		phoneList.add(empObj);
	}
	
	responseObj.put("phoneList", phoneList);
	
	out.print(responseObj.toString());
	
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (con != null) {
		try {
	con.close();
		} catch (Exception e) {
	e.printStackTrace();
		}
	}
}
%>