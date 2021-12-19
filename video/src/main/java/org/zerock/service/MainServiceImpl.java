package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.VideoVO;
import org.zerock.mapper.MainMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
//@AllArgsConstructor : spring 4.3의 생성자와 자동주입 이용하는 방법.
public class MainServiceImpl implements MainService {
	
	
	
	@Setter(onMethod_ = @Autowired)
	private MainMapper mapper;
	
	@Override
	public VideoVO get(Long vno) {
		log.info("get..........." + vno);

		return mapper.read(vno);
	}

	@Override
	public List<VideoVO> getCate() {
		
		return mapper.getCate();
	}

	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public List<VideoVO> getMainList(VideoVO vo) {
		
		log.info("MainService GetMainList......");

		return mapper.getMainList(vo);
	}

	
}
