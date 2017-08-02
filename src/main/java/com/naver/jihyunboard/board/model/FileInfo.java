package com.naver.jihyunboard.board.model;

import lombok.Data;

@Data
public class FileInfo {
	private String[] files;
	private long[] fileSize;
	private String[] updateFiles;
	private long[] updateFileSize;
}
