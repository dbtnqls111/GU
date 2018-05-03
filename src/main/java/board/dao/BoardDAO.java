package board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import board.bean.BoardDTO;

@Repository
public class BoardDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public BoardDTO getBoard(int seq) {
		return sqlSession.selectOne("mybatis.boardMapper.getBoard", seq);
	}

	public List<BoardDTO> getBoardList(int startNum, int endNum) {
		Map<String, Integer> map = new HashMap<>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		return sqlSession.selectList("mybatis.boardMapper.getBoardList", map);
	}

	public List<BoardDTO> getSearchedBoardList(String keyword, int startNum, int endNum) {
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", (String) keyword);
		map.put("startNum", (Integer) startNum);
		map.put("endNum", (Integer) endNum);
		
		return sqlSession.selectList("mybatis.boardMapper.getSearchedBoardList", map);
	}

	public int getTotal() {
		return sqlSession.selectOne("mybatis.boardMapper.getTotal");
	}
	
	public int getSearchedTotal(String keyword) {
		return sqlSession.selectOne("mybatis.boardMapper.getSearchedTotal", keyword);
	}

	public void updateHit(int seq) {
		sqlSession.update("mybatis.boardMapper.updateHit", seq);
	}

	public int insertBoard(BoardDTO boardDTO) {
		return sqlSession.insert("mybatis.boardMapper.insertBoard", boardDTO);
	}

	public int updateBoard(BoardDTO boardDTO) {
		return sqlSession.insert("mybatis.boardMapper.updateBoard", boardDTO);
	}

	public int deleteBoard(int seq) {
		return sqlSession.insert("mybatis.boardMapper.deleteBoard", seq);
	}

}
