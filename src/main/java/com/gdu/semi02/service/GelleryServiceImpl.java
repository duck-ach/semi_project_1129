package com.gdu.semi02.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.semi02.mapper.GalleryMapper;

@Service
public class GelleryServiceImpl implements GalleryService {

	@Autowired
	private GalleryMapper galleryMapper;
}
