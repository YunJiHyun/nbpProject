package com.naver.jihyunboard.board.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("boardDto")
@Data
public class BoardDTO {
    private int boardNum;
    private int boardUserId;
    private String boardTitle;
    private String boardContent;
    private String boardCategory;
    private Timestamp boardDate;
    private int boardReadCount;
    private String[] files;

}
