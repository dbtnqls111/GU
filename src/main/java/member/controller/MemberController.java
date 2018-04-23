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

	@RequestMapping(value = "/member/loginForm.do")
	public ModelAndView loginForm() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/member/loginForm.jsp");

		return modelAndView;
	}

	/* 회원가입화면이동 */
	@RequestMapping(value = "/member/joinForm.do")
	public ModelAndView joinForm() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/member/joinForm.jsp");

		return modelAndView;
	}

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
	
	/*회원가입  아이디 중복 여부*/
	@RequestMapping(value = "/member/isExistId.do" )
	public @ResponseBody String isExistId(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		String id = request.getParameter("id");
		String str = "";
		boolean idChk = memberService.isExistId(id);
		modelAndView.addObject("idChk", idChk);
		str="{\"idChk\":\""+idChk+"\"}";
		return str;
	}
}
