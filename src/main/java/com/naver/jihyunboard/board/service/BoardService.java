package com.naver.jihyunboard.board.service;

import java.util.Map;

import com.naver.jihyunboard.board.dto.BoardDTO;

public interface BoardService {
    //게시글 전체 목록
    public Map<String, Object> listAll(int currentPage) throws Exception;

    public void insertBoard(BoardDTO dto) throws Exception;

    public BoardDTO viewBoard(int boardNum) throws Exception;

    public void updateBoard(BoardDTO dto) throws Exception;

    public void deleteBoard(int boardNum) throws Exception;

    public int boardListCount() throws Exception;

}
