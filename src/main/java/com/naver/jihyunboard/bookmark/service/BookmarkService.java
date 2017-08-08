package com.naver.jihyunboard.bookmark.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.bookmark.model.Bookmark;
import com.naver.jihyunboard.bookmark.repository.BookmarkRepository;

@Service
public class BookmarkService {

	@Autowired
	BookmarkRepository bookmarkRepository;

	public void insertBookmark(Bookmark bookmark) {
		bookmarkRepository.insertBookmark(bookmark);
	}

}
