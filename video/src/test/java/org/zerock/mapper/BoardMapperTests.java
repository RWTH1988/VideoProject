package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper board;
	
	@Setter(onMethod_ = @Autowired)
	private VideoMapper video;
	
	@Test //게시글 등록 insert Test
	public void Insert() {
		
		log.info(board);
	}
	
	@Test //게시글 삭제
	public void Delete() {
		
		log.info(board);
	}
	
	@Test //수정 get
	public void modifyTest() {
		
		log.info(video);
		
	}

}
