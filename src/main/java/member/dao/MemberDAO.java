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

	public int deleteMember(String id, String pw) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		return sqlSession.delete("mybatis.memberMapper.deleteMember", map);
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
	
	public String findPw_phone(String name, String phone) {
		Map<String, String> map  = new HashMap<>();
		map.put("name", name);
		map.put("phone", phone);
		
		String pw = sqlSession.selectOne("mybatis.memberMapper.findPw_phone", map);
		
		if (pw == null) {
			return null;
		} else {
			return pw;
		}
	}
	
	public int updateBranch(MemberDTO memberDTO) {
		return sqlSession.update("mybatis.memberMapper.updateBranch", memberDTO);
	}
	
	public int deleteBranch(String id) {
		return sqlSession.update("mybatis.memberMapper.deleteBranch", id);
	}
	
	public MemberDTO myInfo(String id) {
		return sqlSession.selectOne("mybatis.memberMapper.myInfo", id);
	}
	
	public int modifyPw(String id, String pw, String newPw1) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("pw", pw);
		map.put("newPw1", newPw1);
		return sqlSession.update("mybatis.memberMapper.modifyPw",map);
	}
	
	public int modifyPhone(String id, String phone) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("phone", phone);
		return sqlSession.update("mybatis.memberMapper.modifyPhone",map);
	}
	
	public int modifyEmail(String id, String email) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("email", email);
		return sqlSession.update("mybatis.memberMapper.modifyEmail",map);
	}
}
