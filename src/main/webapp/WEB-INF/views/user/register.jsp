<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<%@ include file="user_header.jsp" %>
 <link rel="stylesheet" href="<c:url value='/resources/bootstrap/css/styleSignUp.css'></c:url>" media="screen" title="no title" charset="utf-8">
<style>

</style>
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
	         var reg_phoneNum =/^(01[016789]{1})([0-9]{3,4})([0-9]{4})$/;
	         
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
	        	 $("#resultPwCheck").text("비밀번호가 일치 하지 않습니다.").css("color","red");
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
	         if(!reg_phoneNum.test(userPhoneNum)){ 
                 alert("핸드폰번호를 올바르게 하세요!");
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
	    <article class="container">
	        <div class="page-header">
	          <h1>회원가입 <small style="color:red"> * 필수 항목</small></h1>
	        </div>
	        <div class="col-md-6 col-md-offset-3">
		       <form role="form" class="form-horizontal" name="registerForm" id="registerForm">
		           <div class="form-group">
			             <label for="userId" >ID <span class="must">*</span></label> 
			             <input type="text" class="form-control" id="userId" name="userId"/>  <span id="resultIdCheck"></span><br/>
	               </div>
	               <div class="form-group">		
			              <label for="password">Password <span class="must">*</span></label> 
			              <input type="password"  class="form-control" id="password" name="password"/><br/>
			       </div>
			       <div class="form-group">
			              <label for="passwordCheck">Password 확인 <span class="must">*</span></label>
			              <input type="password"  class="form-control" id="passwordCheck" name="userPw"/> <span id="resultPwCheck"></span> <br/>
			       </div>
			        <hr/>
			        <div class="form-group">  
			              <label for="userName">이름 <span class="must">*</span></label> 
			              <input type="text" class="form-control" id="userName"name="userName"/><br/>
			        </div>
			        <div class="form-group">   
			            <label > 학과 </label> 
			            <select class="form-control" id="userMajor" name="userMajor">
			 		           <option value="경영학과" selected="selected">경영학과</option>
			 		           <option value="법학과">법학과</option>
			 		           <option value="IT공학과">IT공학과</option>
			 		           <option value="체육교육학과">체육교육학과</option>
			 		           <option value="통계학과">통계학과</option>
			 	        </select><br/>
			 	    </div>
			 	    <div class="form-group">
			 	          <label for="userPhoneNum">핸드폰 번호 <span class="must">*</span> </label> 
			 	          <input type="text" class="form-control" id="userPhoneNum" name="userPhoneNum"/><span id="PhoneNumCheck">(-)을 제외한 번호를 적어주세요 ex)01012345678</span><br/><br/>
			        </div>
			        <div class="form-group text-center">
			              <input type="submit" class="btn btn-primary" id="btnRegister" value="회원가입"/> &nbsp;&nbsp;
			              <input type="button" class="btn btn-danger" id="btnBack" value="취소"/>
			        </div>
		       </form>
		    </div> 
		</article>
	</body>
</html>