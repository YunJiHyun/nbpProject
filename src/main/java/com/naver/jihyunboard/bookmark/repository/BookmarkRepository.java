package com.naver.jihyunboard.bookmark.repository;

import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.bookmark.model.Bookmark;

@Repository
public interface BookmarkRepository {

	public void insertBookmark(Bookmark bookmark);

}
