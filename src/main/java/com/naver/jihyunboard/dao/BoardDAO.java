package com.naver.jihyunboard.dao;

import java.util.ArrayList;

import com.naver.jihyunboard.dto.BoardDTO;

public interface BoardDAO {
	public ArrayList<BoardDTO> listAll() throws Exception;
}
