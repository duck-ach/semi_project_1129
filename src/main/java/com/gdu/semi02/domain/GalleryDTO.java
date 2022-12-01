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
public class GalleryDTO {
		private int galleryNo;
		private String galleryTitle;
		private String galleryContent;
		private Date createDate;
		private Date modifyDate;
		private int hit;
		private String writerIp;
		private String id;

}
