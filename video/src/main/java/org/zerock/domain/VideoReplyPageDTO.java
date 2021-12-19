package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class VideoReplyPageDTO {
	
	private int replyCnt;
	private List<VideoReplyVO> list;
}
