package Mypage;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import CommunityModel.CommunityDto;
import CommunityModel.InputDto;
import Member.MemberDto;

@Controller
public class MypageController {

	@Autowired
	private ModelAndView mv;

	@Autowired
	private MypageDao dao;

	@RequestMapping("/myPage.do")
	public ModelAndView myPage(HttpSession session) {
		MemberDto dto = new MemberDto();
		dto.setMem_id(session.getAttribute("userId") + "");

		mv.addObject("memInfo", dao.memInfo(dto));
		mv.setViewName("/mypage/myPage.jsp");
		return mv;
	}

	@RequestMapping("/myPageEdit.do")
	public ModelAndView myPageEdit(HttpServletRequest req, HttpSession session) {
		MemberDto dto = new MemberDto();
		dto.setMem_id(session.getAttribute("userId") + "");
		mv.addObject("memInfo", dao.memInfo(dto));
		mv.setViewName("/mypage/myPageEdit.jsp");
		return mv;
	}

	@RequestMapping("/EditSus.do")
	public ModelAndView EditSus(HttpSession session) {
		MemberDto dto = new MemberDto();
		dto.setMem_id(session.getAttribute("userId") + "");
		mv.addObject("memInfo", dao.memInfo(dto));
		mv.addObject("userGender", dto.getMem_gender());
		mv.setViewName("/mypage/EditSus.jsp");
		return mv;
	}

	@RequestMapping(value = "/Edit.do", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public ModelAndView modify(HttpServletRequest req, HttpSession session) {

		MemberDto dto = new MemberDto();
		dto.setMem_id(session.getAttribute("userId") + "");
		MemberDto newdto = dao.memInfo(dto);
		dto.setMem_nickname(req.getParameter("nickname"));
		dto.setMem_pw(req.getParameter("inputPw"));
		dto.setMem_email(req.getParameter("email1") + "@" + req.getParameter("email2"));
		dto.setMem_rocal(req.getParameter("rocal"));
		dto.setMem_state(req.getParameter("state"));
		dto.setMem_gender(req.getParameter("gender"));
		dto.setMem_age_group(req.getParameter("ageRange"));

		if (req.getParameter("nickname").equals("")) {
			dto.setMem_nickname(newdto.getMem_nickname());
		}
		if (req.getParameter("inputPw").equals("")) {
			dto.setMem_pw(newdto.getMem_pw());
		}
		if ((req.getParameter("email1") + "@" + req.getParameter("email2")).equals("@")) {
			dto.setMem_email(newdto.getMem_email());
		}
		if (req.getParameter("rocal").equals("")) {
			dto.setMem_rocal(newdto.getMem_rocal());
		}
		if (req.getParameter("state").equals("") || req.getParameter("state").equals("시·군·구 선택")) {
			dto.setMem_state(newdto.getMem_state());
		}
		if (req.getParameter("gender").equals(newdto.getMem_gender())) {
			dto.setMem_gender(newdto.getMem_gender());
		}
		if (req.getParameter("ageRange").equals(newdto.getMem_age_group()) || req.getParameter("ageRange").equals("")) {
			dto.setMem_age_group(newdto.getMem_age_group());
		}

		dao.memEdit(dto);
		mv.setViewName("/mypage/EditSus.jsp");
		return mv;

	}

	@RequestMapping("/myWriteList.do")
	public ModelAndView myWriteList(HttpSession session) {
		CommunityDto Cdto = new CommunityDto();
		Cdto.setBRD_WRT_ID(session.getAttribute("userId") + "");
		mv.addObject("writeList", dao.writeList(Cdto));
		mv.addObject("write", dao.Category());
		mv.setViewName("/mypage/writeList.jsp");
		return mv;
	}

	@RequestMapping("/myFAQ.do")
	public ModelAndView myFAQ() {
		mv.addObject("write", dao.Category());
		mv.setViewName("/mypage/myFAQ.jsp");
		return mv;
	}

	@RequestMapping(value = "/myPageFaQinsert.do", method = RequestMethod.POST)

	@ResponseBody
	public void community_input_content(InputDto data, HttpServletRequest request) {
		System.out.println(data);
		CommunityDto dto = new CommunityDto(0, data.getBRD_TIT(), data.getBRD_WRT_ID(), new Timestamp((System.currentTimeMillis()/1000L)*1000L), data.getBRD_CONTENT(), 0,
				data.getCATEGORY_IDX());
		dao.write(dto);
	}

	@RequestMapping("/myFavorite.do")
	public ModelAndView myFavoriteList() {
		mv.setViewName("/mypage/myfavorite.jsp");
		return mv;
	}

	@RequestMapping("/mySaved.do")
	public ModelAndView mySaved() {
		mv.setViewName("/mypage/mySaved.jsp");
		return mv;
	}

}
