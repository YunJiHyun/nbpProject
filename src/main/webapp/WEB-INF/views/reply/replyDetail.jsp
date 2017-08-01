<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="reply_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>

	$("#btnReplyUpdate").click(function() {
		var replyContent = $("#replyContent").val();
		$.ajax({
			type : "POST",
			url : "${path}/reply/update?replyNum=${reply.replyNum}",
			data :  ({
				replyContent : replyContent
            }),
			dataType : "text",
			success : function(result) {
					$("#modifyReply").hide();
					replyList("1");
			}
		});
	});

	$("#btnReplyClose").click(function() {
		$("#modifyReply").hide();
	});

</script>
</head>
<body>
	댓글 번호 : <b>${reply.replyNum}</b>
	<br>
	<textarea id="replyContent" name="replyContent" rows="5" cols="82">${reply.replyContent}</textarea>
	<div style="text-align: center;">
		<button type="button" id="btnReplyUpdate" class="btn btn-warning">수정</button>
		<button type="button" id="btnReplyClose" class="btn btn-default">수정 취소</button>
	</div> 
</body>
</html>
