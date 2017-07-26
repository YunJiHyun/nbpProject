package com.naver.jihyunboard.user.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.user.model.BoardUser;
import com.naver.jihyunboard.user.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	UserRepository userDao;

	public void registerUser(BoardUser dto) {
		userDao.registerUser(dto);

	}

	public void loginCheck(BoardUser dto, HttpSession session) {

		// 로그인 성공 시 세션에 등록
		BoardUser userDto = userInfo(dto);
		session.setAttribute("userId", userDto.getUserId());

	}

	public BoardUser userInfo(BoardUser dto) {
		return userDao.userInfo(dto);
	}

	public BoardUser checkId(int userId) {
		return userDao.ckeckId(userId);

	}
}
