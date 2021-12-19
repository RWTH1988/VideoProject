package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid); 	// 로그인
	
	public void join(MemberVO member);	 	//회원가입
	public void joinAuth(String userid); 	//권한부여
	
	public MemberVO get(String userid);  	//회원정보보기
	public int modify(MemberVO member);	 	//정보수정	
	
	public int delete(String userid);    	//회원탈퇴
	public int deleteAuth(String userid);	//권한삭제
	
	public int passCheck(MemberVO member);  //비번 체크
	public int idCheck(MemberVO member);	//아이디 체크
	
	public List<MemberVO> getListWithPaging(Criteria cri); // 회원목록조회
	public int getTotalCount(Criteria cri); // 총 회원 수
}
