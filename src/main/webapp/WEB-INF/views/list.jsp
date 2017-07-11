<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 목록</title>


</head>
<body>
 <h2>게시글 목록</h2>
<button type="button" id="btnWrite">글쓰기</button>
<table border="1" width="600px">
    <tr>
        <th>번호</th>
        <th>작성자</th>
        <th>제목</th>
        <th>내용</th>
        <th>분류</th>
    </tr>
    <c:forEach var="row" items="${list}">
    <tr>
        <td>${row.boardNum}</td>
        <td>${row.boardUserId}</td>
        <td>${row.boardTitle}</td>
    	<td>${row.boardContent}</td>
        <td>${row.boardCategory}</td>
    </tr>    
    </c:forEach>
</table> 
</body>
</html>