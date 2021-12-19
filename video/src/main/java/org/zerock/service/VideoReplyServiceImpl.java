package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.VideoReplyPageDTO;
import org.zerock.domain.VideoReplyVO;
import org.zerock.mapper.VideoReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;



@Log4j
@Service
@AllArgsConstructor
public class VideoReplyServiceImpl implements VideoReplyService {
	
	@Setter(onMethod_ =@Autowired)
	private VideoReplyMapper mapper;
	
	@Transactional
	@Override
	public int register(VideoReplyVO vo) {
		log.info("rgister -> "+vo);
		return mapper.insert(vo);
	}
	
	
	@Override
	public VideoReplyVO get(Long vrno) {
		log.info("get -> "+vrno);
		return mapper.read(vrno);
	}

	@Override
	public int modify(VideoReplyVO vo) {
		log.info("modify -> "+vo);
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long vrno) {
		log.info("remove -> "+vrno);
		
		VideoReplyVO vo= mapper.read(vrno);
		return mapper.delete(vrno);
	}

	@Override
	public List<VideoReplyVO> getList(Criteria cri, Long vno) {
		log.info("get Reply List of a Board -> "+vno);
		return mapper.getListWithPaging(cri,vno);
	}

	@Override
	public VideoReplyPageDTO getListPage(Criteria cri, Long vno) {
		
		return new VideoReplyPageDTO(
				mapper.getCountByVno(vno),
				mapper.getListWithPaging(cri, vno));
	}

	

}
