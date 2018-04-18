package member.controller;

import member.bean.MemberDTO;

public interface MemberService {

	int insertMember(MemberDTO memberDTO);

	int updateMember(MemberDTO memberDTO);

	int deleteMember(String id);

	MemberDTO login(String id, String pw);

	boolean isExistId(String id);

}