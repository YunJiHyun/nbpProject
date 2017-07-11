package com.naver.jihyunboard.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.naver.jihyunboard.dao.BoardDAO;
import com.naver.jihyunboard.dto.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Inject
    BoardDAO boardDao;

	@Override
	public List<BoardDTO> listAll() throws Exception {
		  return boardDao.listAll();
	
	}

}
