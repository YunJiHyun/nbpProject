<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="kanban_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>kanban</title>
	<script>
		$(document).ready(function() {
			kanbanList();
			$("input[name='kanbanDeadline']").datepicker('disable').removeAttr("readonly",true);
			
			$( "#kanbanDeadline" ).datepicker({
				dateFormat : "yy-mm-dd", 
				minDate: 0, 
				maxDate: "+1M"
			});
			
			dialog = $( "#dialog" ).dialog({
				autoOpen: false,
				height: 700,
				width: 600,
				position:{ my: "center", at: "center", of: window }
			});
			
			$("#goBoardMain").click(function() {
				alert("게시판 화면으로 돌아갑니다");
				location.href = "/jihyunboard/board/list";
			});
			
			$("#btnSave").click(function() {
				var kanbanContent = $("#kanbanContent").val();
				var kanbanImportance = $("select[name='kanbanImportance']").val();
				var kanbanDeadline = $("#kanbanDeadline").val();
				var kanbanBoardNum = 0;
				
				if (kanbanContent == "") {
					alert("할 일을 입력하세요");
					document.kanbanWriteForm.kanbanContent.focus();
					return false;
				}								
				if (kanbanImportance == "checking") {
					alert("중요도를 선택하세요");
					document.kanbanWriteForm.kanbanImportance.focus();
					return false;
				}								
				if (kanbanDeadline == "") {
					alert("마감날짜를 입력하세요");
					document.kanbanWriteForm.kanbanDeadline.focus();
					return false;
				}
	
				$.ajax({
					type: "GET",
					url: "/jihyunboard/kanban/insert?kanbanBoardNum="+ kanbanBoardNum +"&kanbanState=TODO",
					data : { 
						kanbanContent : kanbanContent,
						kanbanImportance : kanbanImportance,
						kanbanDeadline : kanbanDeadline
					},
					async: false, 
					success: function(data){
						if(data >= 10){
							alert("TODO가 현재 10개가 있어 더 이상 추가가 불가능합니다");
						}else {
							alert("칸반보드에 등록되었습니다.");
						}
						//kanbanList();
					}			
				});
			});
		});
	</script>
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
						<input type="text" class="form-control" name="kanbanContent" id="kanbanContent" onkeyup="checkWord(this, 60)" size="100" placeholder="해야할 일을 입력해주세요">
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
						<input type="text" id="kanbanDeadline" class="form-control" name="kanbanDeadline" onkeyup="checkWord(this, 0)" size="20">
					</div>
					<br /> <br />
					<div class="form-group" id="btnDiv">
						<div id="btnDivInner">
							<button type="submit" id="btnSave" class="btn btn-success">등록</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="reset" id="btnReset" class="btn btn-danger">내용 지우기</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div id="kanbanBoard"></div>
	</div>
	<div id="dialog" title="해당 게시물 내용"></div>
</body>
</html>