package com.gdu.semi02.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@Configuration
public class UploadFileConfig {
	
	@Bean // 파일 첨부할 때 이거 넣어주어야 함
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setDefaultEncoding("UTF-8");					// 파일 인코딩
		multipartResolver.setMaxUploadSizePerFile(1024 * 1024 * 10);	// 파일 하나당 최대 10MB
		multipartResolver.setMaxUploadSize(1024 * 1024 * 100);			// 전체 파일 최대 100MB
		return multipartResolver;
	}
	
}
