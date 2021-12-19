package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class VideoReplyVO {
	
	private Long vrno;
	private Long vno;
	private String vreply;
	private String vreplyer;
	private Date replyDate;
	private Date updateDate;
}
