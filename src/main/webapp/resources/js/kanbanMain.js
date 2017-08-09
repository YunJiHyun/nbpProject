/**
 * kanbanMain.jsp의 javascript 파일입니다.
 */
$(document).ready(function() {
	
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
		
		if (kanbanContent == "") {
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
				window.location.reload(true);
				alert("새로운 해야할 일이 등록되었습니다");
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
				window.location.reload(true);
			} 
		});
	});
			
	$(".moveDone").click(function() {
		var kanbanNum = this.id;
		$.ajax({
			type: "POST",
			url: movingUrl + kanbanNum + "&kanbanState=DOING",
			success: function(){
				window.location.reload(true);
			} 
		});
	});
			
	$(".moveDelete").click(function() {
		var kanbanNum = this.id;
		$.ajax({
			type: "POST",
			url: movingUrl + kanbanNum + "&kanbanState=DONE",
			success: function(){
				window.location.reload(true);   
			} 
		});
	});
});

function checkWord(obj, maxByte) {
	var strValue = obj.value;
	var strLen = strValue.length;
	var totalByte = 0;
	var len = 0;
	var oneChar = "";
	var str2 = "";

	for (var i = 0; i < strLen; i++) {
		oneChar = strValue.charAt(i);
		if (escape(oneChar).length > 4) {
			totalByte += 2; //한글이라면 2byte 증가
		} else {
			totalByte++; //아니라면 1byte 증가
		}

		if (totalByte <= maxByte) {
			len = i + 1;
		}
	}

	// 글자 초과시 마지막 글자 자르기.
	if (totalByte > maxByte) {
		alert(maxByte/2 + "글자를 초과 할 수 없습니다.");
		str2 = strValue.substr(0, len);
		obj.value = str2;
	}
}

function viewDetailDialog(boardNum){
	$.ajax({
		type: "POST",
		url: "/jihyunboard/kanban/viewDetailDialog?boardNum="+boardNum,
		success: function(result){
			$("#dialog").html(result);
		} 
	});
	dialog.dialog("open");	 
}
