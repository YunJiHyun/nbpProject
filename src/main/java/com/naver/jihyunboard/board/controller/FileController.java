package com.naver.jihyunboard.board.controller;

import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.naver.jihyunboard.board.service.UploadFileHelper;

@Controller
@RequestMapping("/upload/*")
public class FileController {

    public final static String BASE_PATH = "D:/fileUpload";

    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> uploadFile(MultipartFile file) throws Exception {

        return new ResponseEntity<String>(
            UploadFileHelper.uploadFile(BASE_PATH, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
    }

    @ResponseBody
    @RequestMapping("/upload/displayFile")
    public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {

        System.out.println(fileName);
        InputStream input = null;

        ResponseEntity<byte[]> entity = null;
        try {

            String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
            MediaType mType = UploadFileHelper.getMediaType(formatName);

            HttpHeaders headers = new HttpHeaders();

            input = new FileInputStream(BASE_PATH + fileName);

            if (mType != null) {
                String fileLink = fileName.substring(14);
                headers.setContentType(mType);
                headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
                headers.add("Content-Disposition",
                    "attachment; filename='" + fileLink.substring(fileLink.indexOf("_") + 1) + "'");
            } else {
                fileName = fileName.substring(fileName.indexOf("_") + 1);
                headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
                headers.add("Content-Disposition",
                    "attachment; filename=\"" + new String(fileName.getBytes("utf-8"), "iso-8859-1") + "\"");
            }

            entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(input), headers, HttpStatus.OK); // 바이트배열, 헤더, HTTP상태코드
        } finally {
            input.close();
        }

        return entity;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteFile", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public void deleteFile(String fileName) {
        System.out.println(fileName);
        /* String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
        
        MediaType mediaType = UploadFileHelper.getMediaType(formatName);
        
        if (mediaType != null) {
            String front = fileName.substring(0, 12);
            String end = fileName.substring(14);
            System.out.println(fileName);
            System.out.println(front);
            System.out.println(end);
        
            // new File(BASE_PATH + (front + end).replace('/', File.separatorChar)).delete();
        }
        
        //new File(BASE_PATH + fileName.replace('/', File.separatorChar)).delete();
        
        return new ResponseEntity<String>("delet", HttpStatus.OK);*/
    }

}
