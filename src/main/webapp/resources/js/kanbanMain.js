/**
 * kanbanMain.jsp의 javascript 파일입니다.
 */
$(document).ready(function() {
	$("#goBoardMain").click(function() {
		alert("게시판 화면으로 돌아갑니다");
		location.href = "/jihyunboard/board/list";
	});
			
	$(".moveDoing").click(function() {
		var kanbanNum = this.id;
		$.ajax({
			type: "POST",
			url: "/jihyunboard/kanban/update?kanbanNum=" + kanbanNum + "&kanbanState=TODO",
			success: function(){
				location.reload(); 
			} 
		});
	});
			
	$(".moveDone").click(function() {
		var kanbanNum = this.id;
		$.ajax({
			type: "POST",
			url: "/jihyunboard/kanban/update?kanbanNum=" + kanbanNum + "&kanbanState=DOING",
			success: function(){
				location.reload(); 
			} 
		});
	});
			
	$(".moveDelete").click(function() {
		var kanbanNum = this.id;
		$.ajax({
			type: "POST",
			url: "/jihyunboard/kanban/update?kanbanNum=" + kanbanNum + "&kanbanState=DONE",
			success: function(){
				location.reload(); 
			} 
		});
	});
});
