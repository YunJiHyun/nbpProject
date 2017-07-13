<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 목록</title>
<%@ include file="board_header.jsp" %>
<script>
    $(document).ready(function(){
        $("#btnWrite").click(function(){
            // 페이지 주소 변경(이동)
            location.href = "${path}/board/write";
        });
    });
</script>

</head>
<body>
 <h2>게시글 목록</h2>
<button type="button" id="btnWrite">글쓰기</button>
<table border="1" width="600px">
    <tr>
        <th>번호</th>
        <th>작성자</th>
        <th>제목</th>
        <th>카테고리</th>
        <th>날짜</th>
        <th>조회수</th>
    </tr>
	<c:forEach var="row" items="${boardList}">
    <tr>
        <td>${row.boardNum}</td>
        <td>${row.boardUserId}</td>
        <td><a href="${path}/board/view?boardNum=${row.boardNum }">${row.boardTitle}</a></td>
        <td>${row.boardCategory}</td>
        <td>${row.boardDate}</td>
        <td>${row.boardReadCount}</td>
    </tr>    
    </c:forEach>
</table> 
</body>
</html>