package com.gdu.semi02.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi02.domain.BbsCommDTO;

@Mapper
public interface BbsCommMapper {

	public int selectBbsCommentCount(int bbsNo);
	public int insertBbsComment(BbsCommDTO bbsComm);
	public List<BbsCommDTO> selectBbsCountList(Map<String, Object> map);
	public int deleteBbsComment(int bbsCommNo);
	public int insertReply(BbsCommDTO reply);
}
