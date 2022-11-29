package com.gdu.semi02.mapper;

import java.util.List;
import java.util.Map;

import com.gdu.semi02.domain.UploadCommDTO;

public interface UploadCommMapper {
	public int selectCommentCount(int BlogNo);
	public int insertComment(UploadCommDTO comment);
	public List<UploadCommDTO> selectCommentList(Map<String, Object> map); // blogNo, begin, end 세개를 전달해야 하므로
	public int deleteComment(int commentNo);
	public int insertReply(UploadCommDTO reply);
}
