package com.naver.jihyunboard.board.model;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 게시글 정보 객체
 * @author NAVER
 *
 */
@Alias("boardDto")
@Data
public class Board extends FileInfo {
	private int boardNum;
	private int boardUserId;
	private String boardTitle;
	private String boardContent;
	private String boardCategory;
	private Timestamp boardDate;
	private int boardReadCount;
	private String userName;
	private int fileCount;
	private int replyCount;
	private String boardBookmark = "N";
}