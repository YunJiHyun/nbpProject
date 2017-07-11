<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	list.jsp 페이지입니다.
	<table border="1">
		<tr>
			<td>번호</td>
			<td>작성자</td>
		</tr>
	<c:forEach items="${result }" var="list">
		<tr>
			<td>${list.boardNum }</td>
			<td>${list.boardUserId }</td>
		<tr>
	</c:forEach>
	
	</table>
</body>
</html>