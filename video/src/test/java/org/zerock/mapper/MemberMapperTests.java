package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTests {

	@Autowired
	private MemberMapper mapper;
	
	@Test
	public void testGet() {
		
		MemberVO member = mapper.get("test1");
		
		log.info(member);
	}
	
//	@Test
	public void testModify() {
				
		MemberVO member = new MemberVO();
		
		member.setUserid("test1");
		member.setUserpw("test1");		
		member.setUserBirth("19881002");
		member.setUserTel("01095947737");
		member.setUserEmail("1234@naver.com");
		member.setPostcode("52074");
		member.setJibunAddr("552번지");
		member.setRoadAddr("밀양대로 1755");
		member.setDetailAddr("101");
		
		int count = mapper.modify(member);
		log.info("수정 성공 1 출력 : "+count);		
	}
	
	
	
}
