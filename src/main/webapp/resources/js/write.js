/**
 * 
 */
$(document).ready( function() {
	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
	});

	$(".fileDrop").on("drop",function(event) {
		event.preventDefault(); // 기본효과 제한
		var files = event.originalEvent.dataTransfer.files; // 드래그한 파일들
		var file = files[0];
		
		if(file.size > 10000000){
			alert("10MB 이하의 파일만 업로드 가능합니다.");
			return false;
		}
			
		var formData = new FormData();

		formData.append("file", file);
		$.ajax({
			type : "POST",
			url : "/jihyunboard/upload/uploadFile", //Upload URL
			data : formData,
			contentType : false,
			processData : false,
			cache : false,
			success : function(data) {
				var fileInfo = getFileInfo(data);
				var html = "<input type='hidden' name='files' class='file' value='"+fileInfo.fullName+"'>";
					html += "<input type='hidden' name='fileSize' id='"+fileInfo.fullName+"' value='"+file.size+"'>";
				var tag = createFile( file.name, file.size, data);	
				$('#fileTable').append(tag);
				$("#uploadedList").append(html);
			}
		});
	});

	$("#btnSave").click(function() {
		var boardTitle = $("#boardTitle").val();
		var boardCategory = $("select[name='boardCategory']").val();
		var boardContent = CKEDITOR.instances.boardContent.getData();
			
		if (boardTitle == "") {
			alert("제목을 입력하세요");
			document.boardWriteForm.boardTitle.focus();
			return false;
		}								
		if (boardCategory == "checking") {
			alert("카테고리를 선택하세요");
			document.boardWriteForm.boardCategory.focus();
			return false;
		}								
		if (boardContent == "") {
			alert("내용을 입력하세요");
			document.boardWriteForm.boardContent.focus();
			return false;
		}
		
		$('#boardWriteForm').attr({ 
			action : "/jihyunboard/board/insert", 
			method : 'post' 
		}).submit();				
	});

	$("#btnBack").click(function() {
		location.href = "/jihyunboard/board/list";
	});

	$("#btnReset").click(function() {
		CKEDITOR.instances.boardContent.setData() == "";
	});

});

function createFile(fileName, fileSize, data) {
	var file = {
			name : fileName,
			size : fileSize,
			format : function() {
				var sizeKB = this.size / 1024;
				if (parseInt(sizeKB) > 1024) {
					var sizeMB = sizeKB / 1024;
					this.size = sizeMB.toFixed(2) + " MB";
				} else {
					this.size = sizeKB.toFixed(2) + " KB";
				}
				//파일이름이 너무 길면 화면에 표시해주는 이름을 변경해준다.
				if (name.length > 70) {
					this.name = this.name.substr(0, 68) + "...";
				}
				return this;
			},
			tag : function() {
				var tag = new StringBuffer();

				tag.append("<tr id='"+data+"'>");
				tag.append('<td>' + this.name + '</td>');
				tag.append('<td>' + this.size + '</td>');
				tag.append("<td><input type='button' value='삭제' onclick='deleteFile(this)' id='" + this.name + "'></input></td>");
				tag.append('</tr>');
				return tag.toString();
			}
		}
	return file.format().tag();
}

function deleteFile(event) {
	dataSource = $(event).parents('tr').attr("id");

	$("input[type='hidden']").each(function() {
		if (this.value == dataSource) {
			$(this).remove();
		}
		if (this.id == dataSource ){
			$(this).remove();
		}
	});
		
	$.ajax({
		url: "/jihyunboard/upload/deleteFile",
		type: "POST",
		data: {fileName: dataSource}, // json방식
		dataType: "text",
		success: function(result){
		}
	});		
	$(event).parents('tr').remove(); //upload한 리스트에서 제거
}