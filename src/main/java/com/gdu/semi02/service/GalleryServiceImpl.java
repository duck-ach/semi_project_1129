package com.gdu.semi02.service;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi02.domain.GalleryDTO;
import com.gdu.semi02.domain.LikedDTO;
import com.gdu.semi02.domain.SummernoteImageDTO;
import com.gdu.semi02.domain.UserDTO;
import com.gdu.semi02.mapper.GalleryMapper;
import com.gdu.semi02.util.GalleryPageUtil;
import com.gdu.semi02.util.MyFileUtil;

@Service
public class GalleryServiceImpl implements GalleryService {

	@Autowired
	private GalleryMapper galleryMapper;
	@Autowired
	private MyFileUtil myFileUtil;
	@Autowired
	private GalleryPageUtil galleryPageUtil;

	@Override
	public void getGalleryList(HttpServletRequest request, Model model) {

		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));

		int totalRecord = galleryMapper.selectGalleryListCnt();

		galleryPageUtil.setPageUtil(page, totalRecord);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", galleryPageUtil.getBegin());
		map.put("end", galleryPageUtil.getEnd());

		List<GalleryDTO> galleryList = galleryMapper.selectGalleryList(map);

		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("beginNo", totalRecord - (page - 1) * galleryPageUtil.getRecordPerPage());
		model.addAttribute("galleryList", galleryList);
		model.addAttribute("paging", galleryPageUtil.getPaging(request.getContextPath() + "/gallery/list"));

	}

	@Transactional
	@Override
	public void saveGallery(HttpServletRequest request, HttpServletResponse response) {
		String gallerytitle = request.getParameter("title");
		String GalleryContent = request.getParameter("content");
		Optional<String> opt = Optional.ofNullable(request.getHeader("X-Forwarded-For"));
		String ip = opt.orElse(request.getRemoteAddr());

		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

		GalleryDTO gallery = GalleryDTO.builder().galleryTitle(gallerytitle).galleryContent(GalleryContent).writerIp(ip)
				.id(loginUser.getId()).build();

		// DB에 Gallery 저장
		int result = galleryMapper.insertGallery(gallery);

		// 응답
		try {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script>");
			if (result > 0) {

				// 파라미터 summernoteImageNames
				String[] summernoteImageNames = request.getParameterValues("summernoteImageNames");

				// DB에 SummernoteImage 저장
				if (summernoteImageNames != null) {
					for (String filesystem : summernoteImageNames) {
						SummernoteImageDTO summernoteImage = SummernoteImageDTO.builder()
								.galleryNo(gallery.getGalleryNo()).filesystem(filesystem).build();
						galleryMapper.insertSummernoteImage(summernoteImage);
					}
				}

				out.println("alert('삽입 성공');");
				out.println("location.href='" + request.getContextPath() + "/gallery/list';");
			} else {
				out.println("alert('삽입 실패');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest,
			HttpServletResponse response) {
		// 파라미터 file 꺼내기 (파일을 꺼내는 건 getParameter 하면 안됨)
		MultipartFile multipartFile = multipartRequest.getFile("file");

		// 저장 경로 (separator : 경로 구분자) 윈도우만 쓰려고할 때는 C:\\upload
		String path = "C:" + File.separator + "summernoteImage";

		// 저장할 파일 이름
		String filesystem = myFileUtil.getFilename(multipartFile.getOriginalFilename());

		// 저장 경로가 없으면 만들기
		File dir = new File(path);
		if (dir.exists() == false) {
			dir.mkdirs();
		}

		// 저장할 File 객체
		File file = new File(dir, filesystem); // new File(dir, filesystem)도 가능

		// HDD에 File 객체 저장하기
		try {
			multipartFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 갤러리 이미지 필수
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			if (multipartFile != null && multipartFile.isEmpty() == false) {
			out.println("<script>");
				out.println("alert('삽입 실패');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 포인트 업데이트
		HttpSession session = multipartRequest.getSession();
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		loginUser.setPoint(galleryMapper.updateUserPoint(loginUser.getUserNo()));

		// 저장된 파일을 확인할 수 있는 매핑을 반환
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("src", multipartRequest.getContextPath() + "/load/image/" + filesystem);
		return map;

		// 저장된 파일이 aaa.jpg라고 가정하면
		// src=${contextPath}/load/image/aaa.jpg 이다.

	}

	@Override
	public int increaseGalleryHit(int galleryNo) {
		return galleryMapper.updateHit(galleryNo);
	}

	@Override
	public GalleryDTO getGalleryByNo(int galleryNo) {

		// DB에서 갤러리 정보 가져오기
		GalleryDTO gallery = galleryMapper.selectGalleryByNo(galleryNo);

		// 갤러리에서 사용한 것으로 되어 있는 써머노트 이미지(저장된 파일명이 DB에 저장되어 있고, 실제로 HDD에도 저장되어 있음)
		List<SummernoteImageDTO> summernoteImageList = galleryMapper.selectSummernoteImageListInGallery(galleryNo);

		// 갤러리에서 사용한 것으로 저장되어 있으나 갤러리 내용(content)에는 없는 써머노트 이미지를 찾아서 제거
		if (summernoteImageList != null && summernoteImageList.isEmpty() == false) {
			for (SummernoteImageDTO summernoteImage : summernoteImageList) {
				if (gallery.getGalleryContent().contains(summernoteImage.getFilesystem()) == false) {
					File file = new File("C:" + File.separator + "summernoteImage", summernoteImage.getFilesystem());
					if (file.exists()) {
						file.delete();
					}
				}
			}
		}

		// 갤러리 반환
		return gallery;
	}

	@Transactional
	@Override
	public void modifyGallery(HttpServletRequest request, HttpServletResponse response) {

		// 파라미터 title, content, galleryNo
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int galleryNo = Integer.parseInt(request.getParameter("galleryNo"));

		// DB로 보낼 GalleryDTO
		GalleryDTO gallery = GalleryDTO.builder().galleryTitle(title).galleryContent(content).galleryNo(galleryNo)
				.build();

		// DB 수정
		int result = galleryMapper.updateGallery(gallery);

		// 응답
		try {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script>");
			if (result > 0) {

				// 파라미터 summernoteImageNames
				String[] summernoteImageNames = request.getParameterValues("summernoteImageNames");

				// DB에 SummernoteImage 저장
				if (summernoteImageNames != null) {
					for (String filesystem : summernoteImageNames) {
						SummernoteImageDTO summernoteImage = SummernoteImageDTO.builder()
								.galleryNo(gallery.getGalleryNo()).filesystem(filesystem).build();
						galleryMapper.insertSummernoteImage(summernoteImage);
					}
				}

				out.println("alert('수정 성공');");
				out.println(
						"location.href='" + request.getContextPath() + "/gallery/detail?galleryNo=" + galleryNo + "';");
			} else {
				out.println("alert('수정 실패');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void removeGallery(HttpServletRequest request, HttpServletResponse response) {
		// 파라미터
		int galleryNo = Integer.parseInt(request.getParameter("galleryNo"));

		// HDD에서 삭제해야 하는 SummernoteImage 리스트
		List<SummernoteImageDTO> summernoteImageList = galleryMapper.selectSummernoteImageListInGallery(galleryNo);

		// DB에서 삭제
		int result = galleryMapper.deleteGallery(galleryNo);

		// 응답
		try {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script>");
			if (result > 0) {

				// HDD에서 SummernoteImage 리스트 삭제
				if (summernoteImageList != null && summernoteImageList.isEmpty() == false) {
					for (SummernoteImageDTO summernoteImage : summernoteImageList) {
						File file = new File("C:" + File.separator + "summernoteImage",
								summernoteImage.getFilesystem());
						if (file.exists()) {
							file.delete();
						}
					}
				}

				out.println("alert('삭제 성공');");

				HttpSession session = request.getSession();
				UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
				galleryMapper.cancelUserPoint(loginUser.getUserNo());
				loginUser.setPoint(loginUser.getPoint() - 5);

				out.println("location.href='" + request.getContextPath() + "/gallery/list';");
			} else {
				out.println("alert('삭제 실패');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	@Override
	public Map<String, Object> getLikedUser(LikedDTO liked) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("likeUser", galleryMapper.selectLikedCnt(liked) == 1);
		return result;
	}

	
//	@Override
//	public Map<String, Object> getLiked(map) {
//		
//		return 0;
//	}

}