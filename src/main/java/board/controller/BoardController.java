package board.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import board.bean.BoardDTO;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "boardView.do")
	public ModelAndView getBoard(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		int seq = Integer.parseInt(request.getParameter("seq"));
		int pg = Integer.parseInt(request.getParameter("pg"));
		
		boardService.updatHit(seq);
		BoardDTO boardDTO = boardService.getBoard(seq);
		String logtime = boardDTO.getLogtime();
		boardDTO.setLogtime(logtime.substring(0, logtime.indexOf(" ")));
		
		modelAndView.addObject("boardDTO", boardDTO);
		modelAndView.addObject("pg", pg);
		modelAndView.setViewName("/board/boardView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "boardList.do")
	public ModelAndView getBoardList(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		int pg = Integer.parseInt(request.getParameter("pg"));
		int endNum = pg * 15;
		int startNum = endNum - 14;
		
		ArrayList<BoardDTO> boardList = boardService.getBoardList(startNum, endNum);
		
		int total = boardService.getTotal();
		int totalPage = (total+4)/15;		
		
		int startPage = (pg-1)/10*10+1;
		int endPage = startPage + 9;
		
		if(totalPage<endPage)endPage=totalPage;
		
		modelAndView.addObject("pg", pg);
		modelAndView.addObject("totalPage", totalPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("boardList", boardList);
		
		modelAndView.setViewName("/board/boardList.jsp");
		return modelAndView;
	}
}
