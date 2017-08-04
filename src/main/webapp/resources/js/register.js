/**
 * 
 */
$(document).ready(function(){
	$("#userId").focusout(function(){
		$.ajax({
			url : "/jihyunboard/user/checkId",
			type : "post",
			data : { "userId" : $("#userId").val()},
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
		} else if(($("#password").val()==$("#passwordCheck").val())&&($("#password").val()!= "" && $("#passwordCheck").val()!="")) {
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
		var reg_id = /^[g0-9]{7,8}$/;
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
		
		$('#registerForm').attr({action:"/jihyunboard/user/addUser",method:'post'}).submit();
	
	});
	
	$("#btnBack").click(function(){
		location.href="/jihyunboard/login";
	});
});