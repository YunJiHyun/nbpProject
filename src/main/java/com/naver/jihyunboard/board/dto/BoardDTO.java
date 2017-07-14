package com.naver.jihyunboard.board.dto;

import java.sql.Timestamp;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class BoardDTO {
	@Setter @Getter private int boardNum;
	@Setter @Getter private int boardUserId;
	@Setter @Getter private String boardTitle;
	@Setter @Getter private String boardContent;
	@Setter @Getter private String boardCategory;
	@Setter @Getter private Timestamp boardDate;
	@Setter @Getter private int boardReadCount;	
}
