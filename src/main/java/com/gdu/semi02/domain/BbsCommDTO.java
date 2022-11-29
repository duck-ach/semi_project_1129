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
public class BbsCommDTO {
	private int bbsCommNo;
	private int bbsNo;
	private String commContent;
	private String commIp;
	private Date commCreateDate;
	private int state;
	private int depth;
	private int groupNo;
	
}
