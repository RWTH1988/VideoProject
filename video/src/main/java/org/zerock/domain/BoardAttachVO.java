package org.zerock.domain;

import lombok.Data;

@Data
public class BoardAttachVO {
	
	private String uuid;        // UUID가 포함된 이름
	private String uploadPath;  // 실제 파일 업로드 경로
	private String fileName;    // 파일 이름
	private boolean fileType;   // 파일 타입(이미지,일반파일...)
	
	private Long bno;			// 게시물 번호
}
