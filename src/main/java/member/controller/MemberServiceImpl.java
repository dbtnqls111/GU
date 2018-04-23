package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import member.bean.MemberDTO;
import member.dao.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;

	@Override
	public int insertMember(MemberDTO memberDTO) {
		return memberDAO.insertMember(memberDTO);
	}

	@Override
	public int updateMember(MemberDTO memberDTO) {
		return memberDAO.updateMember(memberDTO);
	}

	@Override
	public int deleteMember(String id) {
		return memberDAO.deleteMember(id);
	}

	@Override
	public MemberDTO login(String id, String pw) {
		return memberDAO.login(id, pw);
	}

	@Override
	public boolean isExistId(String id) {
		return memberDAO.isExistId(id);
	}

	@Override
	public String findId_phone(String name, String phone) {
		return memberDAO.findId_phone(name, phone);
	}

	@Override
	public String findId_email(String name, String email) {
		return memberDAO.findId_email(name, email);
	}
}
