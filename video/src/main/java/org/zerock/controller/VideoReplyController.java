package org.zerock.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.VideoReplyPageDTO;
import org.zerock.domain.VideoReplyVO;
import org.zerock.service.VideoReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/videoReplies/")
@RestController
@Log4j
@AllArgsConstructor
public class VideoReplyController {

	private VideoReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody VideoReplyVO vo){
		
		log.info("ReplyVO : "+vo);
		
		int insertCount=service.register(vo);
		
		log.info("Reply INSERT COUNT : "+insertCount);
		
		
		return insertCount ==1
				? new ResponseEntity<>("regist success",HttpStatus.OK)
						:new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	 
	@GetMapping(value = "/pages/{vno}/{page}",
			produces = {MediaType.APPLICATION_ATOM_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<VideoReplyPageDTO> getList(
	@PathVariable("page") int page,
	@PathVariable("vno") Long vno) {
				
		Criteria cri=new Criteria(page,10);
		
		log.info("get Reply List vno : "+vno);
		log.info("cri : "+cri);
		return new ResponseEntity<>(service.getListPage(cri, vno),HttpStatus.OK);
		
	}
	
	@GetMapping(value = "/{vrno}",
			produces = {MediaType.APPLICATION_ATOM_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<VideoReplyVO> get(@PathVariable("vrno") Long vrno) {
		
		log.info("get : "+vrno);
		return new ResponseEntity<>(service.get(vrno),HttpStatus.OK);
		
	}
	
	@PreAuthorize("principal.username == #vo.vreplyer")
	@DeleteMapping(value = "/{vrno}",produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@RequestBody VideoReplyVO vo,@PathVariable("vrno") Long vrno){
		
		log.info("remove : "+vrno);
		log.info("vReplyer: )"+vo.getVreplyer());
		
		return service.remove(vrno)==1
				? new ResponseEntity<>("remove success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	@PreAuthorize("principal.username == #vo.vreplyer")
	@RequestMapping(method = {RequestMethod.PUT,RequestMethod.PATCH},value = "/{vrno}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<String> modify(@RequestBody VideoReplyVO vo,@PathVariable("vrno") Long vrno){
		
		vo.setVno(vrno);
		log.info("vReplyer: )"+vo.getVreplyer());
		
		log.info("rno : "+vrno);
		log.info("modify : "+vo);
		
		return service.modify(vo)==1
				?new ResponseEntity<>("modify success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
