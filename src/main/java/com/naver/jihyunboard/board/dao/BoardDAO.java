package com.naver.jihyunboard.board.dao;

import java.util.List;

import com.naver.jihyunboard.board.dto.BoardDTO;

public interface BoardDAO {
	public List<BoardDTO> listAll() throws Exception;
	public void insertBoard(BoardDTO dto) throws Exception;
	public BoardDTO viewBoard(int boardNum) throws Exception;
	public void updateBoard(BoardDTO dto) throws Exception;
	public void deleteBoard(int boardNum) throws Exception;
}
