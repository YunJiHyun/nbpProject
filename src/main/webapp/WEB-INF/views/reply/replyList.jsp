<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="reply_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
    #modifyReply {
        width: 600px;
        height: 130px;
        padding: 10px;
        z-index: 10;
        display: none;
    }
</style>

<script>
function replyModify(replyNumber){
	$("#modifyReply").show();
     $.ajax({
        type: "GET",
        url: "${path}/reply/detail?replyNum="+replyNumber,
        success: function(result){
            $("#modifyReply").html(result);
        }
    }) 
}

</script>
</head>
<body>
	<table style="width: 700px">
		<c:forEach var="row" items="${replyList}">
			<tr>
				<td><b>${row.replyUserName}</b> &nbsp;&nbsp; <fmt:formatDate value="${row.replyDate}" pattern="yyyy-MM-dd  HH:mm" />  
				&nbsp;&nbsp;&nbsp; 
				<a href="javascript:replyModify('${row.replyNum }')">수정</a>
				&nbsp;
				<a href="">삭제</a>
				<br />
					${row.replyContent}
					<hr/>
				</td>
			
			</tr>
		</c:forEach>
	
	</table>
	<div id="modifyReply"></div><br/>
	<div id="paging">
		<nav aria-label="Page navigation">
			<ul class="pagination">
				<li>
					<c:if test="${replPageHelper.curBlock > 1}">
						<a href="javascript:replyList('1')" aria-label="Previous"> 
							<span aria-hidden="true">&laquo;</span>
						</a>
						<a href="javascript:replyList('${replPageHelper.prevPage}')" aria-label="Previous"> 
							<span aria-hidden="true">&lt;</span>
						</a>
					</c:if>
				</li>
				<li>
					<c:forEach var="num" begin="${replPageHelper.blockBegin}" end="${replPageHelper.blockEnd}">
						<c:choose>
							<c:when test="${num == replPageHelper.currentPage}">
								<span style="color: black">${num}</span>&nbsp;
							</c:when>
							<c:otherwise>
								<a href="javascript:replyList('${num}')">${num}</a>&nbsp;
							</c:otherwise>
						</c:choose>
						</c:forEach>
				</li>
				<li>
					<c:if test="${replPageHelper.curBlock <= replPageHelper.totalBlock}">
						<a href="javascript:replyList('${replPageHelper.nextPage}')" aria-label="Next"> 
							<span aria-hidden="true">&gt;</span>
						</a>
						<a href="javascript:replyList('${replPageHelper.totalPage}')" aria-label="Next"> 
							<span aria-hidden="true">&raquo;</span>
						</a>
					</c:if>
				</li>
		</div>

</body>
</html>