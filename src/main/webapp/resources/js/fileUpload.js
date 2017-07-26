function checkImageType(fileName){
    var pattern = /jpg|gif|png|jpeg/i;
    return fileName.match(pattern);
}

// 업로드 파일 정보
function getFileInfo(fullName){
    var fileName, imgsrc, getLink, fileLink;
 
    if(checkImageType(fullName)){
     
        imgsrc = "/jihyunboard/upload/displayFile?fileName="+fullName; 
        fileLink = fullName.substr(14);
        var front = fullName.substr(0, 12);
        console.log(front);
        var end = fullName.substr(14);
        getLink = "/jihyunboard/upload/displayFile?fileName="+front+end;


    } else {

        fileLink = fullName.substr(12);
        getLink = "/jihyunboard/upload/displayFile?fileName="+fullName;

    }
    
    fileName = fileLink.substr(fileLink.indexOf("_")+1);
   
    return {fileName:fileName, imgsrc:imgsrc, getLink:getLink, fullName:fullName};
}
