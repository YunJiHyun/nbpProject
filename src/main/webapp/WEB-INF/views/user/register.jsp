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
    	
    	$("#userId").focusout(function(){
    	
    		 $.ajax({
    			   url : "${path}/user/checkId",
    			   type : "post",
    			    data : {
    			    	"userId" : $("#userId").val()
    			    },
    			   
    			   success : function(data){ 
    				   
    			    	 if ( data.userId == undefined) {
    			    		$("#resultIdCheck").text("사용할 수 있는 아이디 입니다.").css("color","green");   		 
    			    	} else {
    			    		$("#resultIdCheck").text("이미 존재하는 아이디입니다").css("color","red");
    			    	} 
    			   }
    		}); 
    	});
    	
    	$("#passwordCheck").focusout(function(){
           
            if($("#password").val()!=$("#passwordCheck").val()){
                	$("#resultPwCheck").text("비밀번호가 일치 하지 않습니다.").css("color","red");
            } else if(($("#password").val()==$("#passwordCheck").val())&&
            		  ($("#password").val()!= "" && $("#passwordCheck").val()!="")) {
                    $("#resultPwCheck").text("비밀번호가 일치 합니다").css("color","green");
            } else if(($("#password").val() == "" && $("#passwordCheck").val()=="")) {
                     $("#resultPwCheck").text("");
            }
        });
    	
    	$("#btnRegister").click(function(){
	    	 var userId = $("#userId").val();
	         var password = $("#password").val();
	         var passwordCheck = $("#passwordCheck").val();
	         var userName = $("#userName").val();
	         var userMajor = $("select[name='userMajor']").val();
	         var userPhoneNum = $("#userPhoneNum").val();
	         
	         var reg_id = /^[1-9]{7,8}$/;
	         
	         if(userId == ""){
	             alert("아이디를 입력하세요");
	             document.registerForm.userId.focus();
	             return false;
	         }
	         if($("#resultIdCheck").text()=="이미 존재하는 아이디입니다"){
                 alert("존재하는 아이디입니다. 다른 아이디로 회원가입해주세요");
                 return false;
             } 
	         if(!reg_id.test(userId)){ 
                 alert("아이디는 학번입니다 7~8자리입니다. ex)1212222");
                 return false;
             }
	        
	         if(password == ""){
	             alert("패스워드를 입력하세요");
	             document.registerForm.password.focus();
	             return false;
	         }
	         if(passwordCheck == ""){
	             alert("패스워드를 확인하세요");
	             document.registerForm.passwordCheck.focus();
	             return false;
	         }
	         if(password!=passwordCheck){
	        	 alert("비밀번호가 일치하지 않습니다.");
                 return false;
	         }
	         if(userName == ""){
	             alert("이름 입력하세요");
	             document.registerForm.userName.focus();
	             return false;
	         }
	         if(userPhoneNum == ""){
	             alert("핸드폰 번호를 입력하세요");
	             document.registerForm.userPhoneNum.focus();
	             return false;
	         }
	         
	         $('#registerForm').attr({action:"${path }/user/addUser",method:'post'}).submit();
	        });
	    	$("#btnBack").click(function(){
	    		 location.href="${path}/login";
    	});
    });
</script>

</head>
<body>
<h1>회원가입</h1>
	<form name="registerForm" id="registerForm">
		ID : <input type="text" id="userId" name="userId"/>  <span id="resultIdCheck"></span><br/>
		Password : <input type="password" id="password" name="password"/><br/>
		Password 확인 : <input type="password"  id="passwordCheck" name="userPw"/> <span id="resultPwCheck"></span> <br/>
		
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