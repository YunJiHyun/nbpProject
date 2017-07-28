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

import com.naver.jihyunboard.board.model.UploadFileHelper;

/**
 *
 * @author NAVER
 *
 */
@Controller
@RequestMapping("/upload/*")
public class FileController {

	public static final String BASE_PATH = "D:/fileUpload";

	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadFile(MultipartFile file) throws Exception {

		return new ResponseEntity<String>(
			UploadFileHelper.uploadFile(BASE_PATH, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
	}

	/**
	 *
	 * @param fileName
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/upload/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {

		System.out.println(fileName);
		InputStream input = null;

		ResponseEntity<byte[]> entity = null;
		try {

			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			MediaType mediaType = UploadFileHelper.getMediaType(formatName);

			HttpHeaders headers = new HttpHeaders();

			input = new FileInputStream(BASE_PATH + fileName);

			if (mediaType != null) {
				String fileLink = fileName.substring(14);
				headers.setContentType(mediaType);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition",
					"attachment; filename='" + fileLink.substring(fileLink.indexOf("_") + 1) + "'");
			} else {
				fileName = fileName.substring(fileName.indexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition",
					"attachment; filename=\"" + new String(fileName.getBytes("utf-8"), "iso-8859-1") + "\"");
			}
			// 바이트배열, 헤더, HTTP상태코드
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(input), headers, HttpStatus.OK);
		} finally {
			input.close();
		}

		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public void deleteFile(String fileName) {
		System.out.println(fileName);
	}

}
