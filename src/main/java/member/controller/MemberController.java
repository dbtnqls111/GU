package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import member.bean.MemberDTO;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	/*로그인화면이동*/
	@RequestMapping(value = "/member/loginForm.do")
	public ModelAndView loginForm(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();

		String path = request.getParameter("path");
		modelAndView.addObject("path", path);
		modelAndView.setViewName("/member/loginForm.jsp");

		return modelAndView;
	}

	/* 약관동의 화면 이동 */
	@RequestMapping(value = "/member/agreeForm.do")
	public ModelAndView agreeForm() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/member/agree.jsp");

		return modelAndView;
	}

	/* 회원가입화면이동 */
	@RequestMapping(value = "/member/joinForm.do")
	public ModelAndView joinForm() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/member/joinForm.jsp");

		return modelAndView;
	}

	/*로그인*/
	@RequestMapping(value = "/member/login.do")
	public ModelAndView login(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String path = request.getParameter("path");
		String[] path_real = path.split("/GU/");
		
		MemberDTO memberDTO = memberService.login(id, pw);

		ModelAndView modelAndView = new ModelAndView();
		if (memberDTO != null) {
			HttpSession session = request.getSession();
			session.setAttribute("memName", memberDTO.getName());
			session.setAttribute("memId", memberDTO.getId());
			session.setAttribute("branchCode", memberDTO.getBranchCode());

			if (memberDTO.getBranchCode() == null) {
				modelAndView.setViewName("redirect:/admin/main.do");
			} else {
				modelAndView.setViewName("redirect:../"+path_real[1]);
			}
		} else {
			modelAndView.setViewName("/member/loginFail.jsp");
		}

		return modelAndView;
	}

	/*로그아웃*/
	@RequestMapping(value = "logout.do")
	public ModelAndView logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("memName");
		session.removeAttribute("memId");
		session.invalidate();

		String path = request.getParameter("path");
		String[] path_real = path.split("/GU/");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:"+path_real[1]);
		return modelAndView;
	}

	/*아이디 찾기(아이디 일부분)*/
	@RequestMapping(value="/member/findId.do")
	public @ResponseBody String findId(HttpServletRequest request) {
		String id = null;
		String subString = null;
		String result = null;
		String str = "";

		String type = request.getParameter("type");

		if(type.equals("phone")) {
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			result = memberService.findId_phone(name, phone);
			if(result != null) {
				subString = result.substring(0, result.length()-3);
				id = subString + "***";

				str = "{\"result\":\""+id+"\"}";
			}else {
				str = "{\"result\":\"fail\"}";
			}
		}else if(type.equals("email")){
			String name = request.getParameter("name");
			String email = request.getParameter("email");

			result = memberService.findId_email(name, email);

			if(result != null) {
				subString = result.substring(0, result.length()-3);
				id = subString + "***";

				str = "{\"result\":\""+id+"\"}";
			}else {
				str = "{\"result\":\"fail\"}";
			}
		}

		return str;
	}

	/*아이디 찾기(sms인증)*/
	@RequestMapping(value="/member/findIdAll.do")
	public ModelAndView findIdAll(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();

		String id = null;
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");

		id = memberService.findId_phone(name, phone);
		if(id != null) {
			modelAndView.addObject("id", id);
			modelAndView.setViewName("find_idSuccessAll.jsp");
		}else {
			modelAndView.setViewName("find_Fail.jsp");
		}

		return modelAndView;
	}

	/*비밀번호 찾기(비밀번호 일부분)*/
	@RequestMapping(value="/member/findPw.do")
	public @ResponseBody String findPw(HttpServletRequest request) {
		String pw = null;
		String subString = null;
		String result = null;
		String str = "";

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		result = memberService.findPw_email(name, email);

		if(result != null) {
			subString = result.substring(0, result.length()-5);
			pw = subString + "*****";

			str = "{\"result\":\""+pw+"\"}";
		}else {
			str = "{\"result\":\"fail\"}";
		}

		return str;
	}

	/*비밀번호 찾기(sms인증)*/
	@RequestMapping(value="/member/findPwAll.do")
	public ModelAndView findPwAll(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		String pw = null;

		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		
		pw = memberService.findPw_email(name, phone);

		if(pw != null) {
			modelAndView.addObject("pw", pw);
			modelAndView.setViewName("find_pwSuccessAll.jsp");
		}else {
			modelAndView.setViewName("find_Fail.jsp");
		}

		return modelAndView;
	}


	/*회원가입  아이디 중복 여부*/
	@RequestMapping(value = "/member/isExistId.do")
	public @ResponseBody String isExistId(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		String id = request.getParameter("id");
		String str = "";
		boolean idChk = memberService.isExistId(id);
		modelAndView.addObject("idChk", idChk);
		str="{\"idChk\":\""+idChk+"\"}";
		return str;
	}

	/*회원가입  이메일 중복 여부*/
	@RequestMapping(value = "/member/isExistEmail.do")
	public @ResponseBody String isExistEmail(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		String email = request.getParameter("email");
		String str = "";
		boolean emailChk = memberService.isExistEmail(email);
		System.out.println(emailChk);
		modelAndView.addObject("emailChk", emailChk);
		str="{\"emailChk\":\""+emailChk+"\"}";
		return str;
	}

	/*회원가입*/
	@RequestMapping(value = "/member/insertMember.do")
	public ModelAndView insertMember(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();

		MemberDTO memberDTO = new MemberDTO();

		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
		String email = request.getParameter("email1") + "@" + request.getParameter("email2");

		memberDTO.setGender(request.getParameter("gender"));
		memberDTO.setId(request.getParameter("id"));
		memberDTO.setPw(request.getParameter("pw"));
		memberDTO.setName(request.getParameter("name"));
		memberDTO.setPhone(phone);
		memberDTO.setEmail(email);
		memberDTO.setBranchCode(request.getParameter("branch"));

		int result = memberService.insertMember(memberDTO);

		if(result > 0) {
			memberService.updateBranch(memberDTO);
			modelAndView.setViewName("redirect:../index.jsp");
		}else {

		}
		return modelAndView;
	}

	/*휴대폰인증번호 발송전 회원 가입 여부 확인*/
	@RequestMapping(value = "/member/certifiMemCheck.do")
	public  @ResponseBody String certifiIdCheck(HttpServletRequest request) {
		String str = "";

		String name = request.getParameter("name");
		String phone = request.getParameter("phone");

		boolean result = memberService.certifiMemCheck(name, phone);

		if(result == true) {
			str ="{\"result\":\"true\"}";
		}else {
			str ="{\"result\":\"false\"}";
		}
		return str;
	}
	
	/*내정보 불러오기*/
	@RequestMapping(value = "/member/myInfo.do")
	public ModelAndView myInfo(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memId");
		
		if(id != null) {
			MemberDTO memberDTO = memberService.myInfo(id);
			
			modelAndView.addObject("memberDTO", memberDTO);
			modelAndView.setViewName("myInfo.jsp");
		}else {
			
		}
		return modelAndView;
	}
	
	/*비밀번호 변경*/
	@RequestMapping(value = "/member/modifyPw.do")
	public @ResponseBody String modifyPw(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String newPw1 = request.getParameter("newPw1");
		String str = "";
		int result = 0;
		
		result = memberService.modifyPw(id, pw, newPw1);
		System.out.println(result);

		str="{\"result\":\""+result+"\"}";
		
		return str;
	}
	
	/*휴대폰 번호 변경*/
	@RequestMapping(value = "/member/modifyPhone.do")
	public @ResponseBody String modifyPhone(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String phone = request.getParameter("phone");
		String str = "";
		int result = 0;
		
		result = memberService.modifyPhone(id, phone);

		str="{\"result\":\""+result+"\"}";
		
		return str;
	}
	
	/*이메일 변경*/
	@RequestMapping(value = "/member/modifyEmail.do")
	public @ResponseBody String modifyEmail(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String str = "";
		int result = 0;
		
		result = memberService.modifyEmail(id, email);

		str="{\"result\":\""+result+"\"}";
		
		return str;
	}
	
	/*회원탈퇴*/
	@RequestMapping(value = "/member/deleteMember.do")
	public @ResponseBody String deleteMember(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String str = "";
		int result = 0;
		int branchResult = 0;
		
		result = memberService.deleteMember(id, pw);
		
		if(result > 0) {
			branchResult = memberService.deleteBranch(id);
			if(branchResult > 0) {
				HttpSession session = request.getSession();
				session.removeAttribute("memName");
				session.removeAttribute("memId");
				session.invalidate();
				str="{\"result\":\""+result+"\"}";
			}else {
				
			}
		}else {
			
		}
		return str;
	}
	
	@RequestMapping(value = "/member/find_idSuccess.do")
	public ModelAndView idSuccess(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		
		String id = request.getParameter("id");
		
		modelAndView.addObject("id", id);
		modelAndView.setViewName("find_idSuccess.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/member/find_pwSuccess.do")
	public ModelAndView pwSuccess(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		
		String pw = request.getParameter("pw");
		
		modelAndView.addObject("pw", pw);
		modelAndView.setViewName("find_pwSuccess.jsp");
		
		return modelAndView;
	}
}
