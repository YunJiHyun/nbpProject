package com.naver.jihyunboard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	SqlSession SqlSession;
	
	private static String namespace = "com.naver.jihyunboard.dao.BoardDAO";
	
	@Override
	public List<BoardDTO> listAll() throws Exception {
		return SqlSession.selectList(namespace+".listAll");
		
	}

}
