package Community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import CommunityModel.CommunityDao;

@Controller
public class CommunityController{
	CommunityDao dao = new CommunityDao();
	@Autowired
	private ModelAndView mv;
	
	@RequestMapping("/Community_main.do")
	public ModelAndView community_main() {
		mv.addObject("list1", dao.Main1());
		mv.addObject("list2", dao.Main2());
		mv.addObject("list3", dao.Main3());
		mv.addObject("list4", dao.Main4());
		mv.setViewName("community/C_main.jsp");
		return mv;
	}
	
	
	
	@RequestMapping("/Community_list_sook.do")
	
	public ModelAndView community_list_sook() {
		mv.addObject("list", dao.list1());
		mv.setViewName("community/C_list.jsp");
		return mv;
	}
	@RequestMapping("/Community_list_jeong.do")
	public ModelAndView community_list_jeong() {
		mv.addObject("list", dao.list2());
		mv.setViewName("community/C_list.jsp");
		return mv;
	}
	@RequestMapping("/Community_list_Q.do")
	public ModelAndView community_list_Q() {
		mv.addObject("list", dao.list3());
		mv.setViewName("community/C_list.jsp");
		return mv;
	}
	@RequestMapping("/Community_list_shin.do")
	public ModelAndView community_list_sin() {
		mv.addObject("list", dao.list4());
		mv.setViewName("community/C_list.jsp");
		return mv;
	}
	
	
	
	@RequestMapping("/Community_detail.do")
	public ModelAndView community_detail() {
		mv.setViewName("community/C_detail.jsp");
		return mv;
	}
	
	
	
	@RequestMapping("/Community_input.do")
	public ModelAndView community_input() {
		mv.setViewName("community/C_input.jsp");
		return mv;
	}
	
}
