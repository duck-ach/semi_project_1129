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
public class UploadCommDTO {
	private int uploadCommNo;
	private int uploadNo;
	private String id;
	private String commContent;
	private Date commDate;
	private int state;
	private int depth;
	private int groupNo;
}
