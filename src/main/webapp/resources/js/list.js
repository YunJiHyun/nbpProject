/**
 * 
 */
$(document).ready(function() {
	$( "#dialog" ).dialog({
		autoOpen: false,
		modal: true,
		position:{ my: "center", at: "center", of: window }, 
		show: {
			effect: "blind",
			duration: 1000
		},
		hide: {
			effect: "explode",
			duration: 1000
		}
	});
	
	$("#btnWrite").click(function() {
		location.href = "/jihyunboard/board/write";
	});
	
	$(".starTd").click(function() {
		var markBoardNum =this.id;
		$.ajax({
			type: "POST",
			url:  "/jihyunboard/bookmark/insert",
			data : {
				markBoardNum:markBoardNum 
			},
			success: function(){
				alert("즐겨찾기 등록");
				location.reload(); 
			} 
		});
	});
});