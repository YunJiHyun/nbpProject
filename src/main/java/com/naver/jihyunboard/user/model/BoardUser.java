package com.naver.jihyunboard.user.model;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

import com.naver.jihyunboard.board.model.Board;

@Alias("userDto")
@Data
public class BoardUser {

	private int userId;
	private String userPw;
	private String userName;
	private String userMajor;
	private String userPhoneNum;
	private String userRole;
	private List<Board> boardList;
}
