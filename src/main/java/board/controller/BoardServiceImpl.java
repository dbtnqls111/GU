package board.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.bean.BoardDTO;
import board.dao.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO boardDAO;

	@Override
	public BoardDTO getBoard(int seq) {
		return boardDAO.getBoard(seq);
	}

	@Override
	public ArrayList<BoardDTO> getBoardList(int startNum, int endNum) {
		return (ArrayList<BoardDTO>) boardDAO.getBoardList(startNum, endNum);
	}

	@Override
	public ArrayList<BoardDTO> getSearchedBoardList(String keyword, int startNum, int endNum) {
		return (ArrayList<BoardDTO>) boardDAO.getSearchedBoardList(keyword, startNum, endNum);
	}

	@Override
	public int getTotal() {
		return boardDAO.getTotal();
	}

	@Override
	public int getSearchedTotal(String keyword) {
		return boardDAO.getSearchedTotal(keyword);
	}

	@Override
	public void updatHit(int seq) {
		boardDAO.updateHit(seq);
	}

	@Override
	public int insertBoard(BoardDTO boardDTO) {
		return boardDAO.insertBoard(boardDTO);
	}

	@Override
	public int updateBoard(BoardDTO boardDTO) {
		return boardDAO.updateBoard(boardDTO);
	}

	@Override
	public int deleteBoard(int seq) {
		return boardDAO.deleteBoard(seq);
	}

}
