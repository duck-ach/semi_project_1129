package com.gdu.semi02.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class BbsDTO {
	private int bbsNo;
	private String bbsTitle;
	private String bbsContent;
	private String bbsIp;
	private Date bbsCreateDate;
	private int bbsHit;
	
}
