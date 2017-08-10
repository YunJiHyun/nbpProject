<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="kanban_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<c:url value='/resources/css/kanban.css'></c:url>"/>
	<link rel="stylesheet" href="<c:url value='/resources/css/kanbanMain.css'></c:url>"/>
	<script src="<c:url value="/resources/js/kanbanMain.js"></c:url>"></script>
	<title>칸반테이블</title>
	<script>
	$(document).ready(function() {
		var movingUrl = "/jihyunboard/kanban/update?kanbanNum=";
	
		$(".moveDoing").click(function() {
			var kanbanNum = this.id;
			$.ajax({
				type: "POST",
				url: movingUrl + kanbanNum + "&kanbanState=DOING",
				success: function(doingNum){
					if(doingNum >= 6){
						alert("DOING은 6개까지만 가능합니다");
					}
					kanbanList();
				} 
			});
		});
				
		$(".moveDone").click(function() {
			var kanbanNum = this.id;
			$.ajax({
				type: "POST",
				url: movingUrl + kanbanNum + "&kanbanState=DONE",
				success: function(doneNum){
					if(doneNum >= 8){
						alert("DONE은 8개까지만 가능합니다");
					}
					kanbanList();
				} 	
			});
		});
				
		$(".moveDelete").click(function() {
			var kanbanNum = this.id;
			$.ajax({
				type: "POST",
				url: movingUrl + kanbanNum + "&kanbanState=DELETE",
				success: function(){
					kanbanList();
				} 
			});
		});
	});
	</script>
</head>
<body>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th style="text-align:center" >TODO</th>
				<th style="text-align:center">DOING</th>
				<th style="text-align:center">DONE</th>
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
									</button><br/><br/>
									<c:if test="${row.kanbanBoardNum eq ''}"> 
										${row.kanbanContent} <br/>
									</c:if>
									<c:if test="${row.kanbanBoardNum ne ''}"> 
										<a href="javascript:viewDetailDialog('${row.kanbanBoardNum}')">${row.kanbanContent}</a> <br/>
									</c:if>
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
									<button id="${row.kanbanNum}" class="btn btn-default navbar-btn btn-sm moveDone">
										<span class="glyphicon glyphicon-hand-right"></span>
									</button><br/><br/>
									<c:if test="${row.kanbanBoardNum eq ''}"> 
										${row.kanbanContent} <br/>
									</c:if>
									<c:if test="${row.kanbanBoardNum ne ''}"> 
										<a href="javascript:viewDetailDialog('${row.kanbanBoardNum}')">${row.kanbanContent}</a> <br/>
									</c:if>
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
									<button id="${row.kanbanNum}" class="btn btn-default navbar-btn btn-sm moveDelete">
										<span class="glyphicon glyphicon-remove"></span>
									</button><br/><br/>
									<c:if test="${row.kanbanBoardNum eq ''}"> 
										${row.kanbanContent} <br/>
									</c:if>
									<c:if test="${row.kanbanBoardNum ne ''}"> 
										<a href="javascript:viewDetailDialog('${row.kanbanBoardNum}')">${row.kanbanContent}</a> <br/>
									</c:if>
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
</body>
</html>