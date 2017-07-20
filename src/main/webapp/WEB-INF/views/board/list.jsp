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
            location.href = "${path}/j_spring_security_logout";
        });
    });
</script>
<script>
function list(page){
    location.href="${path}/board/list?currentPage="+page;
}
</script>
</head>
<body>
 <h2>학교 게시판</h2>   
    <div id="idDiv">
            <sec:authentication property="principal.username"/> 님 반갑습니다.</p> 
            <input type="button" id="btnLogout" value="로그아웃"/>
    </div>

<div id="listCount" style="textalign : right">${map.count } 개 게시물</div>
<table class="table table-hover" border="1" width="600px"  style="border-collapse:collapse; border:1px gray solid;">
    <tr>
        <th>번호</th>
        <th>작성자</th>
        <th>제목</th>
        <th>카테고리</th>
        <th>날짜</th>
        <th>조회수</th>
    </tr>
	<c:forEach var="row" items="${map.boardList}">
    <tr>
        <td>${row.boardNum}</td>
        <td>${row.boardUserId}</td>
        <td><a href="${path}/board/view?boardNum=${row.boardNum }">${row.boardTitle}</a></td>
        <td>${row.boardCategory}</td>
        <td><fmt:formatDate value="${row.boardDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        <td>${row.boardReadCount}</td>
    </tr>    
    </c:forEach>
    
    <tr>
        <td colspan="6">
             
                <c:if test="${map.boardPageHelper.curBlock > 1}">
                    <a href="javascript:list('1')"> [<<]</a>
                    <a href="javascript:list('${map.boardPageHelper.prevPage}')">[<]</a>
                </c:if>

                <c:forEach var="num" begin="${map.boardPageHelper.blockBegin}" end="${map.boardPageHelper.blockEnd}">
                    <c:choose>
                        <c:when test="${num == map.boardPageHelper.curPage}">
                            <span style="color: black">${num}</span>&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:list('${num}')">${num}</a>&nbsp;
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${map.boardPageHelper.curBlock < map.boardPageHelper.totalBlock}">
                    <a href="javascript:list('${map.boardPageHelper.nextPage}')">[>]</a>
                     <a href="javascript:list('${map.boardPageHelper.totalPage}')">[>>]</a>
                </c:if>
                
            </td>
        </tr>
    
    
    
    
</table> 
<button type="button" id="btnWrite">글쓰기</button>
</body>
</html>