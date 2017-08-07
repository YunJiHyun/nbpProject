package com.naver.jihyunboard.kanban.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 칸반코드 정보 객체
 * @author NAVER
 *
 */
@Alias("Kanban")
@Data
public class Kanban {
	private int kanbanUserId;
	private int kanbanBoardNum;
	private String kanbanContent;
	private int kanbanImportance;
	private int kanbanState;
	private Date kanbanDeadline;
}
