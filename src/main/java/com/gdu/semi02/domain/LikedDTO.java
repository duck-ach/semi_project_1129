package com.gdu.semi02.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class LikedDTO {
	int galleryNo;
    int isLiked;
    String id;
}
