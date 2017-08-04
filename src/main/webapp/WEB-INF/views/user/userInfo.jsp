<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>사용자정보</title>
</head>
<body>
	<div>
		<p>ID : ${boardUser.userId }</p>
		<p>Name : ${boardUser.userName } </p>
		<p>Major : ${boardUser.userMajor }</p>
		<p>Phone :  ${boardUser.userPhoneNum }</p>
	</div>
</body>
</html>