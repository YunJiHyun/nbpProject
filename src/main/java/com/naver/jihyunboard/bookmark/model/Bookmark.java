package com.naver.jihyunboard.bookmark.model;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("bookmark")
@Data
public class Bookmark {
	private int markNum;
	private int markBoardNum;
	private char bookMark;
	private int markUserId;
	private Timestamp markDate;
}
