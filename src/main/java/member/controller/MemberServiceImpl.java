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
	public int deleteMember(String id, String pw) {
		return memberDAO.deleteMember(id, pw);
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
	public boolean isExistEmail(String email) {
		return memberDAO.isExistEmail(email);
	}

	@Override
	public String findId_phone(String name, String phone) {
		return memberDAO.findId_phone(name, phone);
	}

	@Override
	public String findId_email(String name, String email) {
		return memberDAO.findId_email(name, email);
	}
	
	@Override
	public String findPw_email(String name, String email) {
		return memberDAO.findPw_email(name, email);
	}
	
	@Override
	public String findPw_phone(String name, String phone) {
		return memberDAO.findPw_phone(name, phone);
	}

	@Override
	public int updateBranch(MemberDTO memberDTO) {
		return memberDAO.updateBranch(memberDTO);
	}
	
	@Override
	public int deleteBranch(String id) {
		return memberDAO.deleteBranch(id);
	}

	@Override
	public boolean certifiMemCheck(String name, String phone) {
		return memberDAO.certifiMemCheck(name, phone);
	}

	@Override
	public MemberDTO myInfo(String id) {
		return memberDAO.myInfo(id);
	}

	@Override
	public int modifyPw(String id, String pw, String newPw1) {
		return memberDAO.modifyPw(id, pw, newPw1);
	}

	@Override
	public int modifyPhone(String id, String phone) {
		return memberDAO.modifyPhone(id, phone);
	}

	@Override
	public int modifyEmail(String id, String email) {
		return memberDAO.modifyEmail(id, email);
	}
}
