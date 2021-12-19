package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;

import org.zerock.domain.VideoVO;

public interface VideoMapper {
	
	// DML 부분
	public VideoVO read(Long vrno); // 조회(read)	
	public List<VideoVO> getListWithPaging(Criteria cri);	
	public int getTotalCount(Criteria cri);
	public int insert(VideoVO vo);
	public int update(VideoVO vo);	
	public int delete(Long vrno);	

	// 좋아요 싫어요 조회수
	public boolean hits(Long vno);
	public int good(VideoVO vo);
	public int noway(VideoVO vo);
	
}
