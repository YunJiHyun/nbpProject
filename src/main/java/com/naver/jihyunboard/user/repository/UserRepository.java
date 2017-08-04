package com.naver.jihyunboard.user.repository;

import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.user.model.BoardUser;

@Repository
public interface UserRepository {

	public void insertUser(BoardUser dto);

	//public BoardUser userInfo(BoardUser dto);

	public BoardUser checkId(int userId);

	public BoardUser userInformation(int userId);
}
