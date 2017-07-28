<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 수정</title>
<%@ include file="board_header.jsp"%>
<style>
#wrapper {
	margin: 0 auto;
	padding-top: 20pt;
	width: 90%;
}

h1 {
	text-align: center;
}

#idDiv {
	text-align: right;
	margin-bottom: 50pt;
}

.form-group {
	margin-bottom: 200pt;
}

#fileDiv {
	margin-left: 100pt;
}

#btnDiv {
	width: 100%;
	text-align: center
}

#btnDivInner {
	width: 40%;
	margin: 0 auto;
}
.fileDrop {
	width: 600px;
	height: 150px;
	border: 2px dotted gray;
	background-color: white;
	padding-top: 30px;
	text-align: center;
	font-size: 20pt;
	font-weight: bold;
}

#tabFileName {
	width: 470px;
	text-align: left;
}

#tabFileSize {
	width: 70px;
}

#tabFileDel {
	width: 50px;
}
</style>
<script>
	$(document).ready(function() {
		viewFileList();
		$(".fileDrop").on("dragenter dragover", function(event) {
			event.preventDefault();
		});

		$(".fileDrop").on("drop",function(event) {
			event.preventDefault(); // 기본효과 제한
			var files = event.originalEvent.dataTransfer.files; // 드래그한 파일들
			var file = files[0];

			var formData = new FormData();
			formData.append("file", file);
			$.ajax({
					type : "POST",
					url : "${path}/upload/uploadFile", //Upload URL
					data : formData,
					contentType : false,
					processData : false,
					cache : false,
					success : function(data) {
						var fileInfo = getFileInfo(data);
						var html = "<input type='hidden' name='files' class='file' value='"+fileInfo.fullName+"'>";
						var tag = createFile(
							file.name,
							file.size,
							data);
							$('#fileTable').append(tag);
							$("#uploadedList").append(html);

				}
			});
		});
		
		
		$("select[name='boardCategory']").val('${BoardDTO.boardCategory}');

		$("#btnSave").click(function() {
			var boardTitle = $("#boardTitle").val();
			var boardCategory = $("select[name='boardCategory']").val();
			var boardContent = CKEDITOR.instances.boardContent.getData();

			if (boardTitle == "") {
				alert("제목을 입력하세요");
				document.boardUpdateForm.boardTitle.focus();
				return false;
			}
			if (boardCategory == "checking") {
				alert("카테고리를 선택하세요");
				document.boardUpdateForm.boardCategory.focus();
				return false;
			}
			if (boardContent == "") {
				alert("내용을 입력하세요");
				document.boardUpdateForm.boardContent.focus();
				return false;
			}
			
			$('#boardUpdateForm')
			.attr(
					{
						action : action="${path}/board/update?boardNum=${BoardDTO.boardNum}&currentPage=${currentPage}&searchOption=${searchOption}&keyword=${keyword}",
						method : 'post'
					}).submit();

		});

		$("#btnLogout").click(function() {
			// 페이지 주소 변경(이동)
			alert("로그아웃하셨습니다.");
			location.href = "${path}/j_spring_security_logout";
		});

		$("#btnBack").click(function() {
			location.href = "${path}/board/view?boardNum=${BoardDTO.boardNum}&currentPage=${currentPage}&searchOption=${searchOption}&keyword=${keyword}";
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
				tag
						.append("<td><input type='button' value='삭제' onclick='deleteFile(this)' id='"
								+ this.name + "'></input></td>");
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
		});

		$(event).parents('tr').remove(); //upload한 리스트에서 제거

	}
	
	function viewFileList() {
		$.ajax({
			type : "POST",
			url : "${path}/board/getFileList/${BoardDTO.boardNum}",
			success : function(data) {
				$(data).each(
						function() {
							var fileInfo = getFileInfo(this);
							
							var fileListHtml = "<tr id='"+fileInfo.fullName +"'><td>"+ fileInfo.fileName +"</td>";
							fileListHtml += "<td></td>";
							fileListHtml += "<td><input type='button' value='삭제' onclick='deleteFile(this)' id='" +fileInfo.fullName + "'></input></td>";
							fileListHtml += "</tr>";	
							$("#fileTable").append(fileListHtml);
							
							var hiddenListHtml = "<input type='hidden' name='files' class='file' value='"+fileInfo.fullName+"'>";
							$("#uploadedList").append(hiddenListHtml);
						});
			}
		});
	}
	
</script>
<script>
	//ckeditor 적용부분 
	$(function() {

		CKEDITOR.replace('boardContent', { //textarea name
			width : '100%',
			height : '400px',
		//filebrowserImageUploadUrl: '/community/imageUpload' //여기 경로로 파일을 전달하여 업로드 시킨다.
		});

		CKEDITOR.on('dialogDefinition', function(event) {
			var dialogName = event.data.name;
			var dialogDefinition = event.data.definition;

			switch (dialogName) {
			case 'image':
				//dialogDefinition.removeContents('info');
				dialogDefinition.removeContents('Link');
				dialogDefinition.removeContents('advanced');
				break;
			}
		});

	});
</script>
</head>
<body>
	<div id="wrapper">
		<h1>글 수정하기</h1>
		<div id="idDiv">
			<b><sec:authentication property="principal.userName" /></b> 님 반갑습니다.
			<input type="button" id="btnLogout" class="btn btn-default"
				value="로그아웃" />
		</div>
		<form class="form-inline" name="boardUpdateForm" id="boardUpdateForm">
			<div class="form-group">
				<label>제목</label> <input type="text" class="form-control"
					name="boardTitle" id="boardTitle" size="80"
					value="${BoardDTO.boardTitle }">
			</div>
			<br /> <br />
			<div class="form-group">
				<label>카테고리 </label> <select name="boardCategory"
					class="form-control">
					<option value="checking">--선택해주세요--</option>
					<option value="공지">공지</option>
					<option value="학사">학사</option>
					<option value="장학">장학</option>
					<option value="졸업">졸업</option>
					<option value="모집">모집</option>
				</select>
			</div>
			<br /> <br />
			<div class="ckeditorBody">
				<div class="ckeditor">
					<label>내용 </label>
					<textarea name="boardContent" id="boardContent" rows="5" cols="80">${BoardDTO.boardContent }</textarea>
				</div>
			</div>
			<hr />
			<div class="form-group">
				첨부파일
				<div class="fileDrop">Drag & Drop here</div>
				<br />
				<div id="uploadedList">
				</div>
				<div id="fileList">
					<table class="table table-bordered" id="fileTable">
						<tr>
							<td id='tabFileName'>파일명</td>
							<td id='tabFileSize'>사이즈</td>
							<td id='tabFileDel'>삭제</td>
						</tr>
					</table>
				</div>
			</div>
			<br /> <br /> <br /> <br />

			<div class="form-group" id="btnDiv">
				<button type="submit" id="btnSave" class="btn btn-success">수정완료</button>
				<button type="button" id="btnBack" class="btn btn-link">돌아가기</button>
			</div>
			<br /> <br />
		</form>
	</div>
</body>
</html>