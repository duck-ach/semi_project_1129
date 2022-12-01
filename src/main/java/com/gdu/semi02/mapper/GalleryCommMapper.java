package com.gdu.semi02.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi02.domain.GalleryCommDTO;

@Mapper
public interface GalleryCommMapper {
	public int selectCommentCnt(int galleryNo);
	public int insertComment(GalleryCommDTO comment);
	public List<GalleryCommDTO> selectCommentList(Map<String, Object> map);
	public int deleteComment(int commentNo);
	public int insertReply(GalleryCommDTO reply);
}