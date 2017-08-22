<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="board_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시글 목록</title>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="<c:url value="/resources/js/jquery.easydropdown.js"></c:url>"></script>
	<script src="<c:url value="/resources/js/list.js"></c:url>"></script>
	<script src="<c:url value="/resources/js/board_view.js"></c:url>"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="<c:url value="/resources/css/list.css"></c:url>" />
	<link rel="stylesheet" href="<c:url value="/resources/css/easydropdown.css"></c:url>" />
	<script>
		function viewUserInfo(userId) {
			$.ajax({
				type : "POST",
				url : "${path}/user/userInfo?userId=" + userId,
				success : function(result) {
					$("#dialog").html(result);
				}
			});
			$("#dialog").dialog("open");
		}
		var searchParam = "&searchOption=${boardPageHelper.searchOption}";
			searchParam	+= "&keyword=${boardPageHelper.keyword}";
		var categoryParam = "&category=${boardPageHelper.category}";
		var pageScaleParam = "&pageScale=${boardPageHelper.pageScale}" ;
		
		function list(page) {
			location.href = "${path}/board/list?currentPage=" + page + searchParam 
							+ categoryParam + pageScaleParam;
		}
		function changeCategory(category){
			location.href = "${path}/board/list?currentPage=1"+ searchParam 
							+ "&category=" + category + pageScaleParam ;
		}
		function changePageScale(value){
			location.href = "${path}/board/list?currentPage=1" + searchParam 
							+ categoryParam + "&pageScale=" + value;
		}
		
		function goBoardView(boardNum, page){
			location.href="${path}/board/view?boardNum=" + boardNum +"&currentPage=" + page
						+ searchParam + categoryParam + pageScaleParam ;
		}
	</script>
</head>
<body>
	<div id="wrapper">
		<ul class="nav nav-tabs nav-justified">
			<li class="active"><a href="#" id="boardTitle">학교 게시판</a></li> 
			<li><a href="${path }/kanban/mainList" id="goKanbanMain">Kanban</a></li>	
			<li><a href="${path }/bookmark/mainList" id="goBookmarkMain">즐겨찾기</a></li>
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
					<td style="text-align: left">
						<a href="${path }/board/myList" class="burlywoodBtn generalBtn"> 
							<img id="mydocument" src="<c:url value='/resources/img/mypen.png'></c:url>" />
								내가 작성한 글 보기
						</a>
					</td>
				</tr>
			</table>
		</div>
		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="${path}/board/list">처음으로</a>
				</div>

				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<form class="navbar-form navbar-left" name="searchForm" method="get" action="${path }/board/list">
						<div id="searchDiv" class="form-group">
							<select name="searchOption" class="form-control" style="width: 100pt">
								<option value="all" <c:out value="${boardPageHelper.searchOption == 'all'?'selected':''}"/>>전체</option>
								<option value="userName" <c:out value="${boardPageHelper.searchOption == 'userName'?'selected':''}"/>>작성자</option>
								<option value="boardTitle" <c:out value="${boardPageHelper.searchOption == 'boardTitle'?'selected':''}"/>>제목</option>
								<option value="boardContent" <c:out value="${boardPageHelper.searchOption == 'boardContent'?'selected':''}"/>>내용</option>
							</select>
							<div class="col-xs-2">
								<input class="form-control" name="keyword" value="<c:out value='${boardPageHelper.keyword}'/>">
							</div>
						</div>
						<input type="submit" class="btn btn-success" value="조회"> &nbsp; &nbsp; &nbsp;
						<input type="hidden" name="category" value="${boardPageHelper.category}"/>
						<div class="form-group">					
							<select name="pageScale" class="dropdown" onchange="changePageScale(this.value)">
								<option value="10" <c:out value="${boardPageHelper.pageScale == '10'?'selected':''}"/>>10개씩</option>
								<option value="20" <c:out value="${boardPageHelper.pageScale == '20'?'selected':''}"/>>20개씩</option>
								<option value="30" <c:out value="${boardPageHelper.pageScale == '30'?'selected':''}"/>>30개씩</option>
							</select>
						</div>
					</form>
				</div>
			</div>
		</nav>
		<%@ include file="boardCategory.jsp"%>
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
			<c:forEach var="row" items="${boardList}">
				<tbody>
					<tr>
						<c:if test="${row.boardBookmark == 'N'}">
							<td width="70" id="${row.boardNum}" class="blackStarTd">
								<img class="bookmarkblackStar" src="<c:url value="/resources/img/blackstar.png"></c:url>" width="30" height="30"/>
							</td>
						</c:if>
						<c:if test="${row.boardBookmark == 'Y'}">
							<td width="70" id="${row.boardNum}" class="goldStarTd">
								<img class="bookmarkgoldStar" src="<c:url value="/resources/img/goldstar.png"></c:url>" width="30" height="30"/>
							</td>
						</c:if>
						<td width="70">${row.boardNum}</td>
						<td width="150">
							<a href='javascript:viewUserInfo("${row.boardUserId}")'>${row.userName}</a>
						</td>
						<td style="width: 750; text-align: left">
							<a href="javascript:goBoardView('${row.boardNum}','${boardPageHelper.currentPage }')"><c:out value='${row.boardTitle}'/>&nbsp;</a>
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
						<c:if test="${boardPageHelper.curBlock < boardPageHelper.totalBlock}">
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
		<div id="btnWriteDiv">
			<button type="button" class="btn btn-primary" id="btnWrite">글쓰기</button>
		</div>
		<div id="dialog" title="사용자 정보 보기"></div>
	</div>
</body>
</html>