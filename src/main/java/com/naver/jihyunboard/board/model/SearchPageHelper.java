package com.naver.jihyunboard.board.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.naver.jihyunboard.bookmark.model.Bookmark;

@Getter
@Setter
@ToString
public class SearchPageHelper extends Bookmark {
	private String searchOption = "all";
	private String keyword = "";
	private String category = "";
	private String dateKeyword = "1";
	private int searchUserId;
	private int loginUserId;
}
