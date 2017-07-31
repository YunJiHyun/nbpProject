package com.naver.jihyunboard.user.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("userDto")
@Data
public class BoardUser {

	private int userId;
	private String userPw;
	private String userName;
	private String userMajor;
	private String userPhoneNum;
	private String userRole;
	//private List<Board> boardList;
}
