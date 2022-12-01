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
public class GalleryCommDTO {
	private int galleryCommNo;
	private long galleryNo;
	private String id;
	private String commUserIp;
	private String commContent;
	private int commState;
	private int commDepth;
	private int commGroupNo;
	private Date commDate;
}
