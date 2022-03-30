<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="phoneshopping.vo.Phone" %>
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
	img{
		width:280px;
		height:280px;
		border:none;
	}
	#content_main{
		height:300px;
	}
	#content_left{
		width:300px;
		float:left;
	}
	#content_right{
		width:340px;
		float:left;
	}
	#commandList{
		text-align:center;
	}
	#desc{
		height:170px;
		background:skyblue;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="top.jsp" %>
	<section id="listForm">
		<section id="content_left">
			<img src="../resources/images/${phone.image }"/>
		</section>
		<section id="content_right">
		<%
			if(session.getAttribute("sessionId")!=null && session.getAttribute("sessionId").equals("admin")){
		%>
		<form action="phoneUpdate.phone?id=${phone.id }" method="post">
			기종:<input type="text" value="${phone.kind }" name="kind"><br>
			이름:<input type="text" value="${phone.name }" name="name"><br>
			색깔:<input type="text" value="${phone.color }" name="color"><br>
			크기:<input type="text" value="${phone.size }" name="size"><br>
			화질:<input type="text" value="${phone.camera }" name="camera"><br>
			가격:<input type="text" value="${phone.price }" name="price"><br>
			재고:<input type="text" value="${phone.stockqty }" name="stockqty"><br>
			내용:<textarea rows="13" cols="40" name="content"></textarea><br>
			이미지:<input type="file" value="${phone.image }" name="image">
			<input type="submit" value="수정">
		</form>
		<%
			}else if(session.getAttribute("sessionId")!=null && session.getAttribute("sessionId")!="admin"){
		%>
			<b>기종:</b>${phone.kind }<br>
			<b>가격:</b>${phone.price }<br>
			<b>크기:</b>${phone.size}<br>
			<b>색깔:</b>${phone.color }<br>
			<b>이름:</b>${phone.name }<br>
			<p id="desc">
				<b>내용:</b>${phone.content }<br>
			</p>
		<%
			}else {
				out.println("<script>");
				out.println("alert('로그인이 필요합니다!')");
				out.println("location.href='../member/loginMember.jsp'");
				out.println("</script>");
			}
		%>
		</section>
		<div style="clear:both"></div>
		<%
			
			if(session.getAttribute("sessionId")!=null && session.getAttribute("sessionId").equals("admin")){
		%>
		<div>
			<form action="phoneRemove.phone?id=${phone.id }" method="post">
				<input type="submit" value="삭제">
			</form>
		</div>
		<%	} %>
		<br>
		<nav id="commandList">
			<a href="phoneList.phone">쇼핑계속하기</a>
			<%-- 클릭한 강아지를 장바구니에 추가하기 --%>
			<a href="phoneCartAdd.phone?id=${phone.id }">장바구니에담기</a>
		</nav>
	</section>
</body>
</html>