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
	
	public List<BoardDTO> getBoardList(int startNum, int endNum){
		Map<String, Integer> map = new HashMap<>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		return sqlSession.selectList("mybatis.boardMapper.getBoardList", map);
	}
	
	public int getTotal() {
		return sqlSession.selectOne("mybatis.boardMapper.getTotal");
	}
	
	public void updateHit(int seq) {
		sqlSession.update("mybatis.boardMapper.updateHit", seq);
	}
}
