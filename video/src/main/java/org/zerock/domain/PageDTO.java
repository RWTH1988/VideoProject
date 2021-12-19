package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		
		this.cri = cri;
		this.total = total;
		
//		page번호가 10개씩 보인다고 가정
//		마지막 페이지
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
//		시작 페이지
		this.startPage = this.endPage-9;
//		실제 마지막 페이지
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
//		이전 페이지 버튼
		this.prev = this.startPage > 1;
//		다음 페이지 버튼
		this.next = this.endPage < realEnd;
	}
}
