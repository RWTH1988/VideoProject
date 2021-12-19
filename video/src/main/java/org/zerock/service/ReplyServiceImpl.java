package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
//@AllArgsConstructor : spring 4.3의 생성자와 자동주입 이용하는 방법.
public class ReplyServiceImpl implements ReplyService{
	
//	private ReplyMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
//	(Seit.484) 반정규화 처리로인한 BoardMapper 추가
	@Setter(onMethod_=@Autowired)
	private BoardMapper boardMapper;
	
//	(S.485) 댓글 갯수 업데이트 트랜젝션 설정
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register........."+ vo);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get..........." + rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify............"+ vo);
		
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		
		log.info("remove..........."+ rno);
		
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		log.info("get Reply List of a Board" + bno);
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
//		ReplyPageDTO reply = 
//				new ReplyPageDTO(mapper.getCountByBno(bno), 
//								 mapper.getListWithPaging(cri, bno));//		
//		return reply;
		
		return new ReplyPageDTO(
					mapper.getCountByBno(bno), 
					mapper.getListWithPaging(cri, bno));
	}

}
