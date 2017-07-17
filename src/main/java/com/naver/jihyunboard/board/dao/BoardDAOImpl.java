package com.naver.jihyunboard.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.board.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	SqlSession SqlSession;
	
	private static String namespace = "com.naver.jihyunboard.board.dao.BoardDAO";
	
	@Override
	public List<BoardDTO> listAll() throws Exception {
		return SqlSession.selectList(namespace+".listAll");
		
	}

	@Override
	//public int insertBoard(BoardDTO dto) throws Exception {
	public void insertBoard(BoardDTO dto) throws Exception {
		 SqlSession.insert(namespace + ".insert", dto);
		
	}

	@Override
	public BoardDTO viewBoard(int boardNum) throws Exception {
		return SqlSession.selectOne(namespace + ".viewBoard", boardNum);
	}

	@Override
	public void updateBoard(BoardDTO dto) throws Exception {
		SqlSession.update(namespace + ".updateBoard", dto);
		
	}
	
	@Override
	public void deleteBoard(int boardNum) throws Exception {
		SqlSession.delete(namespace + ".deleteBoard", boardNum);
		
	}

}
