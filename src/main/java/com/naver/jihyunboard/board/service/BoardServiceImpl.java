package com.naver.jihyunboard.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jihyunboard.board.dao.BoardDAOImpl;
import com.naver.jihyunboard.board.dto.BoardDTO;

@Service
public class BoardServiceImpl {

    @Autowired
    BoardDAOImpl boardDao;

    public Map<String, Object> listAll(String searchOption, String keyword, int currentPage) throws Exception {

        int count = boardDao.listCount(searchOption, keyword); //검색 결과에 따른 게시글의 갯수

        BoardPageHelper boardPageHelper = new BoardPageHelper(count, currentPage);
        int startRow = (currentPage - 1) * BoardPageHelper.PAGE_SCALE;
        //int start = boardPageHelper.getPageBegin();
        //int end = boardPageHelper.getPageEnd();
        List<BoardDTO> boardList = boardDao.listAll(searchOption, keyword, startRow, BoardPageHelper.PAGE_SCALE); //rownum을 이용한 서브쿼리 대신 LIMIT 사용으로 수정

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("boardList", boardList);
        map.put("count", count);
        map.put("boardPageHelper", boardPageHelper);
        return map;

    }

    public void insertBoard(BoardDTO dto) throws Exception {
        boardDao.insertBoard(dto);
    }

    public BoardDTO viewBoard(int boardNum) throws Exception {
        return boardDao.viewBoard(boardNum);

    }

    public void updateBoard(BoardDTO dto) throws Exception {
        boardDao.updateBoard(dto);

    }

    public void deleteBoard(int boardNum) throws Exception {
        boardDao.deleteBoard(boardNum);
    }

    public void increaseReadCount(int boardNum) throws Exception {
        boardDao.increaseReadCount(boardNum);
    }

}
