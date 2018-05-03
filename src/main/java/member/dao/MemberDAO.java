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
			return true;
		} else {
			return false;
		}
	}
	
	public boolean isExistEmail(String email) {
		if (sqlSession.selectOne("mybatis.memberMapper.isExistEmail", email) == null) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean certifiMemCheck(String name, String phone) {
		Map<String, String> map = new HashMap<>();
		map.put("name", name);
		map.put("phone", phone);
		
		if(sqlSession.selectOne("mybatis.memberMapper.certifiMemCheck", map) == null) {
			return false;
		}else {
			return true;
		}
	}
	
	public String findId_phone(String name, String phone) {
		Map<String, String> map  = new HashMap<>();
		map.put("name", name);
		map.put("phone", phone);
		
		String id = sqlSession.selectOne("mybatis.memberMapper.findId_phone", map);
		
		if (id == null) {
			return null;
		} else {
			return id;
		}
	}
	
	public String findId_email(String name, String email) {
		Map<String, String> map  = new HashMap<>();
		map.put("name", name);
		map.put("email", email);
		
		String id = sqlSession.selectOne("mybatis.memberMapper.findId_email", map);
		if (id == null) {
			return null;
		} else {
			return id;
		}
	}
	
	public String findPw_email(String name, String email) {
		Map<String, String> map  = new HashMap<>();
		map.put("name", name);
		map.put("email", email);
		
		String pw = sqlSession.selectOne("mybatis.memberMapper.findPw_email", map);
		if (pw == null) {
			return null;
		} else {
			return pw;
		}
	}
	
	public int updateBranch(MemberDTO memberDTO) {
		return sqlSession.update("mybatis.memberMapper.updateBranch", memberDTO);
	}
}
