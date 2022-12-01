package com.gdu.semi02.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi02.domain.GalleryDTO;
import com.gdu.semi02.domain.SummernoteImageDTO;

@Mapper
public interface GalleryMapper {
	// list
	public int selectGalleryListCnt();
	public List<GalleryDTO> selectGalleryList(Map<String, Object> map);
	public List<SummernoteImageDTO> selectSummernoteImageListInGallery(int galleryNo);
	public List<SummernoteImageDTO> selectAllSummernoteImageList();
	// insert
	public int insertGallery(GalleryDTO gallery);
	public int insertSummernoteImage(SummernoteImageDTO summernote);
	public int updateUserPoint(int userNo);
	
	// detail
	public GalleryDTO selectGalleryByNo(int galleryNo);
	public int updateHit(int galleryNo);
	
	// update
	public int updateGallery(GalleryDTO gallery);
	
	// delete
	public int deleteGallery(int galleryNo);
	public int cancelUserPoint(int userNo);
	
	// liked
	public

}
