package com.naver.jihyunboard.board.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.board.model.Board;
import com.naver.jihyunboard.board.model.BoardPageHelper;
import com.naver.jihyunboard.board.model.SearchPageHelper;
import com.naver.jihyunboard.board.model.UploadFile;

@Repository
public interface BoardRepository {

	public List<Board> listAll(BoardPageHelper boardPageHelper) throws Exception;

	public void insertBoard(Board dto) throws Exception;

	public Board viewBoard(int boardNum) throws Exception;

	public void updateBoard(Board dto) throws Exception;

	public void updateFile(UploadFile fileList) throws Exception;

	public void deleteBoard(int boardNum) throws Exception;

	public int listCount(SearchPageHelper searchPageHelper) throws Exception;

	public void increaseReadCount(int boardNum) throws Exception;

	public void insertFile(UploadFile fileList);

	public List<UploadFile> getFileList(int boardNum);

	public void deleteFile(int boardNum);

	public void updateFileDeleteColumn(String fileName);

	public int getReplyCount(int boardNum);

}
