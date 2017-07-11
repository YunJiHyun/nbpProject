<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
</head>
<script>
    $(document).ready(function(){
        $("#btnSave").click(function(){
            var title = $("#title").val();
            var category = $("select[name='category']").val();
            var content = $("#content").val();
            
            if(title == ""){
                alert("제목을 입력하세요");
                document.boardWriteForm.title.focus();
                return;
            }
            if(category == "checking"){
                alert("카테고리를 선택하세요");
                document.boardWriteForm.category.focus();
                return;
            }
            if(content == ""){
                alert("내용을 입력하세요");
                document.boardWriteForm.content.focus();
                return;
            }
        
            document.boardWriteForm.submit();//서버로 전송
        });
    });
</script>
</head>
<body>
	<h1>새 글 작성하기</h1>
	<form name="boardWriteForm" method="post" action="${path}/board/insert">
	    <div>
	        	제목 <input name="title" id="title" size="80" placeholder="제목을 입력해주세요">
	    </div>
	    <div>
	        	카테고리 <select name="category">
	        				<option value="checking">--선택해주세요--</option>
	        				<option value="">공지</option>
	        				<option value="">학사</option>
	        				<option value="">장학</option>
	        				<option value="">졸업</option>
	        				<option value="">모집</option>
	        		  </select>
	    </div>
	    <div>
	      	  내용 <textarea name="content" id="content" rows="5" cols="80" placeholder="내용을 입력해주세요"></textarea>
	    </div>
	    <div style="width:650px; text-align: center;">
	        <button type="button" id="btnSave">작성완료</button>
	        <button type="reset">다시 작성</button>
	        <button type="button">돌아가기</button>
	    </div>
	</form>
</body>
</html>