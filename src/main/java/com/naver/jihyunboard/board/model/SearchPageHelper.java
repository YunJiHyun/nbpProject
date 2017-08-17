package com.naver.jihyunboard.board.model;

import lombok.Data;

import com.naver.jihyunboard.bookmark.model.Bookmark;

@Data
public class SearchPageHelper extends Bookmark {
	private String searchOption = "all";
	private String keyword = "";
	private String category = "";
	private String dateKeyword = "1";
	private int searchUserId;
	private int loginUserId;
}
