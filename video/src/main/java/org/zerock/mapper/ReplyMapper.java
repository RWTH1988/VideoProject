package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insert(ReplyVO vo); // 댓글 등록(create)
	public ReplyVO read(Long rno); // 댓글 조회(read)
	public int delete(Long rno);   // 댓글 삭제(delete)
	public int update(ReplyVO vo); // 댓글 업뎃(update)
	public int deleteAll(Long bno); // 게시물 삭제시 댓글 동시 삭제
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri ,@Param("bno") Long bno);
	
	public int getCountByBno(Long bno); // 게시물의 전체 댓글 숫자
	
}
