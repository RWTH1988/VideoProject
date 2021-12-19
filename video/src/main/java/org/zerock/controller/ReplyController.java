package org.zerock.controller;

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
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;

	@PreAuthorize("isAuthenticated()") //(S.729) 스프링 시큐리티 설정
	@PostMapping(value="/new",
				consumes="application/json",
				produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		
		log.info("ReplyVO: "+ vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply Insert Count: " + insertCount);
		
		return insertCount == 1 
				? new ResponseEntity<>("sucssecc", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//		if 문이나 내가 좀 더 생각해내기 쉬운 방법으로 리코딩 해볼 것!
	}
	
//	Seit.435 댓글 페이징 처리를 위한 getList()
	@GetMapping(value="/pages/{bno}/{page}",
			produces= {MediaType.APPLICATION_XML_VALUE,
					   MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page,
												@PathVariable("bno")Long bno){

		Criteria cri = new Criteria(page, 10);
		
		log.info("get Reply List bno: "+ bno);
		log.info("cri : "+cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}

	/* 댓글 페이징 처리 전 getList()
	 * @GetMapping(value="/pages/{bno}/{page}", produces=
	 * {MediaType.TEXT_PLAIN_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE}) public
	 * ResponseEntity<List<ReplyVO>> getList(
	 * 
	 * @PathVariable("page") int page, @PathVariable("bno")Long bno){
	 * 
	 * log.info("getList......................."); Criteria cri = new
	 * Criteria(page,10); log.info(cri);
	 * 
	 * // List<ReplyVO> list = service.getList(cri,bno); // new
	 * ReponseEntity<>(list, HttpStatus.OK); return new
	 * ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK); }
	 */
	
	@GetMapping(value="/{rno}",			
			produces= {MediaType.TEXT_PLAIN_VALUE,
					   MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		
		log.info("get: " + rno);
		
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
//	(S.732) json으로 전송되는 데이터를 처리 하도록 수정
//	@DeleteMapping(value="/{rno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping("/{rno}")
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo,
			@PathVariable("rno")Long rno){
		
		log.info("Remove: " + rno);
		log.info("replyer: "+ vo.getReplyer());
		
		return service.remove(rno)==1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
//	(S.734) 본인만 댓글 수정 가능하도록 설정
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH},
			value="/{rno}",
			consumes="application/json")
			//produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo, @PathVariable("rno")Long rno){
		
//		vo.setRno(rno);
		
		log.info("rno: "+ rno);
		log.info("modify: "+ vo);
		
		return service.modify(vo) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}		
	
}
