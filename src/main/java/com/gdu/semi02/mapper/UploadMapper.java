package com.gdu.semi02.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi02.domain.AttachDTO;
import com.gdu.semi02.domain.UploadDTO;

@Mapper
public interface UploadMapper {
	// 목록조회
	public List<UploadDTO> selectUploadListByPage(Map<String, Object> map);
	public int selectAllUploadListCnt();
	// 게시글 삽입
	public int insertUpload(UploadDTO upload);
	public int insertAttach(AttachDTO attach);
	// 상세보기
	public UploadDTO selectUploadByNo(int uploadNo);
	public List<AttachDTO> selectAttachList(int attachNo);
	public int updateHit(int uploadNo);
	// 다운로드
	public AttachDTO selectAttachByNo(int attachNo);
	public int updateDownloadCnt(int attachNo);
	// 게시글 편집
	public int updateUpload(UploadDTO upload);
	// 게시글 삭제
	public int deleteUpload(int uploadNo);
	// 첨부파일 삭제
	public int deleteAttach(int attachNo);
}
