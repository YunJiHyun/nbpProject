package com.naver.jihyunboard.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.jihyunboard.board.model.Board;
import com.naver.jihyunboard.board.model.BoardPageHelper;
import com.naver.jihyunboard.board.repository.BoardRepository;

@Service
public class BoardService {

	@Autowired
	BoardRepository boardDao;

	public Map<String, Object> listAll(String searchOption, String keyword, int currentPage) throws Exception {

		Map<String, String> countParam = new HashMap<String, String>();
		countParam.put("searchOption", searchOption);
		countParam.put("keyword", keyword);
		int count = boardDao.listCount(countParam); //검색 결과에 따른 게시글의 갯수

		BoardPageHelper boardPageHelper = new BoardPageHelper(count, currentPage);
		int startRow = (currentPage - 1) * BoardPageHelper.PAGE_SCALE;

		Map<String, Object> listParam = new HashMap<String, Object>();
		listParam.put("startRow", startRow);
		listParam.put("pageScale", BoardPageHelper.PAGE_SCALE);
		listParam.put("searchOption", searchOption);
		listParam.put("keyword", keyword);

		List<Board> boardList = boardDao.listAll(listParam);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardList", boardList);
		map.put("count", count);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("boardPageHelper", boardPageHelper);
		return map;

	}

	@Transactional
	public void insertBoard(Board dto) throws Exception {
		boardDao.insertBoard(dto); //호출한 후 파일 이름을 추가

		String[] files = dto.getFiles();
		if (files == null) {
			return;
		}
		for (String fileName : files) {
			boardDao.addAttach(fileName);
		}
	}

	public Board viewBoard(int boardNum) throws Exception {
		boardDao.increaseReadCount(boardNum);
		return boardDao.viewBoard(boardNum);

	}

	public void updateBoard(Board dto) throws Exception {
		boardDao.updateBoard(dto);

	}

	@Transactional
	public void deleteBoard(int boardNum) throws Exception {
		boardDao.deleteFile(boardNum);
		boardDao.deleteBoard(boardNum);
	}

	public List<String> getFileList(int bno) {
		return boardDao.getFileList(bno);
	}

}
