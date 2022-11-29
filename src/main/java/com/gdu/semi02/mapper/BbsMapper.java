package com.gdu.semi02.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi02.domain.BbsDTO;

@Mapper
public interface BbsMapper {

	public int selectAllBbsCount();
	public List<BbsDTO> selectAllBbsList(Map<String, Object> map);
	public int insertBbs(BbsDTO bbs);
	public int updateHit(int bbsNo);
	public BbsDTO selectBbsByNo(int bbsNo);
	public int updateBbs(BbsDTO bbs);
	public int deleteBbs(int bbsNo);
}
