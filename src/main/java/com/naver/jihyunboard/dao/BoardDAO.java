package com.naver.jihyunboard.dao;

import java.util.List;

import com.naver.jihyunboard.dto.BoardDTO;

public interface BoardDAO {
	public List<BoardDTO> listAll() throws Exception;
}
