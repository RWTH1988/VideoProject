package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper;	
	
	// 권한 부여 부분. (P.485) 참조
	@Transactional // 실패함
	@Override
	public void join(MemberVO member) {

		log.info("join ...."+ member);
		
		mapper.join(member);
		mapper.joinAuth(member.getUserid());
		
	}

	@Override
	public MemberVO read(String userid) { // 로그인 인증
		
		log.info("memberService read userid : "+userid);
		
		return mapper.read(userid);
	}

	@Override // 회원정보 불러오기
	public MemberVO get(String userid) {
		
		log.info("memberService get userid: "+userid);
		
		return mapper.get(userid);
	}

	@Override // 회원정보 수정
	public boolean modify(MemberVO member) {
		
		log.info("memberService modify userid: "+ member.getUserid());
				
		boolean modifyResult = mapper.modify(member) == 1;
		
		return modifyResult;
	}
	
	@Transactional
	@Override // 회원 탈퇴
	public boolean remove(String userid) {
		
		log.info("memberService remove userid: "+ userid);
		
		mapper.deleteAuth(userid);		
		boolean removeResult = mapper.delete(userid) == 1;
		
		return removeResult;
	}

	@Override  // 비번체크
	public int passCheck(MemberVO member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override  // 아이디 체크
	public int idCheck(MemberVO member) {
		
		log.info("idCheck:"+member);
		
		int result = mapper.idCheck(member);
		
		return result;
	}
	
////////////////관리자 관련 부분/////////////////////
	
	@Override
	public List<MemberVO> getList(Criteria cri) {
		System.out.println("리스트 확인:"+cri);
//		log.info("get List with criteria: "+cri);
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	
	
}
