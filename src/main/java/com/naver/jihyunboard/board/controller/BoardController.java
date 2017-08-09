package com.naver.jihyunboard.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.naver.jihyunboard.board.model.Board;
import com.naver.jihyunboard.board.model.BoardPageHelper;
import com.naver.jihyunboard.board.model.SearchPageHelper;
import com.naver.jihyunboard.board.model.UploadFile;
import com.naver.jihyunboard.board.service.BoardService;
import com.naver.jihyunboard.reply.service.ReplyService;

@Controller
@RequestMapping("/board/")
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	ReplyService replyService;

	/**
	 * 검색기능과 페이징 기능을 포함한 게시글 가져오기
	 * @param currentPage
	 * @param searchPageHelper
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String getBoardList(@RequestParam(defaultValue = "1") int currentPage,
		SearchPageHelper searchPageHelper, Model model)
		throws Exception {

		int count = boardService.listCount(searchPageHelper); //갯수

		BoardPageHelper boardPageHelper = new BoardPageHelper(count, currentPage, 10);
		boardPageHelper.setSearchOption(searchPageHelper.getSearchOption());
		boardPageHelper.setKeyword(searchPageHelper.getKeyword());

		model.addAttribute("boardPageHelper", boardPageHelper);
		model.addAttribute("boardList", boardService.listAll(boardPageHelper));
		model.addAttribute("count", count);

		System.out.println("wjlkjdfkljwkljkl" + boardService.listAll(boardPageHelper));
		return "/board/list";
	}

	/**
	 * 새 글 작성하기 페이지로 이동
	 * @return
	 */
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String goBoardWritePage() {
		return "/board/write";
	}

	/**
	 * 작성완료 시 board 테이블에 게시글 INSERT
	 * @param dto
	 * @param auth
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insertBoardData(@ModelAttribute Board dto, Authentication auth) throws Exception {
		boardService.insertBoard(dto, auth);
		return "redirect:list";
	}

	//글 읽기 (게시글 상세보기)
	@RequestMapping(value = "/view")
	public String viewBoardDetail(@RequestParam("boardNum") int boardNum,
		@RequestParam(defaultValue = "1") int currentPage, SearchPageHelper searchPageHelper,
		Model model, Authentication auth, HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		model.addAttribute("BoardDTO", boardService.viewBoard(boardNum, request, response));
		model.addAttribute("userId", boardService.authUserId(auth));
		model.addAttribute("searchPageHelper", searchPageHelper);

		model.addAttribute("currentPage", currentPage);
		model.addAttribute("replyCount", replyService.listCount(boardNum));
		return "/board/board_view";
	}

	//글 수정하기 페이지
	@RequestMapping(value = "/modify")
	public String goBoardModifyPage(@RequestParam("boardNum") int boardNum, Model model, HttpServletRequest request,
		HttpServletResponse response, Authentication auth,
		@RequestParam("currentPage") int currentPage, SearchPageHelper searchPageHelper) throws Exception {

		if (!boardService.authUserId(auth).equals(boardService.writerId(boardNum))) {
			return "/error/authError";
		}

		model.addAttribute("list", boardService.getFileList(boardNum));
		model.addAttribute("BoardDTO", boardService.viewBoard(boardNum, request, response));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchPageHelper", searchPageHelper);

		return "/board/modify";
	}

	//수정완료 시 해당 board테이블의 게시글 UPDATE
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateBoardData(@ModelAttribute Board dto, @RequestParam("currentPage") int currentPage,
		SearchPageHelper searchPageHelper) throws Exception {
		boardService.updateBoard(dto);

		return "redirect:view?boardNum=" + dto.getBoardNum()
			+ "&currentPage=" + currentPage
			+ "&searchOption=" + searchPageHelper.getSearchOption()
			+ "&keyword=" + searchPageHelper.getKeyword();
	}

	//삭제하기 해당 board테이블의 게시글 DELETE
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String deleteBoardData(@RequestParam("boardNum") int boardNum, Authentication auth) throws Exception {
		if (!boardService.authUserId(auth).equals(boardService.writerId(boardNum))) {
			return "/error/authError";
		}
		String result = boardService.deleteBoard(boardNum);
		if (result.equals("ok")) {
			return "redirect:list";
		} else {
			return "/error/deleteError";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/getFileList/{boardNum}")
	public List<UploadFile> getFileList(@PathVariable("boardNum") int boardNum) {
		return boardService.getFileList(boardNum);
	}

	@RequestMapping(value = "/myList", method = RequestMethod.GET)
	public String getMyBoardList(@RequestParam(defaultValue = "1") int currentPage, Authentication auth,
		SearchPageHelper searchPageHelper, Model model)
		throws Exception {
		searchPageHelper.setSearchUserId(Integer.parseInt(boardService.authUserId(auth)));

		int count = boardService.listCount(searchPageHelper); //갯수

		BoardPageHelper boardPageHelper = new BoardPageHelper(count, currentPage, 10);
		boardPageHelper.setSearchOption(searchPageHelper.getSearchOption());
		boardPageHelper.setKeyword(searchPageHelper.getKeyword());
		boardPageHelper.setSearchUserId(searchPageHelper.getSearchUserId());
		boardPageHelper.setDateKeyword(searchPageHelper.getDateKeyword());

		model.addAttribute("boardPageHelper", boardPageHelper);
		model.addAttribute("boardList", boardService.listAll(boardPageHelper));
		model.addAttribute("count", count);

		return "/board/myList";
	}

}
