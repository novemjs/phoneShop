<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- 4.5.3 --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<!-- <script>
	$(document).ready(function () {
	   $(function () {
	            $('#phone').keydown(function (event) {
	             var key = event.charCode || event.keyCode || 0;
	             $text = $(this); 
	             if (key !== 8 && key !== 9) {
	                 if ($text.val().length === 3) {
	                     $text.val($text.val() + '-');
	                 }
	                 if ($text.val().length === 8) {
	                     $text.val($text.val() + '-');
	                 }
	             }
	
	             return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
				 // Key 8번 백스페이스, Key 9번 탭, Key 46번 Delete 부터 0 ~ 9까지, Key 96 ~ 105까지 넘버패트
				 // 한마디로 JQuery 0 ~~~ 9 숫자 백스페이스, 탭, Delete 키 넘버패드외에는 입력못함
	         })
	   });
	});
</script> -->
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
<!-- <script>
	function idCheck(){
		var form1=document.newMember;
		var user_id=form1.id.value;
		var url="idCheck.jsp?id="+user_id;
		window.open(url,"IdCheck","toolbar=no,location=no,status=no,menubar=no,scrollbar=no,resizable=no");
		return;
	}
</script>  -->

<script>
	//유효성 검사 (필수항목 입력여부 체크)
	function checkValue() {
		
		var id = document.getElementById("id").value;
		var passwd = document.getElementById("passwd").value;
		var name = document.getElementById("name").value;
		var age = document.getElementById("age").value;
		var email = document.getElementById("email").value;
		var phone = document.getElementById("phone").value;
		var postcd = document.getElementById("postcd").value;
		var addr2 = document.getElementById("addr2").value;
		
		if(!id){
			alert("아이디를 입력하세요!");
			id.select();
			id.focus();
			return false;
			
		}
		
		if(!passwd){
			alert("비밀번호를 입력하세요!");
			return false;
		}
		
		if(!name){
			alert("이름을 입력하세요!");
			return false;
		}
		
		if(!age){
			alert("나이를 입력하세요!");
			return false;
		}
		
		if(!email){
			alert("이메일을 입력하세요!");
			return false;
		}

		if(!phone){
			alert("연락처를 입력하세요!");
			return false;
		}
		
		if(!postcd){
			alert("주소를 검색하세요!");
			return false;
		}
		
		if(!addr2){
			alert("상세 주소를 입력하세요!");
			return false;
		}
		
		//서버로 전송
		document.newMember.submit();
		
	}		
</script>

<title>회원 가입</title>
  <!-- Bootstrap CSS -->
 <style>
 	label {
 		font-size:20px;
 	}
 </style>
</head>
<body>

	<div class="jumbotron" style="font-family: 'Jua', sans-serif;">
		<div class="container">
			<h1 class="display-6">회원 가입</h1>
		</div>
	</div>

	<div class="container" style="font-family: 'Jua', sans-serif;">
		<form name="newMember" class="form-horizontal" action="processAddMember.jsp" method="post" onSubmit="return check()">
	
			<div class="form-group  row">
				<label class="col-sm-2">아이디</label>
				<div class="col-sm-3">
					<input  name="id" id="id" type="text" class="form-control text-center" placeholder="아이디입력" >
					<!-- <input type="button" value="중복확인" onclick="idCheck()"> -->
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input  name="passwd" id="passwd" type="password" class="form-control text-center" placeholder="비밀번호 입력" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">이름</label>
				<div class="col-sm-3">
					<input  name="name" id="name" type="text" class="form-control text-center" placeholder="이름 입력" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">나이</label>
				<div class="col-sm-3">
					<input  name="age" id="age" type="text" class="form-control text-center" placeholder="나이 입력" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">성별</label>
				<div class="col-sm-10">
					<input name="gender" id="gender" type="radio" value="남"/><span>남</span> 
					<input name="gender" id="gender" type="radio" value="여"/><span>여</span>
				</div>
			</div>
		

			<div class="form-group row">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-3">
					<input type="text" id="email" name="email" maxlength="50" class="form-control text-center">
				</div>				
			</div>
		
			<div class="form-group  row">
				<label class="col-sm-2">전화번호</label>
				<div class="col-sm-3">
					<input id="phone" name="phone" type="text" 
					       class="form-control text-center"
					       maxlength="13" size="13" placeholder="-없이 숫자만입력하세요" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>					
				<div class="col-sm-3"> 
					<input type="text" id="postcd" name="postcd" maxlength="5" class="form-control" readonly="readonly">
				</div>
				<div class="col-sm-2">
					<input type="button" class="btn btn-Info" 
						   value="우편번호 찾기" onclick="Postcode()">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">주소</label>					
				<div class="col-sm-7">
					<input id="addr1" name="addr1" type="text" readonly="readonly"
					       class="form-control" />
				</div>				
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">상세주소</label>					
				<div class="col-sm-7">
					<input id="addr2" name="addr2"  type="text"  class="form-control" />
				</div>				
			</div>
			<div class="form-group row">
				<div class="col-sm-6 text-center">
					<input type="button" class="col-sm-3 btn btn-primary" value="등록" onclick="return checkValue()"> 
					<input type="reset" class="col-sm-3 btn btn-warning" value="취소">
				</div>
			</div>
		</form>
	</div>
</body>
</html>