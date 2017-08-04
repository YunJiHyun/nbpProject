package com.naver.jihyunboard.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.user.model.BoardUser;
import com.naver.jihyunboard.user.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	UserRepository userRepository;

	public void registerUser(BoardUser dto) {
		userRepository.insertUser(dto);
	}

	public BoardUser userInfo(BoardUser dto) {
		return userRepository.userInfo(dto);
	}

	public BoardUser checkId(int userId) {
		return userRepository.checkId(userId);

	}

	public BoardUser userInformation(int userId) {
		return userRepository.userInformation(userId);
	}
}
