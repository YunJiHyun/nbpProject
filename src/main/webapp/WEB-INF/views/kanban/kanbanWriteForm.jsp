<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="kanban_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<c:url value='/resources/js/kanbanMain.js'></c:url>"></script>
	<link rel="stylesheet" href="<c:url value='/resources/css/kanban.css'></c:url>"/>
	<title>칸반</title>
	<script>
		$(document).ready( function() {
			$("input[name='kanbanDeadline']").datepicker('disable').removeAttr("readonly",true);
			$("#kanbanDeadline").datepicker({dateFormat : "yy-mm-dd", minDate: 0, maxDate: "+2M" });
			$("#btnSave").click(function() {
				var kanbanContent = $("#kanbanContent").val();
				var kanbanImportance = $("select[name='kanbanImportance']").val();
				var kanbanDeadline = $("#kanbanDeadline").val();
					
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
					url: "${path}/kanban/insert?kanbanBoardNum=${board.boardNum }&kanbanState=TODO",
					data : { 
						kanbanContent : kanbanContent,
						kanbanImportance : kanbanImportance,
						kanbanDeadline : kanbanDeadline
					},
					success: function(todoNum){
						if(todoNum >= 10){
							alert("TODO가 현재 10개가 있어 더 이상 추가가 불가능합니다");
						}else {
							alert("칸반보드에 등록되었습니다.");
						}
					}
				});
			});
		});
	</script>
</head>
<body>
	<div id="wrapper">
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
						<textarea class="form-control" name="kanbanContent" id="kanbanContent" rows="2" cols="40" onkeyup="checkWord(this, 60)" style="resize: none; " placeholder="해야할 일을 입력해주세요"></textarea>
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
							<button type="reset" id="btnReset" class="btn btn-danger">다시작성</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>