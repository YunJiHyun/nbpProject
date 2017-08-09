<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="bookmark_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<c:url value="/resources/js/bookmarkMain.js"></c:url>" ></script>
	<link rel="stylesheet" href="<c:url value="/resources/css/bookmarkMain.css"></c:url>" />
	<title>즐겨찾기 페이지</title>
</head>
<body>
<div id="wrapper">
		<ul class="nav nav-tabs nav-justified">
			<li><a href="${path }/board/list" id="boardTitle">학교 게시판</a></li> 
			<li><a href="${path }/kanban/mainList" id="goKanbanMain">Kanban</a></li>	
			<li class="active"><a href="#" id="goBookmarkMain">즐겨찾기</a></li>
		</ul>
		<div id="idDiv">
			<form id="logout" action="${pageContext.request.contextPath}/logout" method="post">
				<b><sec:authentication property="principal.userName" /></b> 님 반갑습니다. 
				<input type="submit" id="btnLogout" class="btn btn-default" value="로그아웃" /> 
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
		<br />
		<div id="listCount" style="textalign: right">
			<table style="width: 100%">
				<tr>
					<td style="text-align: right">
						총 <span style="color: blue;">${count }</span>개
					</td>
				</tr>
			</table>
		</div>
		<table class="table table-borderless table-hover">
			<thead>
				<tr>
					<th></th>
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>카테고리</th>
					<th>날짜</th>
				</tr>
			</thead>
			<c:forEach var="row" items="${bookmarkList}">
				<tbody>
					<tr>
						<td width="70" id="${row.boardNum}" class="bookmarkTd">
							<img class="bookmarkStar" src="<c:url value="/resources/img/goldstar.png"></c:url>" width="30" height="30"/>
						</td>
						<td width="70">${row.boardNum}</td>
						<td width="150">
							<a href='javascript:viewUserInfo("${row.boardUserId}")'>${row.userName}</a>
						</td>
						<td style="width: 750; text-align: left">
							<a href="${path}/board/view?boardNum=${row.boardNum }&currentPage=${boardPageHelper.currentPage}
									&searchOption=${boardPageHelper.searchOption}&keyword=${boardPageHelper.keyword}">${row.boardTitle}&nbsp;</a>
							<c:if test="${row.replyCount > 0}">
								<span class="label label-danger">댓글:${row.replyCount}</span>
							</c:if> 
							<c:if test="${row.fileCount > 0}">
								<span><img src="<c:url value='/resources/img/file.png'></c:url>" style="width: 30px; height: 30px" /></span>
							</c:if>
						</td>
						<td width="100">${row.boardCategory}</td>
						<td width="150">
							<fmt:formatDate value="${row.boardDate}" pattern="yyyy-MM-dd" />
						</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>

		<div id="paging">
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<li>
						<c:if test="${boardPageHelper.curBlock > 1}">
							<a href="javascript:list('1')" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span>
							</a>
							<a href="javascript:list('${boardPageHelper.prevPage}')" aria-label="Previous"> 
								<span aria-hidden="true">&lt;</span>
							</a>
						</c:if>
					</li>
					<li>
						<c:forEach var="num" begin="${boardPageHelper.blockBegin}" end="${boardPageHelper.blockEnd}">
							<c:choose>
								<c:when test="${num == boardPageHelper.currentPage}">
									<span style="color: black">${num}</span>&nbsp;
								</c:when>
								<c:otherwise>
									<a href="javascript:list('${num}')">${num}</a>&nbsp;
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</li>
					<li>
						<c:if test="${boardPageHelper.curBlock <= boardPageHelper.totalBlock}">
							<a href="javascript:list('${boardPageHelper.nextPage}')" aria-label="Next"> 
								<span aria-hidden="true">&gt;</span>
							</a>
							<a href="javascript:list('${boardPageHelper.totalPage}')" aria-label="Next"> 
								<span aria-hidden="true">&raquo;</span>
							</a>
						</c:if>
					</li>
				</ul>
			</nav>
		</div>	
	</div>
</body>
</html>