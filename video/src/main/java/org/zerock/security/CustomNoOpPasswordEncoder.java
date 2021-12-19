package org.zerock.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder {
//	(S.647~8) PasswordEncoder : 로그인 시 비밀번호 인코딩
	
	@Override
	public String encode(CharSequence rawPassword) {
		
		log.warn("Before encode: "+ rawPassword);
		
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {

		log.warn("Matches: "+ rawPassword + ":" + encodedPassword);
		
		return rawPassword.toString().equals(encodedPassword);
	}

}
