<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="board_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 목록</title>
<script src="<c:url value="/resources/js/list.js"></c:url>"></script>
<link rel="stylesheet"
	href="<c:url value="/resources/css/list.css"></c:url>" />
<script>
	function list(page) {
		location.href = "/jihyunboard/board/list?currentPage=" + page
				+ "&searchOption=${boardPageHelper.searchOption}"
				+ "&keyword=${boardPageHelper.keyword}";
	}
</script>
</head>
<body>
	<div id="wrapper">
		<p id="boardTitle">학교 게시판</p>
		<div id="idDiv">
			<form id="logout" action="${pageContext.request.contextPath}/logout"
				method="post">
				<b><sec:authentication property="principal.userName" /></b> 님
				반갑습니다. <input type="submit" id="btnLogout" class="btn btn-default"
					value="로그아웃" /> <input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
		<form class="form-inline" name="searchForm" method="get"
			action="${path }/board/list">
			<div id="searchDiv" class="form-group">
				<select name="searchOption" class="form-control"
					style="width: 100pt">
					<option value="all"
						<c:out value="${boardPageHelper.searchOption == 'all'?'selected':''}"/>>전체</option>
					<option value="userName"
						<c:out value="${boardPageHelper.searchOption == 'userName'?'selected':''}"/>>작성자</option>
					<option value="boardTitle"
						<c:out value="${boardPageHelper.searchOption == 'boardTitle'?'selected':''}"/>>제목</option>
				</select>
				<div class="col-xs-2">
					<input class="form-control" name="keyword" value="${boardPageHelper.keyword}">
				</div>
			</div>
			<input type="submit" class="btn btn-success" value="조회"> <input
				type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>

		<div id="listCount" style="textalign: right">
			 총 <span style="color: blue;">${count }</span>개 
		</div>
		<table class="table table-borderless table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>카테고리</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<c:forEach var="row" items="${boardList}">
				<tbody>
					<tr>
						<td width="70">${row.boardNum}</td>
						<td width="150">${row.userName}</td>
						<td style="width:750; text-align:left"><a 
							href="${path}/board/view?boardNum=${row.boardNum }&currentPage=${boardPageHelper.currentPage}&searchOption=${boardPageHelper.searchOption}&keyword=${boardPageHelper.keyword}">${row.boardTitle}</a></td>
						<td width="100">${row.boardCategory}</td>
						<td width="150"><fmt:formatDate value="${row.boardDate}"
								pattern="yyyy-MM-dd" /></td>
						<td width="70"><span class="badge">${row.boardReadCount}</span></td>
					</tr>
				</tbody>
			</c:forEach>
		</table>

		<div id="paging">
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><c:if test="${boardPageHelper.curBlock > 1}">
							<a href="javascript:list('1')" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span></a>
							<a href="javascript:list('${boardPageHelper.prevPage}')"
								aria-label="Previous"> <span aria-hidden="true">&lt;</span></a>
						</c:if></li>
					<li><c:forEach var="num"
							begin="${boardPageHelper.blockBegin}"
							end="${boardPageHelper.blockEnd}">
							<c:choose>
								<c:when test="${num == boardPageHelper.currentPage}">
									<span style="color: black">${num}</span>&nbsp;
								</c:when>
								<c:otherwise>
									<a href="javascript:list('${num}')">${num}</a>&nbsp;
								</c:otherwise>
							</c:choose>
						</c:forEach></li>
					<li><c:if
							test="${boardPageHelper.curBlock <= boardPageHelper.totalBlock}">
							<a href="javascript:list('${boardPageHelper.nextPage}')"
								aria-label="Next"> <span aria-hidden="true">&gt;</span></a>
							<a href="javascript:list('${boardPageHelper.totalPage}')"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
						</c:if></li>
		</div>
		<div id="btnWriteDiv">
			<button type="button" class="btn btn-primary" id="btnWrite">글쓰기</button>
		</div>
	</div>
</body>
</html>