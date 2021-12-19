package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.VideoVO;

public interface VideoService {
	
	public int getTotal(Criteria cri); // (p.322)페이징 처리를 위해 필요
	public VideoVO get(Long vno); // 페이지 이동시 페이지 유지를 위해서 필요
	public List<VideoVO>getList(Criteria cri); // (P.299)패이징 처리 된 리스트
	public int remove(Long vno);
	public int modify(VideoVO vo);
	public int write(VideoVO vo);
	
//	좋아요 싫어요 조회수
	public boolean hits(Long vno);
	public int modifyGood(VideoVO vo);
	public int modifyNoway(VideoVO vo);
	
}	
