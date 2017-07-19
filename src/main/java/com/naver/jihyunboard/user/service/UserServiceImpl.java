package com.naver.jihyunboard.user.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.user.dao.UserDAO;
import com.naver.jihyunboard.user.dto.UserDTO;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDAO userDao;

    @Override
    public void registerUser(UserDTO dto) {
        userDao.registerUser(dto);

    }

    @Override
    public void loginCheck(UserDTO dto, HttpSession session) {

        // 로그인 성공 시 세션에 등록
        UserDTO userDto = userInfo(dto);
        session.setAttribute("userId", userDto.getUserId());

    }

    @Override
    public UserDTO userInfo(UserDTO dto) {
        return userDao.userInfo(dto);
    }

    @Override
    public UserDTO checkId(int userId) {
        return userDao.ckeckId(userId);

    }
}
