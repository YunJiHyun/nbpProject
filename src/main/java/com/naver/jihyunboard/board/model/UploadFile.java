package com.naver.jihyunboard.board.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 파일 업로드 객체
 * @author NAVER
 *
 */
@Alias("uploadFile")
@Data
public class UploadFile {
	private String fileName;
	private long fileSize;
	private int boardNum;
}
