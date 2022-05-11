<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#registForm{
		width:500px;
		border:1px solid ;
		margin:auto;
		
	}
	h2{
		text-align:center;
	}
	table{
		margin:auto;
		width:450px;
		border-collapse:collapse;
	}
	td{
		border:1px solid #000;
	}
	.td_left{
		width:150px;
		background:orange;
	}
	.td_right{
		width:300px;
		background:skyblue;
	}
	#commandCell{
		text-align:center;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="top.jsp" %>
	<section id="registForm">
		<header>
			<h2>휴대폰 상품등록</h2>
		</header>
		<%-- 등록처리 후 강아지 목록으로 이동 --%>
		<form action="phoneRegist.phone" method="post" name="writeForm" enctype="multipart/form-data">
			<table class="table table-striped" style="height:300px;">
				<tr>
					<td colspan="2" style="text-align:center">
						<a href="phoneList.phone">목록보기</a>
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="kind">기종:</label>
					</td>
					<td class="td_right">
						<input type="text" name="kind" id="kind" required="required">
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="nation">이름:</label>
					</td>
					<td class="td_right">
						<input type="text" name="name" id="name">
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="price">색깔:</label>
					</td>
					<td class="td_right">
						<input type="text" name="color" id="color">
					</td>
				</tr>
				
				<tr>
					<td class="td_left">
						<label for="weight">크기:</label>
					</td>
					<td class="td_right">
						<input type="text" name="size" id="size">
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="weight">화질:</label>
					</td>
					<td class="td_right">
						<input type="text" name="camera" id="camera">
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="weight">가격:</label>
					</td>
					<td class="td_right">
						<input type="text" name="price" id="price">
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="height">재고:</label>
					</td>
					<td class="td_right">
						<input type="text" name="stockqty" id="stockqty">
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="content">내용:</label>
					</td>
					<td class="td_right">
						<textarea name="content" id="content" rows="10" cols="40" wrap="off"></textarea>
					</td>
				</tr>
				<tr>
					<td class="td_left">
						<label for="image">상품이미지:</label>
					</td>
					<td class="td_right">
						<input type="file" name="image" id="image">
					</td>
				</tr>
				<tr>
					<td colspan="2" id="commandCell">
						<input type="submit" value="상품 등록"/>
						<input type="reset" value="다시작성">
						<input type="button" value="상품목록보기" onclick="window.location.href='phoneList.phone'">
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="../member/bottom.jsp" %>
</body>
</html>