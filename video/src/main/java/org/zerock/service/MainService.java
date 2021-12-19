package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.VideoVO;

public interface MainService {
	
	public int getTotal(Criteria cri);
	
	public VideoVO get(Long vno); // 페이지 이동시 페이지 유지를 위해서 필요

	public List<VideoVO> getCate();
	
	public List<VideoVO> getMainList(VideoVO vo);
	
	
}	
