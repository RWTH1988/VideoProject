package org.zerock.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler 
implements AuthenticationSuccessHandler {
/* (S.637~8) AuthenticationSuccessHandler
	로그인 성공 이후에 특정한 동작을 하도록 제어.
	z.B] 1.관리자 계정으로 로그인 했다면 어떤 경로로 로그인 페이지로 접속하건 무조건 정해진 URI로 이동 시키기.
		 2.별도의 쿠키 등을 생성해서 처리하기.
*/
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		
		log.warn("로그인 성공");
		
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(authority ->{
			
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("ROLE NAME: "+roleNames);
		
		if(roleNames.contains("ROLE_ADMIN")) {
			
			response.sendRedirect("/sample/admin");
			return;
		}
		
		if(roleNames.contains("ROLE_MEMBER")) {
			
			response.sendRedirect("/sample/member");
			return;
		}
		
		response.sendRedirect("/");
		
	}
}
