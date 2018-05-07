package board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
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

		int totalPage = (total + 14) / 15;

		int startPage = (pg - 1) / 10 * 10 + 1;
		int endPage = startPage + 9;

		if (totalPage < endPage)
			endPage = totalPage;

		modelAndView.addObject("pg", pg);
		modelAndView.addObject("totalPage", totalPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("boardList", boardList);

		modelAndView.setViewName("/board/boardList.jsp");
		return modelAndView;
	}

	// 관리자 : 공지 사항 목록 요청
	@RequestMapping(value = "/admin/noticeList_admin.do")
	public ModelAndView noticeList_admin(HttpServletRequest request) {
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 10;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<BoardDTO> boardList = boardService.getBoardList(startNum, endNum);

		int listCount = boardService.getTotal();
		int maxPage = (listCount + (limit - 1)) / limit;
		int startPage = (page - 1) / 10 * 10 + 1;
		int endPage = startPage + 9;
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("boardList", boardList);
		modelAndView.addObject("page", page);
		modelAndView.addObject("maxPage", maxPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.setViewName("board/noticeList.jsp");

		return modelAndView;
	}

	// 관리자 : 검색된 공지 사항 목록 요청
	@RequestMapping(value = "/admin/searchedNoticeList_admin.do")
	public ModelAndView searchedNoticeList_admin(HttpServletRequest request) {
		String keyword = request.getParameter("keyword");
		int page = Integer.parseInt(request.getParameter("page"));

		int limit = 10;
		int endNum = page * limit;
		int startNum = endNum - (limit - 1);

		ArrayList<BoardDTO> boardList = boardService.getSearchedBoardList(keyword, startNum, endNum);

		int listCount = boardService.getSearchedTotal(keyword);
		int maxPage = (listCount + (limit - 1)) / limit;
		int startPage = (page - 1) / 10 * 10 + 1;
		int endPage = startPage + 9;
		if (maxPage < endPage) {
			endPage = maxPage;
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("boardList", boardList);
		modelAndView.addObject("keyword", keyword);
		modelAndView.addObject("page", page);
		modelAndView.addObject("maxPage", maxPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.setViewName("board/noticeList.jsp");

		return modelAndView;
	}

	// 관리자 : 공지 사항 입력 양식 요청
	@RequestMapping(value = "/admin/noticeInsertForm_admin.do")
	public ModelAndView noticeInsertForm_admin(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("board/noticeInsertForm.jsp");

		return modelAndView;
	}

	// 관리자 : 공지 사항 입력 요청
	@RequestMapping(value = "/admin/noticeInsert_admin.do")
	public ModelAndView noticeInsert_admin(HttpServletRequest request, MultipartFile img) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memId");
		String name = (String) session.getAttribute("memName");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");

		String filePath = request.getSession().getServletContext().getRealPath("/img");
		String fileName = img.getOriginalFilename();

		if (!fileName.equals("")) {
			File file = new File(filePath, fileName);

			try {
				FileCopyUtils.copy(img.getInputStream(), new FileOutputStream(file));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setId(id);
		boardDTO.setName(name);
		boardDTO.setSubject(subject);
		boardDTO.setContent(content);
		boardDTO.setImg(fileName);

		int result = boardService.insertBoard(boardDTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("board/noticeInsert.jsp");

		return modelAndView;
	}

	// 관리자 : 공지 사항 보기 요청
	@RequestMapping(value = "/admin/noticeView_admin.do")
	public ModelAndView noticeView_admin(HttpServletRequest request) {
		int seq = Integer.parseInt(request.getParameter("seq"));
		int page = Integer.parseInt(request.getParameter("page"));

		BoardDTO boardDTO = boardService.getBoard(seq);
		String logtime = boardDTO.getLogtime();
		boardDTO.setLogtime(logtime.substring(0, logtime.indexOf(" ")));

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("boardDTO", boardDTO);
		modelAndView.addObject("page", page);
		modelAndView.setViewName("board/noticeView.jsp");

		return modelAndView;
	}

	// 관리자 : 공지 사항 수정 양식 요청
	@RequestMapping(value = "/admin/noticeUpdateForm_admin.do")
	public ModelAndView noticeUpdateForm_admin(HttpServletRequest request) {
		int seq = Integer.parseInt(request.getParameter("seq"));
		int page = Integer.parseInt(request.getParameter("page"));

		BoardDTO boardDTO = boardService.getBoard(seq);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("boardDTO", boardDTO);
		modelAndView.addObject("page", page);
		modelAndView.setViewName("board/noticeUpdateForm.jsp");

		return modelAndView;
	}

	// 관리자 : 공지 사항 수정 요청
	@RequestMapping(value = "/admin/noticeUpdate_admin.do")
	public ModelAndView noticeUpdate_admin(HttpServletRequest request, MultipartFile img) {
		int seq = Integer.parseInt(request.getParameter("seq"));
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");

		String filePath = request.getSession().getServletContext().getRealPath("/img");
		String fileName = img.getOriginalFilename();

		if (!fileName.equals("")) {
			File file = new File(filePath, fileName);

			try {
				FileCopyUtils.copy(img.getInputStream(), new FileOutputStream(file));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setSeq(seq);
		boardDTO.setSubject(subject);
		boardDTO.setContent(content);
		boardDTO.setImg(fileName);

		int result = boardService.updateBoard(boardDTO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("board/noticeUpdate.jsp");

		return modelAndView;
	}

	// 관리자 : 공지 사항 삭제 요청
	@RequestMapping(value = "/admin/noticeDelete_admin.do")
	public ModelAndView noticeDelete_admin(HttpServletRequest request) {
		int seq = Integer.parseInt(request.getParameter("seq"));

		int result = boardService.deleteBoard(seq);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("board/noticeDelete.jsp");

		return modelAndView;
	}

	// 관리자 : 건의 사항 목록 요청
	@RequestMapping(value = "/admin/boardList_admin.do")
	public ModelAndView boardList_admin(HttpServletRequest request) {
		return null;
	}

}
