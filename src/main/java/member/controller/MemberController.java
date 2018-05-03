package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	public ModelAndView loginForm() {
		ModelAndView modelAndView = new ModelAndView();
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
				modelAndView.setViewName("redirect:../index.jsp");
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

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:index.jsp");
		return modelAndView;
	}

	/*아이디 찾기(아이디 일부분)*/
	@RequestMapping(value="/member/findId.do")
	public ModelAndView findId(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		String id = null;
		String subString = null;
		String result = null;

		String type = request.getParameter("type");

		if(type.equals("phone")) {
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			result = memberService.findId_phone(name, phone);
			if(result != null) {
				subString = result.substring(0, result.length()-3);
				id = subString + "***";

				modelAndView.addObject("id", id);
				modelAndView.setViewName("find_idSuccess.jsp");
			}else {
				modelAndView.setViewName("find_Fail.jsp");
			}
		}else if(type.equals("email")){
			String name = request.getParameter("name");
			String email = request.getParameter("email");

			result = memberService.findId_email(name, email);

			if(result != null) {
				subString = result.substring(0, result.length()-3);
				id = subString + "***";

				modelAndView.addObject("id", id);
				modelAndView.addObject("result", "success");
				modelAndView.setViewName("find_idSuccess.jsp");
			}else {
				modelAndView.setViewName("find_Fail.jsp");
			}
		}

		return modelAndView;
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
			modelAndView.setViewName("find_idSuccess.jsp");
		}else {
			modelAndView.setViewName("find_Fail.jsp");
		}

		return modelAndView;
	}

	/*비밀번호 찾기(비밀번호 일부분)*/
	@RequestMapping(value="/member/findPw.do")
	public ModelAndView findPw(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		String pw = null;
		String subString = null;
		String result = null;

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		result = memberService.findPw_email(name, email);

		if(result != null) {
			subString = result.substring(0, result.length()-5);
			pw = subString + "*****";

			modelAndView.addObject("pw", pw);
			modelAndView.setViewName("find_idSuccess.jsp");
		}else {
			modelAndView.setViewName("find_Fail.jsp");
		}

		return modelAndView;
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
			modelAndView.setViewName("find_pwSuccess.jsp");
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
}
