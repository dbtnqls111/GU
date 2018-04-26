package board.controller;

import java.util.ArrayList;

import board.bean.BoardDTO;

public interface BoardService {

	public BoardDTO getBoard(int seq);

	public ArrayList<BoardDTO> getBoardList(int startNum, int endNum);
	
	public ArrayList<BoardDTO> getSearchedBoardList(String keyword, int startNum, int endNum);

	public int getTotal();
	
	public int getSearchedTotal(String keyword);

	public void updatHit(int seq);

	public int insertBoard(BoardDTO boardDTO);

	public int updateBoard(BoardDTO boardDTO);

	public int deleteBoard(int seq);

}
