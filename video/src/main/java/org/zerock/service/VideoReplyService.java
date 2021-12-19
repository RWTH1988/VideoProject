package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.VideoReplyPageDTO;
import org.zerock.domain.VideoReplyVO;

public interface VideoReplyService {
	
	public int register(VideoReplyVO vo);
	public VideoReplyVO get(Long vrno);
	public int modify(VideoReplyVO vo);
	public int remove(Long vrno);
	public List<VideoReplyVO> getList(Criteria cri,Long vno);
	
	public VideoReplyPageDTO getListPage(Criteria cri,Long vno);
}
