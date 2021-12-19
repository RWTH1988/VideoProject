package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	
//	public List<BoardVO> getList();	
//	@Param("cri") 사용시 : not found parameter 에러 발생!!
//	public List<BoardVO> getListWithPaging(@Param("cri") Criteria cri);
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int insert(BoardVO vo);
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno); // 조회(read)
	public int delete(Long bno);   // 삭제
	public int update(BoardVO vo); // 수정	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
		
}
