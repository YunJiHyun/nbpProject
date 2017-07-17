<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<%@ include file="user_header.jsp" %>
<script>
    $(document).ready(function(){
    	
     	var ajaxPostSend =  function() {
    	    var url = "${path}/user/addUser";  
			var str =$()
    	    
         $.ajax({ 
        	 	url : url,
        	 	method : "post",
        	 	type: "json",
    	     
    	        data: postString,
    	        success: function(msg) {  
    	        	alert("success")//성공시 이 함수를 호출한다.
    	       }
    	    });
    	 }  
    	 
</script>

</head>
<body>
<h1>회원가입</h1>
	<form name="registerForm" method="post" action="${path }/user/addUser">
		ID : <input type="text" id="userId" name="userId"/><br/>
		Password : <input type="text" id="password" name="password"/><br/>
		Password 확인 : <input type="text"  id="passwordCheck" name="userPw"/><br/>
		
		<hr/>
		
		이름 : <input type="text" id="userName"name="userName"/><br/>
		학과 : <select id="userMajor" name="userMajor">
		 		<option value="경영학과" selected="selected">경영학과</option>
		 		<option value="법학과">법학과</option>
		 		<option value="IT공학과">IT공학과</option>
		 		<option value="체육교육학과">체육교육학과</option>
		 		<option value="통계학과">통계학과</option>
		 	</select><br/>
		핸드폰 번호 : <input type="text" id="userPhoneNum" name="userPhoneNum"/><br/>
		
		<input type="submit" id="btnRegister" value="회원가입"/> &nbsp;&nbsp;
		<input type="button" id="btnBack" value="취소"/>
	</form>
	<p id="results"></p>
</body>
</html>