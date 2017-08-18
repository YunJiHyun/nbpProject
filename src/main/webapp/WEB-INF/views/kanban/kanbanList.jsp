<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="kanban_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<c:url value="/resources/js/kanbanList.js"></c:url>"></script>
	<title>칸반테이블</title>
	
</head>
<body>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th style="text-align:center" >TODO<span id="todoNum" style="color:blue"></span></th>
				<th id="doingTh" style="text-align:center">DOING<span id="doingNum" style="color:blue"></span></th>
				<th id="doneTh" style="text-align:center">DONE<span id="doneNum" style="color:blue"></span></th>
			</tr>
		</thead>
		<tbody>
			<tr id="kanbanBody"> 
				<td width="33%" id="kanbanTodo">
					<ul id="todo" class="connectedSortable">
						<c:forEach var="row" items="${kanbanList}">	
							<fmt:formatDate var="deadline" value="${row.kanbanDeadline }" pattern="yyyy-MM-dd" />
							<fmt:formatDate  var="today" value="${now}" pattern="yyyy-MM-dd"/>
							<c:if test="${row.kanbanState == 'TODO'}">
								<li class="todoList"  id="${row.kanbanNum}"  data-importance="${row.kanbanImportance}">
									<div class="todoContentDiv">
										<c:if test="${row.kanbanBoardNum eq ''}"> 
											${row.kanbanContent} <br/>
										</c:if>
										<c:if test="${row.kanbanBoardNum ne ''}"> 
											<a href="javascript:viewDetailDialog('${row.kanbanBoardNum}')">${row.kanbanContent}</a> <br/>
										</c:if>
									</div>
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
					<ul id="doing" class="connectedSortable">
						<c:forEach var="row" items="${kanbanList}">	
							<fmt:formatDate var="deadline" value="${row.kanbanDeadline }" pattern="yyyy-MM-dd" />
							<fmt:formatDate  var="today" value="${now}" pattern="yyyy-MM-dd"/>
							<c:if test="${row.kanbanState == 'DOING'}">
								<li class="doingList" id="${row.kanbanNum}" data-importance="${row.kanbanImportance}">
									<div class="doingContentDiv">
										<c:if test="${row.kanbanBoardNum eq ''}"> 
											${row.kanbanContent} <br/>
										</c:if>
										<c:if test="${row.kanbanBoardNum ne ''}"> 
											<a href="javascript:viewDetailDialog('${row.kanbanBoardNum}')">${row.kanbanContent}</a> <br/>
										</c:if>
									</div>
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
					<ul id="done" class="connectedSortable">
						<c:forEach var="row" items="${kanbanList}">
							<fmt:formatDate var="deadline" value="${row.kanbanDeadline }" pattern="yyyy-MM-dd" />
							<fmt:formatDate  var="today" value="${now}" pattern="yyyy-MM-dd"/>	
							<c:if test="${row.kanbanState == 'DONE'}">
								<li class="doneList ui-state-default" id="${row.kanbanNum}" data-importance="${row.kanbanImportance}">
									<button id="${row.kanbanNum}" class="btn btn-default navbar-btn btn-sm btnKanbanDelete">
										<span class="glyphicon glyphicon-remove"></span>
									</button><br/><br/>
									<div class="doneContentDiv">
										<c:if test="${row.kanbanBoardNum eq ''}"> 
											${row.kanbanContent} <br/>
										</c:if>
										<c:if test="${row.kanbanBoardNum ne ''}"> 
											<a href="javascript:viewDetailDialog('${row.kanbanBoardNum}')">${row.kanbanContent}</a> <br/>
										</c:if>
									</div>
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