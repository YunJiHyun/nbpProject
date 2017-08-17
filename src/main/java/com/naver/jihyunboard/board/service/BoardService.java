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

import com.nhncorp.lucy.security.xss.XssFilter;

import com.naver.jihyunboard.board.model.Board;
import com.naver.jihyunboard.board.model.BoardPageHelper;
import com.naver.jihyunboard.board.model.SearchPageHelper;
import com.naver.jihyunboard.board.model.UploadFile;
import com.naver.jihyunboard.board.repository.BoardRepository;
import com.naver.jihyunboard.bookmark.model.Bookmark;
import com.naver.jihyunboard.bookmark.repository.BookmarkRepository;
import com.naver.jihyunboard.kanban.repository.KanbanRepository;

@Service
public class BoardService {

	@Autowired
	BoardRepository boardRepository;

	@Autowired
	BookmarkRepository bookmarkRepository;

	@Autowired
	KanbanRepository kanbanRepository;

	XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");

	public int listCount(SearchPageHelper searchPageHelper)
		throws Exception {
		int count = boardRepository.listCount(searchPageHelper); //검색 결과에 따른 게시글의 갯수
		return count;
	}

	public List<Board> listAll(BoardPageHelper boardPageHelper, Authentication auth)
		throws Exception {
		boardPageHelper.setLoginUserId(Integer.parseInt(authUserId(auth)));
		List<Board> boardList = boardRepository.listAll(boardPageHelper);

		return boardList;
	}

	@Transactional
	public void insertBoard(Board dto, Authentication auth) throws Exception {
		dto.setBoardUserId(Integer.parseInt(authUserId(auth)));
		/*String requestedString = dto.getBoardTitle();
		dto.setBoardTitle(filter.doFilter(requestedString));*/
		boardRepository.insertBoard(dto); //호출한 후 파일 이름을 추가

		String[] files = dto.getFiles();

		if (files == null) {
			return;
		} else {
			long[] fileSizes = dto.getFileSize();
			UploadFile fileList = new UploadFile();
			for (int i = 0; i < files.length; i++) {
				fileList.setFileName(files[i]);
				fileList.setFileSize(fileSizes[i]);
				boardRepository.insertFile(fileList);
			}
		}

	}

	public Board viewBoard(Board board, HttpServletRequest request, HttpServletResponse response, Authentication auth)
		throws Exception {

		deduplicationBoardView(board, request, response);

		board = boardRepository.viewBoard(board.getBoardNum());
		Bookmark bookmark = new Bookmark();
		bookmark.setMarkBoardNum(board.getBoardNum());
		bookmark.setMarkUserId(Integer.parseInt(authUserId(auth)));

		if (bookmarkRepository.getBookmarkForLoginUser(bookmark) != null) {
			board.setBoardBookmark("Y");
		}

		return board;
	}

	@Transactional
	public void updateBoard(Board dto) throws Exception {
		boardRepository.updateBoard(dto);

		String[] updateFiles = dto.getUpdateFiles();

		if (updateFiles == null) {
			return;
		} else {
			long[] updateFileSizes = dto.getUpdateFileSize();

			UploadFile fileList = new UploadFile();
			fileList.setBoardNum(dto.getBoardNum());
			for (int i = 0; i < updateFiles.length; i++) {
				fileList.setFileName(updateFiles[i]);
				fileList.setFileSize(updateFileSizes[i]);
				boardRepository.updateFile(fileList);
			}
		}
	}

	@Transactional
	public String deleteBoard(int boardNum) throws Exception {
		int replyCount = boardRepository.getReplyCount(boardNum);
		if (replyCount > 0) {
			return "no";
		} else {
			kanbanRepository.updateKanbanForDeleteBoard(boardNum);
			boardRepository.deleteFile(boardNum);
			Bookmark bookmark = new Bookmark();
			bookmark.setMarkBoardNum(boardNum);
			bookmarkRepository.deleteBookmark(bookmark);
			boardRepository.deleteBoard(boardNum);
			return "ok";
		}
	}

	public List<UploadFile> getFileList(int bno) {
		return boardRepository.getFileList(bno);
	}

	public String writerId(int boardNum) throws Exception {
		String writerId = Integer.toString(boardRepository.viewBoard(boardNum).getBoardUserId());
		return writerId;
	}

	public void updateFileDeleteColumn(String fileName) {
		boardRepository.updateFileDeleteColumn(fileName);

	}

	public List<Board> listMyBoard(BoardPageHelper boardPageHelper) throws Exception {
		List<Board> boardMyList = boardRepository.listAll(boardPageHelper);
		return boardMyList;
	}

	public void deduplicationBoardView(Board board, HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		Cookie[] cookies = request.getCookies();
		Map<String, Object> mapCookie = new HashMap<String, Object>();
		if (request.getCookies() != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie obj = cookies[i];
				mapCookie.put(obj.getName(), obj.getValue());
			}
		}
		String cookieReadCount = (String)mapCookie.get("read_count");
		String newCookieReadCount = "|" + board.getBoardNum();

		if (StringUtils.indexOfIgnoreCase(cookieReadCount, newCookieReadCount) == -1) {
			Cookie cookie = new Cookie("read_count", cookieReadCount + newCookieReadCount);
			cookie.setMaxAge(6 * 60 * 60); //6시간
			response.addCookie(cookie);
			boardRepository.increaseReadCount(board.getBoardNum());
		}
	}

	public String authUserId(Authentication auth) {
		auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		return userId;
	}

}