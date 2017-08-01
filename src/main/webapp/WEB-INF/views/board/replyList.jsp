<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="board_header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table style="width: 700px">
		<c:forEach var="row" items="${replyList}">
			<tr>
				<td><b>${row.replyUserName}</b> &nbsp;&nbsp; <fmt:formatDate value="${row.replyDate}" pattern="yyyy-MM-dd  HH:mm" />  
				<br />
					${row.replyContent}
					<hr/>
				</td>
			
			</tr>
		</c:forEach>
	
	</table>
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