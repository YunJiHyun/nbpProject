package com.naver.jihyunboard.user.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.user.model.BoardUser;

@Repository
public class UserRepository {

	@Autowired
	SqlSession sqlSession;

	private static String namespace = "com.naver.jihyunboard.user.repository.UserRepository";

	public void registerUser(BoardUser dto) {
		sqlSession.insert(namespace + ".insert", dto);
	}

	public boolean loginCheck(BoardUser dto) {
		String name = sqlSession.selectOne("loginCheck", dto);

		if (name == null) {
			return false;
		}
		return true;
	}

	public BoardUser userInfo(BoardUser dto) {
		return sqlSession.selectOne("userInfo", dto);
	}

	public BoardUser ckeckId(int userId) {
		return sqlSession.selectOne("checkId", userId);

	}

}
