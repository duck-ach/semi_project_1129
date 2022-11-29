package com.gdu.semi02.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class AdminDTO {
	
	   private String id;
	   private int userNo;
	   private String pw;
	   private String name;
	   private String gender;
	   private String email;
	   private String mobile;
	   private String birthyear;
	   private String birthday;
	   private String postcode;
	   private String roadAddress;
	   private String jibunAddress;
	   private String detailAddress;
	   private String extraAddress;
	   private int agreeCode;
	   private String snsType;
	   private Date joinDate;
	   private Date pwModifyDate;
	   private Date infoModifyDate;
	   private String sessionId;
	   private Date sessionLimitDate;
	   private int userLevel;
	   private int point;

}
