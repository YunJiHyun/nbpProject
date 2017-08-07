<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="kanban_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<c:url value='/resources/css/kanban.css'></c:url>"/>
	<title>kanban</title>

</head>
<body>
	<div id="wrapper">
		<div id="idDiv">
			<form id="logout" action="${pageContext.request.contextPath}/logout" method="post">
				<b><sec:authentication property="principal.userName" /></b> 님 반갑습니다. 
				<input type="submit" id="btnLogout" class="btn btn-default" value="로그아웃" /> 
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
		<div class="jumbotron">
			<div class="jumboInner">
				<h1>My Kanban</h1>
				<br/>
				<div>
					게시글 번호 : ${board.boardNum } <br/>
					게시글 제목 : ${board.boardTitle }
				</div>
				<br/>
				<form class="form-inline" id="kanbanWriteForm" name="kanbanWriteForm" method="post">
					<div class="form-group" id="centerForm">
						<label>해야할 일:</label> 
						<input type="text" class="form-control" name="kanbanContent" id="kanbanContent" size="100" placeholder="해야할 일을 입력해주세요">
					</div> &nbsp;&nbsp;
					<div class="form-group">
						<label>중요도 : </label> 
						<select name="kanbanImportance" class="form-control">
							<option value="checking">--선택해주세요--</option>
							<option value="1">상</option>
							<option value="2">중</option>
							<option value="3">하</option>
						</select>
					</div>
					<br/><br/>
					<div class="form-group">
						<label>마감날짜 : </label> 
						<input type="date"  id="kanbanDeadline" class="form-control" name="kanbanDeadline">
					</div>
					<br /> <br />
					<div class="form-group" id="btnDiv">
						<div id="btnDivInner">
							<button type="submit" id="btnSave" class="btn btn-success">등록</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="reset" id="btnReset" class="btn btn-danger">다시작성</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div id="kanbanBoard">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>TODO</th>
						<th>DOING</th>
						<th>DONE</th>
					</tr>
				</thead>
				<tbody>
					<tr id="kanbanBody">
						<td id="kanbanTodo">해야할일 리스트... </td>
						<td id="kanbanDoing">하는 중 리스트...</td>
						<td id="kanbanDone">완료된 일 리스트...</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div> 
</body>
</html>