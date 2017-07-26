package com.naver.jihyunboard.board.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.board.model.Board;

@Repository
public interface BoardRepository {
	public List<Board> listAll(Map<String, Object> map) throws Exception;

	public void insertBoard(Board dto) throws Exception;

	public Board viewBoard(int boardNum) throws Exception;

	public void updateBoard(Board dto) throws Exception;

	public void deleteBoard(int boardNum) throws Exception;

	public int listCount(Map<String, String> map) throws Exception;

	public void increaseReadCount(int boardNum) throws Exception;

	public void addAttach(String fileName);

	public List<String> getFileList(int boardNum);
}
