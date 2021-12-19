package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.VideoReplyVO;

public interface VideoReplyMapper {

	public int insert(VideoReplyVO vo);
	
	public VideoReplyVO read(Long vrno);
	
	public int delete (Long vrno);
	
	public int update(VideoReplyVO reply);
	
	public List<VideoReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("vno") Long vno);
	
	public int getCountByVno(Long vno);
}
