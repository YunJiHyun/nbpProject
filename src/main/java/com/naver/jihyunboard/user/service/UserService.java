package com.naver.jihyunboard.user.service;

import javax.servlet.http.HttpSession;

import com.naver.jihyunboard.user.dto.UserDTO;

public interface UserService {
    public void registerUser(UserDTO dto);

    public void loginCheck(UserDTO dto, HttpSession session);

    public UserDTO userInfo(UserDTO dto);

    public UserDTO checkId(int userId);
}
