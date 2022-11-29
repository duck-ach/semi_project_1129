package com.gdu.semi02.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class SummernoteImageDTO {
   private int blogNo;
   private String path;
   private String filesystem;
}