package com.naver.jihyunboard.bookmark.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.board.model.Board;
import com.naver.jihyunboard.board.model.BoardPageHelper;
import com.naver.jihyunboard.board.repository.BoardRepository;
import com.naver.jihyunboard.bookmark.model.Bookmark;
import com.naver.jihyunboard.bookmark.repository.BookmarkRepository;

@Service
public class BookmarkService {

	@Autowired
	BookmarkRepository bookmarkRepository;

	@Autowired
	BoardRepository boardRepository;

	public void insertBookmark(Bookmark bookmark) {
		bookmarkRepository.insertBookmark(bookmark);
	}

	public List<Board> bookmarkListAll(BoardPageHelper boardPageHelper) {
		return boardRepository.bookmarkListAll(boardPageHelper);
	}

	public int bookmarkListCount(Bookmark bookmark) {
		return bookmarkRepository.bookmarkListCount(bookmark);
	}

	public void deleteBookmark(Bookmark bookmark) {
		bookmarkRepository.deleteBookmark(bookmark);
	}

}
