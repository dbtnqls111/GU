package board.controller;

import java.util.ArrayList;

import board.bean.BoardDTO;

public interface BoardService {
	public int insertBoard(BoardDTO boardDTO);
	public BoardDTO getBoard(int seq);
	public ArrayList<BoardDTO> getBoardList(int startNum, int endNum);
	public int deleteBoard(int seq);
	public int updateBoard(int seq);
	public int getTotal();
	public void updatHit(int seq);
}
