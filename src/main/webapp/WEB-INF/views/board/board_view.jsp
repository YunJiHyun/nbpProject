<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="board_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 읽기</title>
<link rel="stylesheet"
	href="<c:url value='/resources/css/board_view.css'></c:url>" />
<script>
	$(document).ready(function() {
		viewFileList();
		replyList("1");
		
		$("#btnBack").click(function() {
			location.href = "${path}/board/list?currentPage=${currentPage}&searchOption=${searchOption}&keyword=${keyword}";
		});
		
		$("#btnReply").click(function(){
			var replyContent=$("#replyContent").val();
			var boardNum="${BoardDTO.boardNum}"
			var parameter="replyContent="+replyContent+"&boardNum="+boardNum;
			$.ajax({
				type: "POST",
				url: "${path}/reply/insert",
				data: parameter,
				success: function(){
					replyList("1");
					$("#replyContent").val("");
				}
			}); 
		});

		
		$(document).keydown(function(e) {
			if (e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA") {
				if (e.keyCode === 8) {
					return false;
				}
			}
		});
		
		 $("#btnShowRelpy").click(function() {
			if($("#replyDiv").hasClass("view")){
				$("#replyDiv").show();
				$("#replyDiv").removeClass('view')
				$("#btnShowRelpy span").attr("class","glyphicon glyphicon-chevron-up");
			}else{
				$("#replyDiv").hide();
				$("#replyDiv").addClass("view");
				$("#btnShowRelpy span").attr("class","glyphicon glyphicon-chevron-down");
			}		 	
		});  

	});

	function viewFileList() {
		$.ajax({
			type : "POST",
			url : "${path}/board/getFileList/${BoardDTO.boardNum}",
			success : function(data) {
				$(data).each(
						function() {
							var fileInfo = getFileInfo(this);
							var html = "<li><a href='"+fileInfo.getLink+"'>"
									+ fileInfo.fileName + "</li>";
							$("#uploadedList").append(html);
						});
			}
		});
	}
	
	function replyList(num){
		$.ajax({
			type: "GET",
			url: "${path}/reply/list?boardNum=${BoardDTO.boardNum}&currentPage="+num,
			success: function(result){
				$("#replyList").html(result);
			}
		});
	}

</script>
</head>
<body>
	<div id="wrapper">
		<div id="boardHeader">
			<div style="width: 900px" id="boardTitle">${BoardDTO.boardTitle }</div>
			<div id="idDiv">
				<form id="logout" action="${pageContext.request.contextPath}/logout"
					method="post">
					<b><sec:authentication property="principal.userName" /></b> 님
					반갑습니다. <input type="submit" id="btnLogout" class="btn btn-default"
						value="로그아웃" /> <input type="hidden"
						name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
			<br />
			<div id="categoryAndDate">${BoardDTO.boardCategory }
				<fmt:formatDate value="${BoardDTO.boardDate }"
					pattern="yyyy-MM-dd HH:mm:ss" />
			</div>
		</div>
		<hr />
		<br /> <br />
		<div id="boardBody">${BoardDTO.boardContent }</div>
		<hr />
		<div class="fileDrop">첨부파일 목록</div>
		<br />
		<div id="uploadedList"></div>
		<br /> <br />
		<div id="btnOuter">
			<div id="btnhidden">
				<input type="hidden" name="boardNum" value="${BoardDTO.boardNum}">
				<c:if test="${BoardDTO.boardUserId eq userId}">
					<a href="${path }/board/modify?boardNum=${BoardDTO.boardNum}&currentPage=${currentPage}&searchOption=${searchOption}&keyword=${keyword}">수정하기</a>&nbsp;&nbsp;	
			     	<a href="${path }/board/delete?boardNum=${BoardDTO.boardNum}">삭제하기</a>
					<br />
				</c:if>
			</div>
			<br /> <br />
			<div id="replyOuter">
				<button type="button" id="btnShowRelpy" class="btn btn-default ">
					<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span> 댓글 보기
				</button>
				<br/><br/>
				<div id="replyDiv" class="view" style=" display:none; width:70%; background-color: #a3ca61">
					<div id="replyList"></div>
					
					<div id="writeReplyDiv"
						style="width: 650px; display: inline; text-align: left;">
						<br />
						<table>
							<tr>
								<td><textarea rows="3" cols="80" name="replyContent"
										id="replyContent" style="resize: none;"
										placeholder="댓글을 작성해주세요"></textarea>
								</td>
								<td>
									<button type="button" id="btnReply" class="btn btn-default" style="color:green;">COMMENT</button>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<br />
			<br />
			<div id="btnInner">
				<input type="button" id="btnBack" class="btn btn-primary" value="목록" />
			</div>
		</div>
	</div>
</body>
</html>