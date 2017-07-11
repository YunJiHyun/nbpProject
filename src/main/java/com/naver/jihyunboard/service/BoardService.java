package com.naver.jihyunboard.service;

import java.util.ArrayList;

import com.naver.jihyunboard.dto.BoardDTO;

public interface BoardService {
	//게시글 전체 목록
	public ArrayList<BoardDTO> listAll() throws Exception;
}
