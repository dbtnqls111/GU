package board.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.bean.BoardDTO;
import board.dao.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardDAO boardDAO;

	@Override
	public int insertBoard(BoardDTO boardDTO) {
		return 0;
	}

	@Override
	public BoardDTO getBoard(int seq) {
		return boardDAO.getBoard(seq);
	}

	@Override
	public ArrayList<BoardDTO> getBoardList(int startNum, int endNum) {
		return (ArrayList<BoardDTO>)boardDAO.getBoardList(startNum, endNum);
	}

	@Override
	public int deleteBoard(int seq) {
		return 0;
	}

	@Override
	public int updateBoard(int seq) {
		return 0;
	}

	@Override
	public int getTotal() {
		return boardDAO.getTotal();
	}
}
