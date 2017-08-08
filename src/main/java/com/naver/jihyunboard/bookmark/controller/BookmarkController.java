package com.naver.jihyunboard.bookmark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.naver.jihyunboard.board.service.BoardService;
import com.naver.jihyunboard.bookmark.model.Bookmark;
import com.naver.jihyunboard.bookmark.service.BookmarkService;

@Controller
@RequestMapping("/bookmark/")
public class BookmarkController {

	@Autowired
	BookmarkService bookmarkService;

	@Autowired
	BoardService boardService;

	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public void insertBookmarkData(Bookmark bookmark, Authentication auth) throws Exception {
		bookmark.setMarkUserId(Integer.parseInt(boardService.authUserId(auth)));
		bookmarkService.insertBookmark(bookmark);
	}

}
