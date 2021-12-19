package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;


@Data
public class VideoVO {
	
	private Long vno;
	private String url;
	private String category; // 카테고리
	private String content;
	private String title;
	private Date regDate;
	private int hits;
	
	private int good;
	private int noway;
}