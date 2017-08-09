package com.naver.jihyunboard.bookmark.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.board.model.Board;
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

	public List<Board> bookmarkListAll(Bookmark bookmark) {
		return boardRepository.bookmarkListAll(bookmark);
	}

	public int bookmarkListCount(Bookmark bookmark) {
		return bookmarkRepository.bookmarkListCount(bookmark);
	}

	public List<Integer> checkBookmark(int userId) {
		return bookmarkRepository.checkBookmark(userId);
	}

}
