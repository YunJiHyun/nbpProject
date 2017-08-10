/**
 * kanbanMain.jsp의 javascript 파일입니다.
 */


function kanbanList(){
	$.ajax({
		type: "GET",
		url: "/jihyunboard/kanban/kanbanList",
		success: function(result){
			$("#kanbanBoard").html(result);
		}
	});
}

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
		if(maxByte>0){
			alert(maxByte/2 + "글자를 초과 할 수 없습니다.");
		} else{
			alert("날짜는 직접입력할 수 없습니다, 달력에서 선택해주세요");
		}
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
