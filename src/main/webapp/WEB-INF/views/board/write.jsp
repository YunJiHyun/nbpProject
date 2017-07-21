<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
<%@ include file="board_header.jsp" %>
<style>
#wrapper {
    margin : 0 auto;
    padding-top : 20pt;
    width : 90%;
   }
h1 { 
    text-align : center;
}
#idDiv {
        text-align : right;
        margin-bottom : 50pt;
       
   }
.form-group {
    margin-bottom : 200pt;
}
#fileDiv {
    margin-left : 100pt;
}
#btnDiv {
    width:100%;
     text-align:center
}
#btnDivInner {
    width : 40%;
    margin:0 auto; 


}
</style>
<script>
    $(document).ready(function(){
        $("#btnSave").click(function(){
            var boardTitle = $("#boardTitle").val();
            var boardCategory = $("select[name='boardCategory']").val();
            var boardContent = CKEDITOR.instances.boardContent.getData();
            
            if(boardTitle == ""){
                alert("제목을 입력하세요");
                document.boardWriteForm.boardTitle.focus();
                return false;
            }
            if(boardCategory == "checking"){
                alert("카테고리를 선택하세요");
                document.boardWriteForm.boardCategory.focus();
                return false;
            }
            if(boardContent == ""){
                alert("내용을 입력하세요");
                document.boardWriteForm.boardContent.focus();
                return false;
            }
            $('#boardWriteForm').attr({action:"${path}/board/insert",method:'post'}).submit();
        });
        
        $("#btnBack").click(function(){
        	location.href = "${path}/board/list";
        });
        
        $("#btnReset").click(function(){
        	CKEDITOR.instances.boardContent.setData()=="";
        });
        
    });
</script>

<script> //ckeditor 적용부분 
    $(function(){
         
        CKEDITOR.replace( 'boardContent', {   //textarea name
            width:'100%',
            height:'400px',
            filebrowserImageUploadUrl: '/community/imageUpload' //여기 경로로 파일을 전달하여 업로드 시킨다.
        });
         
         
        CKEDITOR.on('dialogDefinition', function( event ){
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
	<h1>새 글 작성하기</h1>   
	<div id="idDiv">
            <sec:authentication property="principal.username"/> 님 반갑습니다. 
            <input type="button" id="btnLogout" class="btn btn-default" value="로그아웃"/>
    </div>
	<form class="form-inline" id="boardWriteForm" name="boardWriteForm" >
	    
	    <div class="form-group" id="centerForm">
	        	<label>제목</label>
	        	<input type="text"  class="form-control" name="boardTitle" id="boardTitle" size="80" placeholder="제목을 입력해주세요">
	    </div>
	    
	    <br/><br/>
	    <div class="form-group" >
	        	<label>카테고리 </label>
	        	<select name="boardCategory"  class="form-control">
	        				<option value="checking">--선택해주세요--</option>
	        				<option value="공지">공지</option>
	        				<option value="학사">학사</option>
	        				<option value="장학">장학</option>
	        				<option value="졸업">졸업</option>
	        				<option value="모집">모집</option>
	        		  </select>
	    </div>
	    <br/><br/>
	    <div class="ckeditorBody" >
	           <div class="ckeditor">
	      	       <label>내용 </label>
	      	       <textarea name="boardContent" id="boardContent" rows="5" cols="80" placeholder="내용을 입력해주세요"></textarea>
	           </div>
	    </div>
	    <hr/>
    
	    <div class="form-group" >
            <label>첨부파일 </label> 
            <input type="file">
        </div><br/><br/>
        
	    <div  class="form-group" id="btnDiv">
	       <div id="btnDivInner">
	        <button type="submit" id="btnSave" class="btn btn-success">작성완료</button>&nbsp;&nbsp;&nbsp;&nbsp;
	        <button type="reset" id="btnReset"  class="btn btn-danger">다시 작성</button>&nbsp;&nbsp;&nbsp;&nbsp;
	        <button type="button" id="btnBack" class="btn btn-link">돌아가기</button>
	       </div>
	    </div><br/><br/>
	
	</form>
	</div>
</div>
</body>
</html>