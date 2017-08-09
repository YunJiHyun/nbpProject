<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../board/board_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>글 정보</title>
	<script>
		$(document).ready(function() {
			viewFileList();
		});
		
		function viewFileList() {
			$.ajax({
				type : "POST",
				url : "${path}/board/getFileList/${board.boardNum}",
				success : function(data) {
					fileData = JSON.stringify(data);
					for(var i = 0 ; i < data.length ; i++){
						var fileInfo = getFileInfo(data[i].fileName);
						var html = "<li><a href='"+fileInfo.getLink+"'>" + fileInfo.fileName + "</li>";
						$("#uploadedList").append(html);
					}
				}
			});
		}
	</script>
	<style>
	.fileDrop {
		background-color : lightgrey;
		padding : 5px;
	}
	</style> 
</head>
<body>
	<div class="page-header">
  		<h2><small>제목 : </small> ${board.boardTitle }</h2>
	</div>
	<div>
		${board.boardContent}
	</div>
	<div class="fileDrop">
		<span class="label label-primary">첨부파일 목록 </span>
		<br/><br/>
		<div id="uploadedList"></div>
	</div>
</body>
</html>