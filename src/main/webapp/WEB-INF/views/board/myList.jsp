<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="board_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내가 쓴 게시물</title>
<script src="<c:url value="/resources/js/myList.js"></c:url>"></script>
<link rel="stylesheet"
	href="<c:url value="/resources/css/list.css"></c:url>" />
<script>
	function list(page) {
		location.href = "/jihyunboard/board/myList?currentPage=" + page
				+ "&searchOption=${boardPageHelper.searchOption}"
				+ "&keyword=${boardPageHelper.keyword}&dateKeyword=${boardPageHelper.dateKeyword}";
	}
</script>
</head>
<body>
	<div id="wrapper">
		<br />
		<p id="boardTitle">내가 작성한 게시글</p>
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
			action="${path }/board/myList">
			<div id="searchDiv" class="form-group">
				<select name="searchOption" class="form-control"
					style="width: 100pt">
					<option value="all"
						<c:out value="${boardPageHelper.searchOption == 'all'?'selected':''}"/>>전체</option>
					<option value="boardTitle"
						<c:out value="${boardPageHelper.searchOption == 'boardTitle'?'selected':''}"/>>제목</option>
					<option value="boardDate"
						<c:out value="${boardPageHelper.searchOption == 'boardDate'?'selected':''}"/>>날짜</option>
				</select>
				<div class="col-xs-2">
					<input id="searchNotDate"class="form-control" name="keyword"
						value="${boardPageHelper.keyword}"> 
					<input type="date" style="display: none" class="form-control" name="dateKeyword"
						value="${boardPageHelper.keyword}">
				</div>
			</div>
			<input type="submit" class="btn btn-success" value="조회">
		</form>
		<br />
		<div id="listCount" style="textalign: right">
			<table style="width: 100%">
				<tr>
					<td style="text-align: left"><a href="${path }/board/list"
						class="copperBtn generalBtn"> <img id="mydocument"
							src="<c:url value='/resources/img/back.png'></c:url>" />전체 글 보기
					</a></td>
					<td style="text-align: right">총 <span style="color: blue;">${count }</span>개
					</td>
				</tr>
			</table>
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
						<td style="width: 750; text-align: left">
							<a href="${path}/board/view?boardNum=${row.boardNum }&currentPage=${boardPageHelper.currentPage}
									&searchOption=${boardPageHelper.searchOption}&keyword=${boardPageHelper.keyword}&dateKeyword=${boardPageHelper.dateKeyword}">${row.boardTitle}&nbsp;
							</a> 
							<c:if test="${row.replyCount > 0}">
								<span class="label label-danger">댓글:${row.replyCount}</span>
							</c:if> 
							<c:if test="${row.fileCount > 0}">
								<span><img src="<c:url value='/resources/img/file.png'></c:url>"
									style="width: 30px; height: 30px" /></span>
							</c:if>
						</td>
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
					<li><c:forEach var="num" begin="${boardPageHelper.blockBegin}"
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
				</ul>
			</nav>
		</div>
	</div>
</body>
</html>