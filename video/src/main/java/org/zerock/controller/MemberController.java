package org.zerock.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	
	private MemberService service;
	private PasswordEncoder pwencoder; // 회원가입 할 때, 비밀번호 시큐리티 적용.
	
	// S.631 로그인 경로 설정
	@GetMapping("/login")
	public void loginInput(String error, String logout, Model model) {
				
		log.info("loginInput error: " + error);
		log.info("logout : "+logout);
		log.info("로그인 페이지");	
								
		if(error != null) {
			model.addAttribute("error", "Login Error Check your Account");
		}
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}
	
	@GetMapping("/join")
	public void join() {
		
		log.info("회원가입 페이지 실행..");
		
	}
	
	@PostMapping("/register")
	public String register(MemberVO member, RedirectAttributes rttr) {
		
//(seit.565) 파일 첨부 글등록으로 변경
		log.info("===============Join start========================");				
		log.info("JOIN : "+member);
		log.info("===============Join end==========================");
		
		member.setUserpw(pwencoder.encode(member.getUserpw()));		
		log.info("pwencoder :" + member.getUserpw());		

		service.join(member);		
		rttr.addFlashAttribute("result", member.getUserid());
		
		log.info("회원가입 성공");
		
		return "redirect:/member/login";
		
//		int result = service.idCheck(member);
//		
//		try {
//			if(result ==1 ) {
//				
//				log.info("회원가입 실패!!!");
//				
//				return "/member/join";
//			}else {
		 
//			}			
//		}catch(Exception e) {
//			throw new RuntimeException();
//		}		
	}
	
	@GetMapping("/logout")
	public void logout() {
		
		log.info("로그아웃!!");
		
	}
	
	@PreAuthorize("principal.username == #userid")
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("userid") String userid, Model model) {
		
		log.info("member Controller get : "+userid);
		
		MemberVO member = service.get(userid);
		//service.get(userid);
		log.info(member);
		model.addAttribute("member", member);
	}
	
//	(S.720) 시큐리티 어노테이션 설정
	@PreAuthorize("principal.username == #member.userid")
	@PostMapping("/modify")
	public String modify(MemberVO member, RedirectAttributes rttr) {

		log.info("Member modify : " + member);
		//log.info("Member modify : " + userid); @RequestParam("userid") String userid,
		
		member.setUserpw(pwencoder.encode(member.getUserpw()));
		log.info("pwencoder :" + member.getUserpw());	
		
		if (service.modify(member)) {		
				
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/";
	}
	
	@PreAuthorize("principal.username == #userid")
	@PostMapping("/remove")
	public String remove(@RequestParam("userid") String userid, RedirectAttributes rttr) {
		
		log.info("Member remove : " + userid);		
		
		if (service.remove(userid)) {		
				
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/member/delete";
	}
	
	@GetMapping("/delete")
	public void delete() {
		
		log.info("회원 탈퇴");
	}

}
