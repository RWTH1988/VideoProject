package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.domain.VideoVO;
import org.zerock.service.VideoService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/video/*")
@AllArgsConstructor
public class VideoController {
	
	private VideoService service;

	
	//@GetMapping("/list")
	public void list() {}
	
	
//	Video 관련 컨트롤러 입니다.
	@GetMapping("/list") //P.307참조
	public void getList(Criteria cri,Model model) {
		
		log.info("VideoLinkController getList......");
		
		int total = service.getTotal(cri);
		log.info("Video total: "+total);		
		
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	
	}

//	@RequestParam과 @ModelAttribute는 생략 가능!
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("vno") Long vno, @ModelAttribute("cri") Criteria cri , Model model) {
		
		log.info("/get or /modify");
		VideoVO video = service.get(vno);
		model.addAttribute("video", video);
	}
	
	@GetMapping("/main")
	public void list(Model model) {
		
		log.info("main");
	}	
	


}
