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
        
        $("#btnLogout").click(function(){
            // 페이지 주소 변경(이동)
            alert("로그아웃하셨습니다.");
            location.href = "${path}/user/logout";
        });
    });
</script>

</head>
<body>
 <h2>게시글 목록</h2>   
 <div id="idDiv">${userId } 님 환영합니다. <input type="button" id="btnLogout" value="로그아웃"/></div>

<button type="button" id="btnWrite">글쓰기</button>
<table class="table table-hover" border="1" width="600px"  style="border-collapse:collapse; border:1px gray solid;">
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
        <td><fmt:formatDate value="${row.boardDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        <td>${row.boardReadCount}</td>
    </tr>    
    </c:forEach>
</table> 
</body>
</html>