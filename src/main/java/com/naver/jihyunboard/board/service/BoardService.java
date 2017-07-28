package com.naver.jihyunboard.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.jdbc.StringUtils;

import com.naver.jihyunboard.board.model.Board;
import com.naver.jihyunboard.board.model.BoardPageHelper;
import com.naver.jihyunboard.board.repository.BoardRepository;

@Service
public class BoardService {

	@Autowired
	BoardRepository boardRepository;

	public Map<String, Object> listAll(String searchOption, String keyword, int currentPage) throws Exception {

		Map<String, String> countParam = new HashMap<String, String>();
		countParam.put("searchOption", searchOption);
		countParam.put("keyword", keyword);
		int count = boardRepository.listCount(countParam); //검색 결과에 따른 게시글의 갯수

		BoardPageHelper boardPageHelper = new BoardPageHelper(count, currentPage);
		int startRow = (currentPage - 1) * BoardPageHelper.PAGE_SCALE;

		Map<String, Object> listParam = new HashMap<String, Object>();
		listParam.put("startRow", startRow);
		listParam.put("pageScale", BoardPageHelper.PAGE_SCALE);
		listParam.put("searchOption", searchOption);
		listParam.put("keyword", keyword);

		List<Board> boardList = boardRepository.listAll(listParam);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardList", boardList);
		map.put("count", count);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("boardPageHelper", boardPageHelper);
		return map;

	}

	@Transactional
	public void insertBoard(Board dto, Authentication auth) throws Exception {
		auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		dto.setBoardUserId(Integer.parseInt(userId));
		boardRepository.insertBoard(dto); //호출한 후 파일 이름을 추가

		String[] files = dto.getFiles();
		if (files == null) {
			return;
		}
		for (String fileName : files) {
			boardRepository.addAttach(fileName);
		}
	}

	public Board viewBoard(int boardNum, HttpServletRequest request, HttpServletResponse response) throws Exception {

		Cookie[] cookies = request.getCookies();
		Map<String, Object> mapCookie = new HashMap<String, Object>();
		if (request.getCookies() != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie obj = cookies[i];
				mapCookie.put(obj.getName(), obj.getValue());
			}
		}
		String cookieReadCount = (String)mapCookie.get("read_count");
		String newCookieReadCount = "|" + boardNum;

		if (StringUtils.indexOfIgnoreCase(cookieReadCount, newCookieReadCount) == -1) {
			Cookie cookie = new Cookie("read_count", cookieReadCount + newCookieReadCount);
			cookie.setMaxAge(6 * 60 * 60); //6시간
			response.addCookie(cookie);
			boardRepository.increaseReadCount(boardNum);
		}
		return boardRepository.viewBoard(boardNum);
	}

	@Transactional
	public void updateBoard(Board dto) throws Exception {
		boardRepository.updateBoard(dto);

		String[] files = dto.getFiles();
		Map<String, Object> map = new HashMap<String, Object>();

		if (files == null) {
			return;
		}
		for (String fileName : files) {
			map.put("boardNum", dto.getBoardNum());
			map.put("fileName", fileName);
			System.out.println(dto.getBoardNum() + fileName);
			boardRepository.updateFile(map);
		}

	}

	@Transactional
	public void deleteBoard(int boardNum) throws Exception {
		boardRepository.deleteFile(boardNum);
		boardRepository.deleteBoard(boardNum);
	}

	public List<String> getFileList(int bno) {
		return boardRepository.getFileList(bno);
	}

}
