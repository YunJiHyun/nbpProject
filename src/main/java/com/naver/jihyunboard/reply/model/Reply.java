package com.naver.jihyunboard.reply.model;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 댓글 정보 객체
 * @author NAVER
 *
 */
@Alias("reply")
@Data
public class Reply {
	private int replyNum;
	private int boardNum;
	private String replyContent;
	private String replyer; //댓글 작성자
	private String replyUserName; //댓글 작성자 이름
	private Timestamp replyDate; // 댓글 작성일자
}
