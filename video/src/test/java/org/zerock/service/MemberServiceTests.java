package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberServiceTests {

	@Setter(onMethod_=@Autowired)
	private MemberService service;
	
	@Test
	public void testExist() {
		
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testGet() {
		
		log.info("sevice get 테스트: "+service.get("test1"));
	}
	
	@Test
	public void testModify() {
		
		MemberVO vo = service.get("test1");
		
		if(vo!=null) {
			
			vo.setUserpw("test1234");
			log.info("비밀번호를 수정합니다."+service.modify(vo));
			
		}else {return;}		
				
	}
	
}
