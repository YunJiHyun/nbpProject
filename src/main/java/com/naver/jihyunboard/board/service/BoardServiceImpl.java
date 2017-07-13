package com.naver.jihyunboard.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.board.dao.BoardDAO;
import com.naver.jihyunboard.board.dto.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
    BoardDAO boardDao;

	@Override
	public List<BoardDTO> listAll() throws Exception {
		  return boardDao.listAll();
	
	}

	@Override
	public void insertBoard(BoardDTO dto) throws Exception {
		boardDao.insertBoard(dto);
		
	}

	@Override
	public BoardDTO viewBoard(int boardNum) throws Exception{
		return boardDao.viewBoard(boardNum);
		
	}

}
