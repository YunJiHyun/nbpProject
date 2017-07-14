package com.naver.jihyunboard.user.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.user.dto.UserDTO;
import com.naver.jihyunboard.user.service.UserService;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	SqlSession SqlSession;
	
	private static String namespace = "com.naver.jihyunboard.user.dao.UserDAO";
	
	@Override
	public void registerUser(UserDTO dto) {
		SqlSession.insert(namespace+".insert", dto);
	}

}
