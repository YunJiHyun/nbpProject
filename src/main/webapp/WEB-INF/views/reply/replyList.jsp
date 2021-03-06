<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="reply_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
		function replyModify(replyNumber) {
			$("#modifyReply").show();
			$.ajax({
				type : "GET",
				url : "${path}/reply/detail?replyNum=" + replyNumber,
				success : function(result) {
					$("#modifyReply").html(result);
				}
			})
		}
		
		function replyDelete(replyNumber) {
			$.ajax({
				type : "GET",
				url : "${path}/reply/delete?replyNum=" + replyNumber,
				success : function(result) {
					replyList('${replyPageHelper.currentPage}');
				}
			})
		}
	</script>
</head>
<body>
	<table style="width: 700px">
		<c:forEach var="row" items="${replyList}">
			<tr class="replyTr">
				<td>
					<b>${row.replyUserName}</b> &nbsp;&nbsp; 
					<fmt:formatDate value="${row.replyDate}" pattern="yyyy-MM-dd  HH:mm" /> &nbsp;&nbsp;&nbsp; 
					<c:if test="${row.replyer eq userId}">
						<a href="javascript:replyModify('${row.replyNum }')">수정</a> &nbsp;
						<a href="javascript:replyDelete('${row.replyNum }')">삭제</a> 
					</c:if>
					<br /> 
					${row.replyContent}
					<hr />
				</td>
			</tr>
		</c:forEach>
	</table>
	<div id="modifyReply"></div>
	<br />
	<div id="paging">
		<nav aria-label="Page navigation">
			<ul class="pagination">
				<li>
					<c:if test="${replyPageHelper.curBlock > 1}">
						<a href="javascript:replyList('1')" aria-label="Previous"> 
							<span aria-hidden="true">&laquo;</span>
						</a>
						<a href="javascript:replyList('${replyPageHelper.prevPage}')" aria-label="Previous"> 
							<span aria-hidden="true">&lt;</span>
						</a>
					</c:if>
				</li>
				<li>
					<c:forEach var="num" begin="${replyPageHelper.blockBegin}" end="${replyPageHelper.blockEnd}">
						<c:choose>
							<c:when test="${num == replyPageHelper.currentPage}">
								<span style="color: black">${num}</span>&nbsp;
							</c:when>
							<c:otherwise>
								<a href="javascript:replyList('${num}')">${num}</a>&nbsp;
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</li>
				<li>
					<c:if test="${replyPageHelper.curBlock < replyPageHelper.totalBlock}">
						<a href="javascript:replyList('${replyPageHelper.nextPage}')" aria-label="Next"> 
							<span aria-hidden="true">&gt;</span>
						</a>
						<a href="javascript:replyList('${replyPageHelper.totalPage}')" aria-label="Next"> 
							<span aria-hidden="true">&raquo;</span>
						</a>
					</c:if>
				</li>
			</ul>
		</nav>
	</div>
</body>
</html>