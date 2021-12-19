package org.zerock.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.MemberVO;
import org.zerock.domain.VideoVO;
import org.zerock.service.MemberService;
import org.zerock.service.VideoService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@RequestMapping("/total/*")
@ResponseBody
@RestController
@Log4j
@AllArgsConstructor
public class TotalController {
	
	private VideoService video;
	
	private MemberService memberService;

/////////////////////비디오 게시판 등록//////////////////////////
	
	@PostMapping(value="/video/new",
	consumes="application/json",
	produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody VideoVO vo){
	
	log.info(" TotalCtrl VideoVo: " + vo);
		
	int insertCount = video.write(vo);
	
	log.info("Insert Count: " + insertCount);
	
	return insertCount == 1 ? new ResponseEntity<>("sucssecc", HttpStatus.OK)
	:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	
	/* null값 Test */
	//System.out.println("BoardVO: "+ vo);
	//return null;
	
	}
	
///////////////////////////////////////////////////////////
/////////////////////비디오 수정 Modal Get/////////////////////////
///////////////////////////////////////////////////////////	
	@GetMapping(value="/video/{vno}",			
			produces= {MediaType.TEXT_PLAIN_VALUE,
					   MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<VideoVO> get(@PathVariable("vno") Long vno){
		
		log.info("Total Ctrl : " + vno);
		
		
		return new ResponseEntity<>(video.get(vno), HttpStatus.OK);
	}
///////////////////////////////////////////////////////////
/////////////////////동영상 게시판 수정//////////////////////////
///////////////////////////////////////////////////////////	
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, //put은 전체 필드 PATCH는 일부.쿼리문에서 사용
			value="/video/{vno}",
			consumes="application/json")
			//produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
			@RequestBody VideoVO vo, @PathVariable("vno")Long vno){
			
		log.info("vno: "+ vno);
		log.info("modify: "+ vo);
		
		return video.modify(vo) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}		
	

	
///////////////////////////////////////////////////////////
/////////////////////동영상 게시판 삭제//////////////////////////
///////////////////////////////////////////////////////////
	@DeleteMapping("/video/{vno}")
	public ResponseEntity<String> remove(@RequestBody VideoVO vo,
			@PathVariable("vno")Long vno){
		
		log.info("Remove: " + vno);
		
		return video.remove(vno)==1
			? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}	
		
	// 동영상 좋아요
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, //put은 전체 필드 PATCH는 일부.쿼리문에서 사용
			value="/good/{vno}",
			consumes="application/json")
			//produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> good(
			@RequestBody VideoVO vo, @PathVariable("vno") Long vno){
			
		vo.setVno(vno);
		
		log.info("vno: "+ vno);
		log.info("good: "+ vo);
		
		return video.modifyGood(vo) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}	
	
	// 동영상 싫어요
		@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, //put은 전체 필드 PATCH는 일부.쿼리문에서 사용
				value="/noway/{vno}",
				consumes="application/json")
				//produces= {MediaType.TEXT_PLAIN_VALUE})
		public ResponseEntity<String> noway(
				@RequestBody VideoVO vo, @PathVariable("vno") Long vno){
				
			vo.setVno(vno);
			
			log.info("vno: "+ vno);
			log.info("noway: "+ vo);
			
			return video.modifyNoway(vo) == 1
					? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	//	아이디 중복 체크
		@ResponseBody
		@PostMapping(value="/idCheck",
				consumes="application/json"
				)
		public int idCheck(MemberVO member) throws Exception{
			
			log.info("아이디 중복체크 실행:"+member);
			
			int result = memberService.idCheck(member);
			
			return result;		
		}

	
	

}
