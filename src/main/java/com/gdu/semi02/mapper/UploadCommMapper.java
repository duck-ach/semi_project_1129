package com.gdu.semi02.mapper;

import java.util.List;
import java.util.Map;

import com.gdu.semi02.domain.UploadCommDTO;

public interface UploadCommMapper {
	public int selectCommentCount(int BlogNo);
	public int insertComment(UploadCommDTO comment);
	public List<UploadCommDTO> selectCommentList(Map<String, Object> map);
	public int deleteComment(int commentNo);
	public int insertReply(UploadCommDTO reply);
}
