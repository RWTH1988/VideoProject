package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userid;		//아이디
	private String userpw;		//비밀번호
	private String userName;	//이름				
	private Date regDate;		//가입일
	private Date updateDate;	//수정일
	private String userGender;	//성별
	private String userTel;		//휴대전화
	private String userBirth;	//생일
	private String userEmail;	//이메일
	private String postcode;	//우편번호
	private String roadAddr;	//도로주소
	private String jibunAddr;	//지번주소
	private String detailAddr;	//상세주소
	private boolean enabled;	//??	
	
	private List<AuthVO> authList;

}
