package com.naver.jihyunboard.dao;

import java.util.ArrayList;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject
	SqlSession SqlSession;
	
	
	private static String namespace = "com.naver.jihyunboard.dao.BoardDAO";

	
	@Override
	public ArrayList<BoardDTO> listAll() throws Exception {
		SqlSession.selectList(namespace+".listAll");
		return null;
	}

}
