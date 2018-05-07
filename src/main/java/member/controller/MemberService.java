package member.controller;

import member.bean.MemberDTO;

public interface MemberService {

	int insertMember(MemberDTO memberDTO);

	int updateMember(MemberDTO memberDTO);

	int deleteMember(String id, String pw);
	
	MemberDTO myInfo(String id);

	MemberDTO login(String id, String pw);

	boolean isExistId(String id);
	
	boolean isExistEmail(String email);
	
	String findId_phone(String name, String phone);
	
	String findId_email(String name, String email);
	
	String findPw_email(String name, String email);
	
	String findPw_phone(String name, String phone);
	
	boolean certifiMemCheck(String name, String phone);
	
	int updateBranch(MemberDTO memberDTO);
	
	int deleteBranch(String id);
	
	int modifyPw(String id, String pw, String newPw1);
	
	int modifyPhone(String id, String phone);
	
	int modifyEmail(String id, String email);
}
