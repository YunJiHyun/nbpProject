/**
 * bookmarkMain.jsp의 javascript 파일
 */
$(document).ready(function() {
	
	$(".bookmarkTd").click(function() {
		var markBoardNum =this.id;
		$.ajax({
			type: "POST",
			url:  "/jihyunboard/bookmark/delete",
			data : {
				markBoardNum:markBoardNum 
			},
			success: function(){
				alert("즐겨찾기 해제");
				location.reload(); 
			} 
		});
	});
});

function list(page) {
	location.href = "/jihyunboard/bookmark/mainList?currentPage=" + page;
}