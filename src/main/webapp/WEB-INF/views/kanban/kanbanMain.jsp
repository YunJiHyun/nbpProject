<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="kanban_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<c:url value='/resources/css/kanban.css'></c:url>"/>
	<link rel="stylesheet" href="<c:url value='/resources/css/kanbanMain.css'></c:url>"/>
	<script src="<c:url value="/resources/js/kanbanMain.js"></c:url>"></script>
	<title>kanban</title>
</head>
<body>
	<div id="wrapper">
		<ul class="nav nav-tabs nav-justified">
			<li><a href="${path }/board/list" id="boardTitle">학교 게시판</a></li> 
			<li class="active"><a href="#" id="goKanbanMain">Kanban</a></li>	
			<li><a href="${path }/bookmark/mainList" id="goBookmarkMain">즐겨찾기</a></li>
		</ul>
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
				<div id="extraKanban">
					추가로 해야할 일이 있다면 등록해주세요!
				</div>
				<br/>
				<form class="form-inline" id="kanbanWriteForm" name="kanbanWriteForm" method="post">
					<div class="form-group" id="centerForm">
						<label>해야할 일:</label> 
						<input type="text" class="form-control" name="kanbanContent" id="kanbanContent" size="100" placeholder="해야할 일을 입력해주세요">
					</div> 
					<br/><br/>
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
						<input type="text" id="kanbanDeadline" class="form-control" name="kanbanDeadline" size="20">
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
						<td width="33%" id="kanbanTodo">
							<ul id="todo">
								<c:forEach var="row" items="${kanbanList}">	
									<fmt:formatDate var="deadline" value="${row.kanbanDeadline }" pattern="yyyy-MM-dd" />
									<fmt:formatDate  var="today" value="${now}" pattern="yyyy-MM-dd"/>
									<c:if test="${row.kanbanState == 'TODO'}">
										<li class="todoList" data-importance="${row.kanbanImportance}">
											<button id="${row.kanbanNum}" class="btn btn-default navbar-btn btn-sm moveDoing">
												<span class="glyphicon glyphicon-hand-right"></span>
											</button><br/>
											<br/>${row.kanbanContent} <br/>
											<c:if test="${today >= deadline}"> 
												<span class="doingDeadline label label-danger">마감날짜 : ${deadline}</span>
											</c:if>
											<c:if test="${today < deadline}"> 
												<span class="doingDeadline label label-default">마감날짜 : ${deadline}</span>
											</c:if>
										</li>
									</c:if>
								</c:forEach>			
							</ul>
						</td>
						<td width="33%" id="kanbanDoing">
							<ul id="doing">
								<c:forEach var="row" items="${kanbanList}">	
									<fmt:formatDate var="deadline" value="${row.kanbanDeadline }" pattern="yyyy-MM-dd" />
									<fmt:formatDate  var="today" value="${now}" pattern="yyyy-MM-dd"/>
									<c:if test="${row.kanbanState == 'DOING'}">
										<li class="doingList" data-importance="${row.kanbanImportance}">
											<button id="${row.kanbanNum}" class="btn btn-default navbar-btn btn-sm moveDone"><span class="glyphicon glyphicon-hand-right"></span></button><br/>
											<br/>${row.kanbanContent} <br/>
											<c:if test="${today >= deadline}"> 
												<span class="doingDeadline label label-danger">마감날짜 : ${deadline}</span>
											</c:if>
											<c:if test="${today < deadline}"> 
												<span class="doingDeadline label label-default">마감날짜 : ${deadline}</span>
											</c:if>
										</li>
									</c:if>
								</c:forEach>			
							</ul>
						</td>
						<td width="33%" id="kanbanDone">
							<ul id="done">
								<c:forEach var="row" items="${kanbanList}">
									<fmt:formatDate var="deadline" value="${row.kanbanDeadline }" pattern="yyyy-MM-dd" />
									<fmt:formatDate  var="today" value="${now}" pattern="yyyy-MM-dd"/>	
									<c:if test="${row.kanbanState == 'DONE'}">
										<li class="doneList" data-importance="${row.kanbanImportance}">
											<button id="${row.kanbanNum}" class="btn btn-default navbar-btn btn-sm moveDelete"><span class="glyphicon glyphicon-remove"></span></button><br/>
											<br/>${row.kanbanContent} <br/>
											<c:if test="${today >= deadline}"> 
												<span class="doingDeadline label label-danger">마감날짜 : ${deadline}</span>
											</c:if>
											<c:if test="${today < deadline}"> 
												<span class="doingDeadline label label-default">마감날짜 : ${deadline}</span>
											</c:if>
										</li>
									</c:if>
								</c:forEach>			
							</ul>
						</td>
						
					
					</tr>
				</tbody>
			</table>
		</div>
	</div> 
</body>
</html>