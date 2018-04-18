package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import member.bean.MemberDTO;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "loginForm.do")
	public ModelAndView loginForm() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/member/loginForm.jsp");

		return modelAndView;
	}

	/* 회원가입화면이동 추가 */
	@RequestMapping(value = "joinForm.do")
	public ModelAndView joinForm() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/member/joinForm.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "login.do")
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
				modelAndView.setViewName("redirect:/admin/main.jsp");
			} else {
				modelAndView.setViewName("redirect:index.jsp");
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

}
