package sms.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CertifiDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public void insertCertificationKey(HashMap<Object, Object> param) {
		sqlSession.insert("mybatis.smsMapper.insertCertificationKey", param);
	}



	public String getTempKey(String tempKey) {
		return (String)sqlSession.selectOne("mybatis.smsMapper.getTempKey", tempKey);
	}



	public void deleteTempKey(String tempKey) {
		sqlSession.delete("mybatis.smsMapper.deleteTempKey", tempKey);
	}

}
