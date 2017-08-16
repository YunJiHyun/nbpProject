<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="board_header.jsp"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>글 읽기</title>
	<script src="<c:url value="/resources/js/board_view.js"></c:url>"></script>
	<link rel="stylesheet" href="<c:url value='/resources/css/board_view.css'></c:url>"/>
	<script src="<c:url value="/resources/js/jquery-ui.js"></c:url>"></script>
	<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"></c:url>">
	<script>
		var dialog;
		
		$(document).ready(function() {
			viewFileList();
			replyList("1");
			
			 dialog = $( "#dialog" ).dialog({
				autoOpen: false,
				height: 700,
				width: 600,
				position:{ my: "center", at: "center", of: window }
			});
			
			 var backParam = "currentPage=${currentPage}&searchOption=${searchPageHelper.searchOption}"
					+"&keyword=${searchPageHelper.keyword}&category=${searchPageHelper.category}";
					
			$("#btnBack").click(function() {
				var params = getParams();
				if(params["dateKeyword"] == undefined){
					location.href = "${path}/board/list?"+ backParam + "&pageScale=${pageScale}";
				}else {
					location.href = "${path}/board/myList?" + backParam;
				}
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
			
			$(".blackStarTd").click(function() {
				var markBoardNum =this.id;
				$.ajax({
					type: "POST",
					url:  "${path}/bookmark/insert",
					data : {
						markBoardNum:markBoardNum 
					},
					success: function(){
						alert("즐겨찾기 등록");
						location.reload(); 
					} 
				});
			});
			
			$(".goldStarTd").click(function() {
				var markBoardNum =this.id;
				$.ajax({
					type: "POST",
					url:  "${path}/bookmark/delete",
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
	
		function deleteBoard(){
			var replyCount = "${replyCount}";
			if(replyCount >0){
				alert("댓글이 있는 게시물은 삭제할 수 없습니다.");
				return;
			} else {
				location.href= "${path }/board/delete?boardNum=${BoardDTO.boardNum}";
			}
		}
		
		function viewFileList() {
			$.ajax({
				type : "POST",
				url : "${path}/board/getFileList/${BoardDTO.boardNum}",
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
		
		function replyList(num){
			$.ajax({
				type: "GET",
				url: "${path}/reply/list?boardNum=${BoardDTO.boardNum}&currentPage="+num,
				success: function(result){
					$("#replyList").html(result);
				}
			});
		}
		
	 	function addMyKanban(){
	 		$.ajax({
				type: "POST",
				url: "${path}/kanban/write?boardNum=${BoardDTO.boardNum}",
				success: function(result){
					$("#dialog").html(result);
				}
			});
	 		dialog.dialog("open");	 
		} 
	</script>
</head>
<body>
	<div id="wrapper">
		<div id="boardHeader">
			<c:if test="${BoardDTO.boardBookmark == 'N'}">
				<div id="${BoardDTO.boardNum}" class="blackStarTd" style="width:100px; height:50px;">
					<img class="bookmarkblackStar" src="<c:url value="/resources/img/blackstar.png"></c:url>" width="50" height="50"/>
				</div>
			</c:if>
			<c:if test="${BoardDTO.boardBookmark == 'Y'}">
				<div id="${BoardDTO.boardNum}" class="goldStarTd" style="width:100px; height:50px;">
					<img class="bookmarkgoldStar" src="<c:url value="/resources/img/goldstar.png"></c:url>" width="50" height="50"/>
				</div>
			</c:if>
			<div style="width: 900px" id="boardTitle"><c:out value='${BoardDTO.boardTitle }'/></div>
			<div id="idDiv">
				<form id="logout" action="${pageContext.request.contextPath}/logout" method="post">
					<b><sec:authentication property="principal.userName" /></b> 님 반갑습니다. 
					<input type="submit" id="btnLogout" class="btn btn-default" value="로그아웃" /> 
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
			<br />
			<div id="categoryAndDate">${BoardDTO.boardCategory } &nbsp;|&nbsp;
				<fmt:formatDate value="${BoardDTO.boardDate }" pattern="yyyy-MM-dd HH:mm:ss" />
			</div>
			<div id="addKanban">
				<table style="width : 100%">
					<tr>
						<td id="kanbanTd">
							<c:if test="${alreadyKanban == 0}">
								<input type="button" class="btn btn-warning" id="addMyKanban" value="kanban board에 추가" onclick="addMyKanban()"/>
							</c:if>
							<c:if test="${alreadyKanban != 0}">
								<input type="button" class="btn btn-warning" value="kanban board에 이미 추가된 게시글입니다." disabled="disabled"/>
							</c:if>
						</td>
						<td align="right">
							조회수 <span class="badge">${BoardDTO.boardReadCount}</span>
						</td>
					</tr>
				</table>			
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
					<a href="${path }/board/modify?boardNum=${BoardDTO.boardNum}&currentPage=${currentPage}
							&searchOption=${searchPageHelper.searchOption}&keyword=${searchPageHelper.keyword}">수정하기
					</a>&nbsp;&nbsp;	
					<a href="javascript:deleteBoard()">삭제하기</a>
					<br />
				</c:if>
			</div>
			<br /> <br />
			<div id="replyOuter">
				<button type="button" id="btnShowRelpy" class="btn btn-default ">
					<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>댓글 보기
				</button>
				<br /><br />
				<div id="replyDiv" class="view" style="display: none; width: 70%; background-color: #a3ca61">
					<div id="replyList"></div>
					<div id="writeReplyDiv" style="width: 650px; display: inline; text-align: left;"><br />
						<table>
							<tr>
								<td><textarea rows="3" cols="80" name="replyContent"id="replyContent" style="resize: none;" placeholder="댓글을 작성해주세요"></textarea>
								</td>
								<td>
									<button type="button" id="btnReply" class="btn btn-default" style="color: green;">COMMENT</button>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<br /> <br />
			<div id="btnInner">
				<input type="button" id="btnBack" class="btn btn-primary" value="목록" />
			</div>
		</div>
	</div>
	<div id="dialog" title="Kanban"></div>
</body>
</html>