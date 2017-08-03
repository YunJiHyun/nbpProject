package com.naver.jihyunboard.board.model;

import lombok.Data;

@Data
public class SearchPageHelper {
	private String searchOption = "all";
	private String keyword = "";
	private String dateKeyword = "1";
	private int searchUserId;
}
