package com.naver.jihyunboard.board.model;

import lombok.Data;

@Data
public class BoardPageHelper extends SearchPageHelper {
	private int pageScale = 10; // 10개씩 게시물
	public static final int BLOCK_SCALE = 5; // 페이징 번호 5개씩
	private int currentPage; // 현재 페이지
	private int prevPage;
	private int nextPage;
	private int totalPage; // 전체 게시물 갯수
	private int totalBlock; // 전체 ㄹ이지 블록 갯수
	private int curBlock;
	private int prevBlock;
	private int nextBlock;
	private int pageBegin;
	private int pageEnd;
	private int blockBegin; // 현재 페이지 블록의 시작번호
	private int blockEnd;
	private int startRow;
	private int boardNum;

	public BoardPageHelper(int count, int currentPage, int pageScale) {
		curBlock = 1;
		this.currentPage = currentPage;
		this.pageScale = pageScale;
		setTotalPage(count);
		setStartRow(currentPage);
		setPageRange();
		setTotalBlock();
		setBlockRange();
	}

	public void setStartRow(int currentPage) {
		this.startRow = (currentPage - 1) * pageScale;
	}

	public void setBlockRange() {
		//현재 페이지 몇 번째 블록?
		curBlock = (int)Math.ceil((currentPage - 1) / BLOCK_SCALE) + 1;
		blockBegin = (curBlock - 1) * BLOCK_SCALE + 1;
		blockEnd = blockBegin + BLOCK_SCALE - 1;

		if (blockEnd > totalPage) {
			blockEnd = totalPage;
		}

		prevPage = (currentPage == 1) ? 1 : (curBlock - 1) * BLOCK_SCALE;
		nextPage = curBlock > totalBlock ? (curBlock * BLOCK_SCALE) : (curBlock * BLOCK_SCALE) + 1;

		if (nextPage >= totalPage) {
			nextPage = totalPage;
		}
	}

	public void setPageRange() {
		pageBegin = (currentPage - 1) * pageScale + 1;
		pageEnd = pageBegin + pageScale - 1;
	}

	public void setTotalPage(int count) {
		totalPage = (int)Math.ceil(count * 1.0 / pageScale); //올림 후 int형으로 형변환
	}

	public void setTotalBlock() {
		totalBlock = (int)Math.ceil(totalPage / BLOCK_SCALE);
	}

}
