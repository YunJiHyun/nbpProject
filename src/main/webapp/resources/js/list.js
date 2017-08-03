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
});