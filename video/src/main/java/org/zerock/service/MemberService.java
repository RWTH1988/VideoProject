package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;

public interface MemberService {
	
	public MemberVO read(String userid);      //로그인 체크
	public void join(MemberVO member);        //회원가입
	
	public MemberVO get(String userid);	      //정보조회
	public boolean modify(MemberVO member);   //정보수정
	public boolean remove(String userid);     //탈퇴
	
	public int passCheck(MemberVO member);    // 비번 체크
	public int idCheck(MemberVO member);      // 아이디 체크
	
	public List<MemberVO> getList(Criteria cri); // 멤버 리스트(페이징 처리 후)
	public int getTotal(Criteria cri);           // 총 멤버 수(페이지 용)
	
	
	
		

}
