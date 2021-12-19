package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.VideoVO;
import org.zerock.mapper.VideoMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
//@AllArgsConstructor : spring 4.3의 생성자와 자동주입 이용하는 방법.
public class VideoServiceImpl implements VideoService {

	@Setter(onMethod_ = @Autowired)
	private VideoMapper mapper;
	 
	@Override
	public VideoVO get(Long vno) {

		log.info("비디오 조회 : " + vno); 
		mapper.hits(vno);	  
		return mapper.read(vno);
	}

	// (P.299)
	@Override
	public List<VideoVO> getList(Criteria cri) {

		log.info("VideoService GetList......");

		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {

		log.info("get total count");

		return mapper.getTotalCount(cri);

	}

	// 비디오 게시판 등록
	@Override
	public int write(VideoVO vo) {
		
		log.info("videoService wirte:" +vo);
		
		return mapper.insert(vo);
	}

	// 비디오 게시글 삭제
	@Override
	public int remove(Long vno) {

		log.info("remove..........." + vno);
		
		return mapper.delete(vno);
	}

	// 비디오 게시글 수정
	@Override
	public int modify(VideoVO vo) {

		log.info("update..........." + vo);
		
		return mapper.update(vo);
	}

	@Override
	public int modifyGood(VideoVO vo) {

		log.info("modify......" + vo);
		int modifyResult = mapper.good(vo);

		return modifyResult;
	}

	@Override
	public int modifyNoway(VideoVO vo) {

		log.info("modify......" + vo);
		int modifyResult = mapper.noway(vo);

		return modifyResult;
	}

	@Override
	public boolean hits(Long vno) {

		return mapper.hits(vno);
	}

}
