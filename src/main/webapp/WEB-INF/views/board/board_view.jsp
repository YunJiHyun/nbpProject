<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 읽기</title>
<%@ include file="board_header.jsp"%>
<style>
#boardHeader {
	margin-top: 50px;
}

#title {
	display: inline-block;
	margin-left: 30px;
	font-size: 25pt;
	font-weight: bold;
	text-align: left
}

#categoryAndDate {
	font-size: 10pt;
	color: gray;
	text-align: right
}

#boardBody {
	margin-left: 30px;
	margin-bottom: 50px;
	width: 100%;
	height:
}

#wrapper {
	margin: 0 auto;
	padding-top: 20pt;
	width: 90%;
}

#idDiv {
	text-align: right;
}

#btnOuter {
	width: 100%;
	text-align: center
}

#hidden {
	width: 40%;
	margin: 0 auto;
}
</style>
<script>
	$(document)
			.ready(
					function() {

						viewFileList();
						$("#btnBack")
								.click(
										function() {
											location.href = "${path}/board/list?currentPage=${currentPage}&searchOption=${searchOption}&keyword=${keyword}";
										});

						/* $("#btnLogout").click(function() {
							// 페이지 주소 변경(이동)
							alert("로그아웃하셨습니다.");
						}); */

						$(document)
								.keydown(
										function(e) {
											if (e.target.nodeName != "INPUT"
													&& e.target.nodeName != "TEXTAREA") {
												if (e.keyCode === 8) {
													return false;
												}
											}
										});

					});

	function viewFileList() {
		$.ajax({
			type : "POST",
			url : "${path}/board/getFileList/${BoardDTO.boardNum}",
			success : function(data) {
				$(data).each(
						function() {
							var fileInfo = getFileInfo(this);
							var html = "<li><a href='"+fileInfo.getLink+"'>"
									+ fileInfo.fileName + "</li>";

							$("#uploadedList").append(html);
						});
			}
		});
	}
</script>
</head>
<body>
	<div id="wrapper">
		<div id="boardHeader">
			<div width="900" id="title">${BoardDTO.boardTitle }</div>
			<div id="idDiv">
			<form id="logout" action="${pageContext.request.contextPath}/logout" method="post">
					<b><sec:authentication property="principal.userName" /></b> 님 반갑습니다. 
					<input type="submit" id="btnLogout" class="btn btn-default" value="로그아웃" />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
			</div>
			<br />
			<div id="categoryAndDate">${BoardDTO.boardCategory }
				<fmt:formatDate value="${BoardDTO.boardDate }" pattern="yyyy-MM-dd HH:mm:ss" />
			</div>
		</div>
		<hr />
		<br /> <br />
		<div id="boardBody">${BoardDTO.boardContent }</div>
		<hr />
		<div class="fileDrop">첨부파일 목록</div>
		<br />
		<div id="uploadedList"></div>
		<br /> <br />
		<div id="btnOuter">
			<div id="btnhidden">
				<input type="hidden" name="boardNum" value="${BoardDTO.boardNum}">
				<c:if test="${BoardDTO.boardUserId eq userId}">
					<a href="${path }/board/modify?boardNum=${BoardDTO.boardNum}&currentPage=${currentPage}&searchOption=${searchOption}&keyword=${keyword}">수정하기</a>&nbsp;&nbsp;	
			     	<a href="${path }/board/delete?boardNum=${BoardDTO.boardNum}">삭제하기</a>
					<br />
				</c:if>
			</div>
			<br /> <br />
			<div id="btnInner">
				<input type="button" id="btnBack" class="btn btn-primary" value="목록" />
			</div>
		</div>
	</div>
</body>
</html>