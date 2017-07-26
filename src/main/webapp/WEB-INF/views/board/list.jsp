<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 목록</title>
<%@ include file="board_header.jsp"%>
<style>
#wrapper {
	margin: 0 auto;
	padding-top: 20pt;
	width: 90%;
}

#boardTitle {
	text-shadow: 0 1px 0 #ccc, 0 2px 0 #c9c9c9, 0 3px 0 #bbb, 0 4px 0
		#b9b9b9, 0 5px 0 #aaa, 0 6px 1px rgba(0, 0, 0, .1), 0 0 5px
		rgba(0, 0, 0, .1), 0 1px 3px rgba(0, 0, 0, .3), 0 3px 5px
		rgba(0, 0, 0, .2), 0 5px 10px rgba(0, 0, 0, .25), 0 10px 10px
		rgba(0, 0, 0, .2), 0 20px 20px rgba(0, 0, 0, .15);
	color: white;
	font-size: 30pt;
}

th {
	background-color: lightgray;
	text-align: center;
}

td {
	text-align: center;
}

#paging {
	margin-top: 20pt;
	text-align: center;
}

#idDiv {
	text-align: right;
	margin-bottom: 100pt;
}

#btnWriteDiv {
	margin-top: 10px;
	text-align: right;
}

#listCount {
	text-align: right;
	margin-bottom: 10pt;
}
</style>
<script>
	$(document).ready(function() {
		$("#btnWrite").click(function() {
			// 페이지 주소 변경(이동)
			location.href = "${path}/board/write";
		});

		$("#btnLogout").click(function() {
			// 페이지 주소 변경(이동)
			alert("로그아웃하셨습니다.");
			location.href = "${path}/j_spring_security_logout";
		});
	});
</script>
<script>
	function list(page) {
		location.href = "${path}/board/list?currentPage=" + page
				+ "&searchOption=${map.searchOption}"
				+ "&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<div id="wrapper">
		<p id="boardTitle">학교 게시판</p>
		<div id="idDiv">
			<span> <sec:authentication property="principal.username" /> 님
				반갑습니다. <input type="button" class="btn btn-default" id="btnLogout"
				value="로그아웃" /></span>
		</div>
		<form name="searchForm" method="post" action="${path }/board/list">
			<div class="form-group">
				<select name="searchOption" class="form-control"
					style="width: 100pt">
					<!-- 검색조건을 검색처리후 결과화면에 보여주기위해  c:out 출력태그 사용, 삼항연산자 -->
					<option value="all"
						<c:out value="${map.searchOption == 'all'?'selected':''}"/>>전체</option>
					<option value="boardUserId"
						<c:out value="${map.searchOption == 'boardUserId'?'selected':''}"/>>작성자</option>

					<option value="boardTitle"
						<c:out value="${map.searchOption == 'boardTitle'?'selected':''}"/>>제목</option>
				</select> <input name="keyword" value="${map.keyword}"> <input
					type="submit" value="조회">
			</div>
		</form>

		<div id="listCount" style="textalign: right">${map.count }개 게시물</div>
		<table class="table table-hover" border="1" width="600px"
			style="border-collapse: collapse; border: 1px gray solid;">
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>

			<c:forEach var="row" items="${map.boardList}">
				<tbody>
					<tr>
						<td width="70">${row.boardNum}</td>
						<td width="150">${row.boardUserId}</td>
						<td width="750"><a
							href="${path}/board/view?boardNum=${row.boardNum }&currentPage=${map.boardPageHelper.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}">${row.boardTitle}</a></td>
						<td width="100">${row.boardCategory}</td>
						<td width="150"><fmt:formatDate value="${row.boardDate}"
								pattern="yyyy-MM-dd" /></td>
						<td width="70">${row.boardReadCount}</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>

		<div id="paging">
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><c:if test="${map.boardPageHelper.curBlock > 1}">
							<a href="javascript:list('1')" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span></a>
							<a href="javascript:list('${map.boardPageHelper.prevPage}')"
								aria-label="Previous"> <span aria-hidden="true">&lt;</span></a>
						</c:if></li>

					<li><c:forEach var="num"
							begin="${map.boardPageHelper.blockBegin}"
							end="${map.boardPageHelper.blockEnd}">
							<c:choose>
								<c:when test="${num == map.boardPageHelper.curPage}">
									<span style="color: black">${num}</span>&nbsp;
			                        </c:when>
								<c:otherwise>
									<a href="javascript:list('${num}')">${num}</a>&nbsp;
			                        </c:otherwise>
							</c:choose>
						</c:forEach></li>
					<li><c:if
							test="${map.boardPageHelper.curBlock <= map.boardPageHelper.totalBlock}">
							<a href="javascript:list('${map.boardPageHelper.nextPage}')"
								aria-label="Next"> <span aria-hidden="true">&gt;</span></a>
							<a href="javascript:list('${map.boardPageHelper.totalPage}')"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a>
						</c:if></li>
		</div>
		<div id="btnWriteDiv">
			<button type="button" class="btn btn-primary" id="btnWrite">글쓰기</button>
		</div>

	</div>
</body>
</html>