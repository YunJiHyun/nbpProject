package com.naver.jihyunboard.kanban.model;

import java.sql.Date;
import java.sql.Timestamp;

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
	private int kanbanNum;
	private int kanbanUserId;
	private int kanbanBoardNum;
	private String kanbanContent;
	private int kanbanImportance;
	private String kanbanState;
	private Date kanbanDeadline;
	private Timestamp kanbanModifyTime;
	private int kanbanOrder;
}
