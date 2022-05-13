<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function(){
		$('#id').focusout(function(){
			alert("ddddddd");
		});
	});
	
</script>
<body>
	<input type="text" id="id">
	<input type="text">
</body>
</html>