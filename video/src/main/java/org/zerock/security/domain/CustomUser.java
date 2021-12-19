package org.zerock.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.zerock.domain.MemberVO;

import lombok.Getter;

// (S.668~9) MemberVO를 UsersDetails 타입으로 변환하기!

@Getter
public class CustomUser extends User{
	
	private static final long serialVersionUID = 1L;
	
	private MemberVO member;
	
	public CustomUser(String username, String password, 
			Collection<? extends GrantedAuthority> authorities) {
		
		super(username, password, authorities);
	}
	
//	MemeberVO를 파라미터로 전달해서 User클래스에 맞게 생성자 호출
//	.stream() 과 .map() 사용
//	.stream() : stream을 이용하면 컬렉션이나 배열의 원소를 람다함수형식으로 처리 가능.
//	.map() : 요소들을 특정 조건에 해당하는 값으로 변경 (z.B]소문자인 요소를 대문자로 변경)
//			 collect(Collectors.toList())를 이용하여 변환 된 값을 리스트형식으로 받음.
	public CustomUser(MemberVO vo) { 
		
		super(vo.getUserid(), vo.getUserpw(), 
				vo.getAuthList().stream()
				.map(auth->new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		
		this.member = vo;
	}
}
