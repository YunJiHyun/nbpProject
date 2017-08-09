package com.naver.jihyunboard.bookmark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

	@RequestMapping(value = "/mainList", method = RequestMethod.GET)
	public String goBookmarkMainPage(@RequestParam(defaultValue = "1") int currentPage, Bookmark bookmark,
		Authentication auth, Model model) throws Exception {
		bookmark.setMarkUserId(Integer.parseInt(boardService.authUserId(auth)));
		System.out.println(bookmark.getMarkUserId());
		model.addAttribute("bookmarkList", bookmarkService.bookmarkListAll(bookmark));
		model.addAttribute("count", bookmarkService.bookmarkListCount(bookmark));
		System.out.println(bookmarkService.bookmarkListAll(bookmark));
		return "bookmark/bookmarkMain";
	}

	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public void insertBookmarkData(Bookmark bookmark, Authentication auth) throws Exception {
		bookmark.setMarkUserId(Integer.parseInt(boardService.authUserId(auth)));
		bookmarkService.insertBookmark(bookmark);
	}

	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void deleteBookmarkData(Bookmark bookmark, Authentication auth) throws Exception {
		bookmark.setMarkUserId(Integer.parseInt(boardService.authUserId(auth)));
		bookmarkService.deleteBookmark(bookmark);
	}
}
