<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
	<link rel="stylesheet" href="<c:url value='/resources/bootstrap/css/form-elements.css'></c:url>" />
	<link rel="stylesheet" href="<c:url value='/resources/bootstrap/css/style.css'></c:url>" />
	<link rel="stylesheet" href="<c:url value='/resources/css/loginForm.css'></c:url>" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>로그인 화면</title>
	<script>
		$(document).ready(function() {
			$("#login").click(function() {
				var userId = $("#userId").val();
				var userPw = $("#userPw").val();
				if (userId == "") {
					alert("아이디를 입력하세요");
					document.loginForm.userId.focus();
					return false;
				}
				if (userPw == "") {
					alert("비밀번호를 입력하세요");
					document.loginForm.userPw.focus();
					return false;
				}
				$('#loginForm').attr({
					action : "<c:url value='j_spring_security_check'/>",
					method : 'post'
				}).submit();
			});
		});
	</script>
</head>
<body>
	<div class="top-content">
		<div class="inner-bg">
			<div class="container">
				<div class="row">
					<div>
						<h1><strong>login Form</strong></h1>
						<div class="description">
							<p>JIHYUN 게시판 프로젝트</p>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-sm-offset-3 form-box">
						<div class="form-top">
							<div class="form-top-left">
								<h3>Login to our site</h3>
								<p>Enter your user Id and password to log on:</p>
							</div>
							<div class="form-top-right">
								<i class="fa fa-key"></i>
							</div>
						</div>
						<div class="form-bottom">
							<form role="form" name="loginForm" id="loginForm" class="login-form">
								<div class="form-group">
									<label class="sr-only" for="form-username">Username</label> 
									<input type="text" name="userId" id="userId" placeholder="User Id..." class="form-username form-control">
								</div>
								<div class="form-group">
									<label class="sr-only" for="form-password">Password</label> 
									<input type="password" name="userPw" id="userPw" placeholder="Password..." class="form-password form-control">
								</div>
								<button type="button" id="login" class="btn">Sign in!</button>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>
						</div>
						<br />
						<div class="signUp">
							회원이 아니신가요?&nbsp;&nbsp; <a href="${path }/user/register" id="mark">회원가입</a>
						</div>
						<c:if test="${not empty error}">
							<div class="error">${error}</div>
						</c:if>
						<c:if test="${not empty msg}">
							<div class="msg">${msg}</div>
						</c:if>
						<div class="findPassword">
							비민번호를 잊어버리셨나요?&nbsp;&nbsp; <a href="${path }/user/findPassword" id="findMark">비밀번호 찾기</a>
						</div>						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>