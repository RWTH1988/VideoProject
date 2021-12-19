package org.zerock.controller;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.domain.VideoVO;
import org.zerock.service.MainService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Log4j
@Controller
@AllArgsConstructor
public class HomeController {
	
	private MainService service;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale,Criteria cri, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
	
		log.info("main");
		
		int total = service.getTotal(cri);
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		
		List<VideoVO> category= service.getCate();
		
		for(int j=0;j<category.size();j++) {
		
		model.addAttribute("category"+j, category.get(j));
		
		model.addAttribute("rank"+j,service.getMainList(category.get(j)));
	
		}
		return "main";
	}
	
	@GetMapping("/findUs")
	public void findUs() {	
		
		log.info("찾아 오시는 길");				
	
	
	}
	@GetMapping("/us")
	public void us() {	
		
		log.info("팀 소개");				
	
	
	}
	
}
