<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<%@ include file="user_header.jsp"%>
<link rel="stylesheet"
	href="<c:url value='/resources/bootstrap/css/styleSignUp.css'></c:url>"
	media="screen" title="no title" charset="utf-8">
<script src="<c:url value="/resources/js/register.js"></c:url>"></script>
</head>
	<body>
		<article class="container">
		<div class="page-header">
			<h1>
				회원가입 <small style="color: red"> * 필수 항목</small>
			</h1>
		</div>
		<div class="col-md-6 col-md-offset-3">
			<form role="form" class="form-horizontal" name="registerForm"
				id="registerForm">
				<div class="form-group">
				<label for="userId">ID <span class="must">*</span></label> <input
					type="text" class="form-control" id="userId" name="userId" /> <span
						id="resultIdCheck"></span><br />
				</div>
				<div class="form-group">
					<label for="password">Password <span class="must">*</span></label> <input
						type="password" class="form-control" id="password" name="password" /><br />
				</div>
				<div class="form-group">
					<label for="passwordCheck">Password 확인 <span class="must">*</span></label>
					<input type="password" class="form-control" id="passwordCheck"
						name="userPw" /> <span id="resultPwCheck"></span> <br />
				</div>
				<hr />
				<div class="form-group">
					<label for="userName">이름 <span class="must">*</span></label> <input
						type="text" class="form-control" id="userName" name="userName" /><br />
				</div>
				<div class="form-group">
					<label> 학과 </label> <select class="form-control" id="userMajor"
						name="userMajor">
						<option value="경영학과" selected="selected">경영학과</option>
						<option value="법학과">법학과</option>
						<option value="IT공학과">IT공학과</option>
						<option value="체육교육학과">체육교육학과</option>
						<option value="통계학과">통계학과</option>
					</select><br />
				</div>
				<div class="form-group">
					<label for="userPhoneNum">핸드폰 번호 <span class="must">*</span>
					</label> <input type="text" class="form-control" id="userPhoneNum"
						name="userPhoneNum" /><span id="PhoneNumCheck">(-)을 제외한 번호를
						적어주세요 ex)01012345678</span><br />
					<br />
				</div>
				<div class="form-group text-center">
					<input type="submit" class="btn btn-primary" id="btnRegister"
						value="회원가입" /> &nbsp;&nbsp; <input type="button"
						class="btn btn-danger" id="btnBack" value="취소" />
				</div>
			</form>
		</div>
		</article>
	</body>
</html>