package com.naver.jihyunboard.kanban.model;

import lombok.Data;

@Data
public class SortKanban {
	private String sortState;
	int[] sortedList;
}
