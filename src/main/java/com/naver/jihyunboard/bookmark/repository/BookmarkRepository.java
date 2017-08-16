package com.naver.jihyunboard.bookmark.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.naver.jihyunboard.bookmark.model.Bookmark;

@Repository
public interface BookmarkRepository {

	public void insertBookmark(Bookmark bookmark);

	public int bookmarkListCount(Bookmark bookmark);

	public List<Integer> checkBookmark(int userId);

	public Bookmark isBookmark(Bookmark bookmark);

	public void deleteBookmark(Bookmark bookmark);

}
