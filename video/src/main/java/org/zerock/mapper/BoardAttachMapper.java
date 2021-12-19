package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(Long bno);
	
	public void deleteAll(Long bno); // seit.578 첨부파일 삭제
	
	public List<BoardAttachVO> getOldFiles(); // seit.600 오래된 파일 자동 체크
}
