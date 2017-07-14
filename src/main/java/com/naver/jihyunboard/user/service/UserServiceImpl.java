package com.naver.jihyunboard.user.service;

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

}
