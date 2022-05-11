<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>
<%

/* CREATE TABLE employee (
		  id int NOT NULL AUTO_INCREMENT,
		  name varchar(50) DEFAULT NULL,
		  saleqty int NOT NULL,
		  PRIMARY KEY (`id`)
		); 
 */

Connection con = null;
try {
	Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/phoneshop?servertimezone=Asia/Seoul", "phone", "phone1234");

	ResultSet rs = null;
	List empdetails = new LinkedList();
	JSONObject responseObj = new JSONObject();

	String query = "select phoneName,sum(cnt) as cnt from orderphone group by id";
	PreparedStatement pstm = con.prepareStatement(query);

	rs = pstm.executeQuery();
	JSONObject empObj = null;

	while (rs.next()) {
		
		String phoneName=rs.getString("phoneName");
		int cnt=rs.getInt("cnt");
		
		//테이블에서 가져온 데이터를 JSON 형태로 대입하기 위해 선언
		empObj = new JSONObject();
		
		empObj.put("phoneName", phoneName);
		empObj.put("cnt",cnt);
		
		//JSON 에 추가
		empdetails.add(empObj);
	}
	
	responseObj.put("empdetails", empdetails);
	
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