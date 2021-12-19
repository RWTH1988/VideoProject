package org.zerock.mapper;

import java.util.List;
import org.zerock.domain.Criteria;

import org.zerock.domain.VideoVO;

public interface MainMapper {
	
	public VideoVO read(Long vno); // 조회(read)
	
	public int getTotalCount(Criteria cri);
	
	public List<VideoVO> getCate();

	public List<VideoVO> getMainList(VideoVO vo);
}
