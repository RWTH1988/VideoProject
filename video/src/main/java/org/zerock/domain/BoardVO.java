package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardVO {
	
	private Long bno;
	private String title;
	private String content;
	private String writer;	
	private Date regDate;
	private Date updateDate;	
	
	private int replyCnt; // 댓글 수 표시용
	
	private List<BoardAttachVO> attachList; // 첨부파일용

}
