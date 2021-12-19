package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board); // 등 록
	public BoardVO get(Long bno);		 // 조회
	public boolean modify(BoardVO board);// 수정
	public boolean remove(Long bno);	 // 삭제
	public int getTotal(Criteria cri);   // 총 게시글 수(페이지 용)
	public List<BoardVO> getList(Criteria cri); // 리스트(페이징 처리 후)
	
	public List<BoardAttachVO> getAttachList(Long bno); // 첨부파일	


}
