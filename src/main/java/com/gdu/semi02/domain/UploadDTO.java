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
public class UploadDTO {
	private int uploadNo;
	private String id;
	private String uploadTitle;
	private String uploadContent;
	private Date createDate;
	private Date modifyDate;
	private int hit;
	private String uploadUserIp;
}
