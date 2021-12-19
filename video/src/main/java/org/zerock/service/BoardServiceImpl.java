package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
//	spring 4.3 이상에서 자동 생성      됨.
	@Setter(onMethod_= @Autowired)
	private BoardMapper mapper;
	
//	게시물과 댓글 동시 삭제용.
	@Setter(onMethod_=@Autowired)
	private ReplyMapper rMapper;
	
//	seit.566 첨부파일 처리 mapper
	@Setter(onMethod_= @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
//	게시물 등록
		log.info("register....." + board);
		mapper.insertSelectKey(board);
//	첨부파일 처리 추가(seit.567)
		if(board.getAttachList()==null || board.getAttachList().size() <=0) {
			log.info("TX fail");
			return;
		}
		board.getAttachList().forEach(attach->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
			log.info(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		
		log.info("get......."+bno);
		return mapper.read(bno);
	}
	
//	(Seit.591) 첨부파일 관련 데이터를 삭제한 후에 다시 첨부파일 데이터 추가
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		
		log.info("modify..........."+board);
		
		attachMapper.deleteAll(board.getBno());
		
		boolean modifyResult = mapper.update(board) == 1;
		
		if(modifyResult && board.getAttachList() != null 
				&& board.getAttachList().size() >0 ) {
			
			board.getAttachList().forEach(attach ->{
				
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
//		return mapper.update(board)==1;
	}
	
//	(seit.579) 첨부파일 삭제
	@Transactional
	@Override
	public boolean remove(Long bno) {
		
		log.info("remove..........."+bno);
		
		rMapper.deleteAll(bno);
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno)==1;
	}

//	@Override
//	public List<BoardVO> getList() {
//		log.info("get List..........");
//		return mapper.getList();
//	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		System.out.println("리스트 확인:"+cri);
//		log.info("get List with criteria: "+cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

//	(Seit.569) findByBno 호출 및 반환
	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		
		log.info("get Attach List by Bno"+bno);
		
		return attachMapper.findByBno(bno);
	}

}
