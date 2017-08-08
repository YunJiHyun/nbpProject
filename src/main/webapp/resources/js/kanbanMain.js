/**
 * kanbanMain.jsp의 javascript 파일입니다.
 */
$(document).ready(function() {
	$( "#kanbanDeadline" ).datepicker({dateFormat : "yy-mm-dd", minDate: +1, maxDate: "+1M" });
	
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
			type: "POST",
			url: "/jihyunboard/kanban/insert?kanbanBoardNum="+ kanbanBoardNum,
			data : { 
				kanbanContent : kanbanContent,
				kanbanImportance : kanbanImportance,
				kanbanDeadline : kanbanDeadline
			},
			success: function(){
				alert("새로운 해야할 일이 등록되었습니다");
				location.reload(); 
			}
		});
	});
	
	
	var movingUrl = "/jihyunboard/kanban/update?kanbanNum=";
	
	$(".moveDoing").click(function() {
		var kanbanNum = this.id;
		$.ajax({
			type: "POST",
			url: movingUrl + kanbanNum + "&kanbanState=TODO",
			success: function(){
				location.reload(); 
			} 
		});
	});
			
	$(".moveDone").click(function() {
		var kanbanNum = this.id;
		$.ajax({
			type: "POST",
			url: movingUrl + kanbanNum + "&kanbanState=DOING",
			success: function(){
				location.reload(); 
			} 
		});
	});
			
	$(".moveDelete").click(function() {
		var kanbanNum = this.id;
		$.ajax({
			type: "POST",
			url: movingUrl + kanbanNum + "&kanbanState=DONE",
			success: function(){
				location.reload(); 
			} 
		});
	});
});
