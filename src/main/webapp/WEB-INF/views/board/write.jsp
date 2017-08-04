<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="board_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시글 작성</title>
	<link rel="stylesheet" href="<c:url value="/resources/css/write.css"></c:url>" />
	<script src="<c:url value="/resources/js/write.js"></c:url>"></script>
	<script src="<c:url value="/resources/js/myCkeditor.js"></c:url>"></script>
</head>
<body>
	<div id="wrapper">
		<h1>새 글 작성하기</h1>
		<div id="idDiv">
			<form id="logout" action="${pageContext.request.contextPath}/logout" method="post">
				<b><sec:authentication property="principal.userName" /></b> 님 반갑습니다. 
				<input type="submit" id="btnLogout" class="btn btn-default" value="로그아웃" /> 
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
		<form class="form-inline" id="boardWriteForm" name="boardWriteForm" method="post" enctype="multipart/form-data">
			<div class="form-group" id="centerForm">
				<label>제목</label> 
				<input type="text" class="form-control" name="boardTitle" id="boardTitle" size="80" placeholder="제목을 입력해주세요">
			</div>
			<br /> <br />
			<div class="form-group">
				<label>카테고리 </label> 
				<select name="boardCategory" class="form-control">
					<option value="checking">--선택해주세요--</option>
					<option value="공지">공지</option>
					<option value="학사">학사</option>
					<option value="장학">장학</option>
					<option value="졸업">졸업</option>
					<option value="모집">모집</option>
				</select>
			</div>
			<br /> <br />
			<div class="ckeditorBody">
				<div class="ckeditor">
					<label>내용 </label>
					<textarea name="boardContent" id="boardContent" rows="5" cols="80" placeholder="내용을 입력해주세요"></textarea>
				</div>
			</div>
			<hr />
			<div class="form-group">
				첨부파일 <div class="fileDrop">Drag & Drop here</div>
				<br />
				<div id="uploadedList"></div>
				<div id="fileList">
					<table class="table table-bordered" id="fileTable">
						<tr>
							<td id='tabFileName'>파일명</td>
							<td id='tabFileSize'>사이즈</td>
							<td id='tabFileDel'>삭제</td>
						</tr>
					</table>
				</div>
			</div>
			<br /> <br />
			<div class="form-group" id="btnDiv">
				<div id="btnDivInner">
					<button type="submit" id="btnSave" class="btn btn-success">작성완료</button>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="reset" id="btnReset" class="btn btn-danger">다시작성</button>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" id="btnBack" class="btn btn-link">돌아가기</button>
				</div>
			</div>
			<br /> <br />
		</form>
	</div>
</body>
</html>