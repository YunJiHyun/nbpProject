<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>글 읽기</title>
<%@ include file="board_header.jsp" %>
	<style>
		#boardHeader {
				margin-top : 50px;
		}
		#title {
				display : inline-block;
				margin-left : 30px;
				font-size : 25pt;
				font-weight : bold;
				text-align : left 
		}
				
		#categoryAndDate {
				display : inline-block;
				margin-left : 60px;
				font-size : 10pt;
				color : gray;
				text-align : right 
		}
		
		#boardBody {
				margin-left : 30px;
				margin-bottom : 50px;
		}
				
	</style>
</head>
<body>
	
		<div id="boardHeader">
			<span id="title">${BoardDTO.boardTitle }</span>
			<span id="categoryAndDate">${BoardDTO.boardCategory } | ${BoardDTO.boardDate }</span>
		</div>
		<hr/><br/><br/>
	    <div id="boardBody">
	    	${BoardDTO.boardContent }
	    </div>		   
	    	<a href="${path }/board/update?boardNum=${BoardDTO.boardNum}">수정하기</a>&nbsp;&nbsp;	
			<a href="${path }/board/delete?boardNum=${BoardDTO.boardNum}">삭제하기</a> 	
	    <br/>
	    <div>
	    	<input type="button" value="목록"/>
	    </div>
</html>