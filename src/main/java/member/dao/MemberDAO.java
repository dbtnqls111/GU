package member.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import member.bean.MemberDTO;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertMember(MemberDTO memberDTO) {
		return sqlSession.insert("mybatis.memberMapper.insertMember", memberDTO);
	}

	public int updateMember(MemberDTO memberDTO) {
		return sqlSession.update("mybatis.memberMapper.updateMember", memberDTO);
	}

	public int deleteMember(String id) {
		return sqlSession.delete("mybatis.memberMapper.deleteMember", id);
	}

	public MemberDTO login(String id, String pw) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);

		return sqlSession.selectOne("mybatis.memberMapper.login", map);
	}

	public boolean isExistId(String id) {
		if (sqlSession.selectOne("mybatis.memberMapper.isExistId", id) == null) {
			return false;
		} else {
			return true;
		}
	}
}
