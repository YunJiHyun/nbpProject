<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="kanban_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<c:url value='/resources/css/kanban.css'></c:url>"/>
	<link rel="stylesheet" href="<c:url value='/resources/css/kanbanMain.css'></c:url>"/>
	<title>kanban</title>
	<style>
		#todo {
			list-style-type: none;
			margin-top : 20px; 
			margin-left: 0; 
			padding: 0;
		}
		 #todo li { 
			position : relative;
		 	margin: 10px;
		 	padding: 1px; 
		 	float: left; 
		 	width: 120px; 
		 	height: 140px; 
		 	font-size: 10pt; 
		 	text-align: center; 
		 	border:1px solid;
		 	box-shadow : 5px 5px gray;
		 }
		 .deadline {
		 	position : absolute;
		 	bottom : 1px;
		 	left : 0;
		 	font-size: 8pt;
		 }
		 .navbar-btn {
		 	position : absolute;
		 	right : 2px;
		 	top : 0;
		 }
	</style>
	<script>
		$(document).ready(function() {
			$("#goBoardMain").click(function() {
				// 페이지 주소 변경(이동)
				alert("게시판 화면으로 돌아갑니다");
				location.href = "${path}/board/list";
			});
			$(".moveDoing").click(function() {
				// 페이지 주소 변경(이동)
				alert("게시판 화면으로 돌아갑니다");
				//location.href = "${path}/board/list";
			});
		});
	</script>
</head>
<body>
	<div id="wrapper">
		<button  class="btn btn-primary btn-lg" id="goBoardMain"> 게시판 화면으로 </button> 
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
						<td width="35%" id="kanbanTodo">
							<ul id="todo">
								<c:forEach var="row" items="${kanbanList}">	
									<c:if test="${row.kanbanState == 'TODO'}">
										<li class="todoList">
											<button class="btn btn-default navbar-btn btn-sm moveDoing"><span class="glyphicon glyphicon-hand-right"></span></button><br/>
											<br/>${row.kanbanContent} <br/>
											<span class="deadline label label-default">마감기한 : <fmt:formatDate value="${row.kanbanDeadline }" pattern="yyyy-MM-dd" /></span>
										</li>
									</c:if>
								</c:forEach>			
							</ul>
						</td>
						<td width="35%" id="kanbanDoing">
							<ul class="doing">
								<c:forEach var="row" items="${kanbanList}">	
									<c:if test="${row.kanbanState == 'DOING'}">
										<li>${row.kanbanContent}</li>
									</c:if>
								</c:forEach>			
							</ul>
						</td>
						<td width="35%" id="kanbanDone">
							<ul class="done">
								<c:forEach var="row" items="${kanbanList}">	
									<c:if test="${row.kanbanState == 'DONE'}">
										<li>${row.kanbanContent}</li>
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