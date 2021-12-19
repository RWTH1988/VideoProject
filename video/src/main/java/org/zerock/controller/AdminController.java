package org.zerock.controller;

import java.util.List;
import java.util.Locale;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.domain.PageDTO;
import org.zerock.domain.VideoVO;
import org.zerock.service.MainService;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminController {
	
	private MemberService service;
	private MainService mainService;
	private PasswordEncoder pwencoder;
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/main")
	public String main(Locale locale,Criteria cri, Model model){
		
		log.info("Welcome home! The client locale is {}."+ locale);
		
		log.info("main");
		
		int total = service.getTotal(cri);
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));		
		
		List<VideoVO> category= mainService.getCate();
		
		for(int i=0;i<=category.size();i++) {
		log.info("사이즈"+category.size());}
		
		for(int i=0;i<category.size();i++) {
		
		model.addAttribute("category"+i, category.get(i));

		model.addAttribute("rank"+i,mainService.getMainList(category.get(i)));
		
		}
		return "/admin/main";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')") // S.712
	@GetMapping("/list")	
	public void list(Criteria cri, Model model, String userid) {

		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTO(cri,123)); // 테스트 용

		int total = service.getTotal(cri);
		log.info("total: " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/modify")
	public void get(@RequestParam("userid") String userid, @ModelAttribute("cri") Criteria cri, Model model) {

		log.info("/get or /modify");
		MemberVO member = service.get(userid);
		model.addAttribute("member", member);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/modify")
	public String modify(MemberVO member, RedirectAttributes rttr) {

		log.info("Member modify : " + member);
		//log.info("Member modify : " + userid); @RequestParam("userid") String userid,
		
		member.setUserpw(pwencoder.encode(member.getUserpw()));
		log.info("pwencoder :" + member.getUserpw());	
		
		if (service.modify(member)) {		
				
			rttr.addFlashAttribute("result", "정보수정 성공!");
		}

		return "redirect:/admin/list";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/remove")
	public String remove(@RequestParam("userid") String userid, RedirectAttributes rttr) {
		
		log.info("Member remove : " + userid);		
		
		if (service.remove(userid)) {		
				
			rttr.addFlashAttribute("result", "탈퇴 완료!!");
		}
		return "redirect:/admin/list";
	}

}
