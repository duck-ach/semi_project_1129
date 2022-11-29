package com.gdu.semi02.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class AttachDTO {
	
	private int attachNo;
	private int uploadNo;
	private String id;
	private String path;
	private String origin;
	private String filesystem;
	private int downloadCnt;
	
}
