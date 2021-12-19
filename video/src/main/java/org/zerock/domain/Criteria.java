package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//@Data : 사용하지 않은 이유는 생성자 자동생성을 피해서 생성자를 커스텀으로 만들기 위해서
//@AllArgsConstuctor
@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum; // 현재 페이지 숫자
	private int amount;  // 한 페이지에 나타나는 총 페이지 숫자(z.B] 1~10페이지=amount 10 / 1~5페이지=amount 5)
	
	private String type; // = T,C,W
	private String keyword; // 검색어
	
	public Criteria() {
		this(1,10);
//		this.pageNum = 1;
//		this.amount = 10;
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {  // 'T'/'C'/'W' 의 값이 들어감.
		
		return type == null ? new String[] {} : type.split("");
	}
	
	public String getListLink() {
//		UriComponentsBuilder : 여러개의 파라미터들을 연결해 URL의 형태로 만들어준다. 
//							   BoardController에서 rttr(RedirectAttribute)를 따로 설정 해줄 필요 없어 진다.
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
/*				위와 동일, 본인이 본인 정보를 사용하기 때문에 get/set 필요 없다.
 				.queryParam("pageNum", pageNum)
				.queryParam("amount", amount)
				.queryParam("type", type)
				.queryParam("keyword", keyword);
	(seit.580) 게시물의 삭제 후에 페이지 번호나 검색 조건을 유지하기 위한 redirect파라미터 유지.		
 */
		
		return builder.toUriString();
	}
	
}
