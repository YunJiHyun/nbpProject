package com.naver.jihyunboard.user.dao;

import com.naver.jihyunboard.user.dto.UserDTO;


public interface UserDAO {
	public void registerUser(UserDTO dto);
	public boolean loginCheck(UserDTO dto);
	public UserDTO userInfo(UserDTO dto);
}
