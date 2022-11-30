 package com.gdu.semi02.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi02.domain.AttachDTO;
import com.gdu.semi02.domain.UploadDTO;
import com.gdu.semi02.domain.UserDTO;
import com.gdu.semi02.mapper.UploadMapper;
import com.gdu.semi02.util.MyFileUtil;
import com.gdu.semi02.util.PageUtil;


@Service
public class UploadServiceImpl implements UploadService {

	@Autowired
	private UploadMapper uploadMapper;
	
	@Autowired
	private MyFileUtil myFileUtil;
	
	@Autowired
	private PageUtil pageUtil;
	
	@Override
	public void getUploadList(HttpServletRequest request, Model model) {
		///////////////////////// PAGE /////////////////////////
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// 전체 레코드(게시물)개수 구하기
		int totalRecord = uploadMapper.selectAllUploadListCnt();
		
		// pageUtil 계산
		pageUtil.setPageUtil(page, totalRecord);
		
		// Map 만들기(begin, end)
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		// begin~end 페이지 목록 가져오기
		List<UploadDTO> uploadList = uploadMapper.selectUploadListByPage(map);
		
		// view로 보낼 데이터
		model.addAttribute("uploadList", uploadList);
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/upload/list"));
		model.addAttribute("biginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
	}
	
	@Transactional
	@Override
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		
		
		///////////////////////// UPLOAD /////////////////////////
		
		// 파라미터
		String uploadTitle = multipartRequest.getParameter("title");
		String uploadContent = multipartRequest.getParameter("content");
		String ip = multipartRequest.getRemoteAddr();
		
		
		// Session의 User 정보
		HttpSession session = multipartRequest.getSession();
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		
		// DB로 보낼 UploadDTO
		UploadDTO upload = UploadDTO.builder()
				.uploadTitle(uploadTitle)
				.uploadContent(uploadContent)
				.uploadUserIp(ip)
				.id(loginUser.getId())
				.build();
		System.out.println(upload.toString());
		
		// DB에 UploadDTO 저장
		int uploadResult = uploadMapper.insertUpload(upload);
		
		// 첨부된 목록 파일 가져오기
		List<MultipartFile> files = multipartRequest.getFiles("files");

		// 첨부 결과
		int attachResult = 0;
		if(files.get(0).getSize() == 0) {
			attachResult = 1;
		} else { 
			attachResult = 0;
		}
		
		// 첨부된 파일 목록 순회(하나씩 저장)
		for(MultipartFile multipartFile : files) {
			try {
				// 첨부가 있는지 점검
				if(multipartFile != null && multipartFile.isEmpty() == false) {
					
					// 원래 이름
					String origin = multipartFile.getOriginalFilename();
					origin = origin.substring(origin.lastIndexOf("\\") + 1); // 역슬래쉬(\) 하나. IE(인터넷 익스플로러)는 origin에 전체 경로가 붙어서 파일명만 사용해야 함
					
					// 저장할 이름
					String filesystem = myFileUtil.getFilename(origin);
					
					// 저장할 경로
					String path = myFileUtil.getTodayPath();
					
					// 저장할 경로 만들기
					File dir = new File(path);
					if(dir.exists() == false) { // s안쓰면 오류남
						dir.mkdirs();
					}
					
					// 첨부할 File 객체
					File file = new File(dir, filesystem); // 경로, 파일의 이름
					
					// 첨부파일 서버에 저장(업로드 진행)
					multipartFile.transferTo(file);
					// AttachDTO 생성
					
					AttachDTO attach = AttachDTO.builder()
							.path(path)						// 경로
							.origin(origin) 				// 원래이름
							.id(loginUser.getId())
							.filesystem(filesystem)			// 바뀐 이름
							.uploadNo(upload.getUploadNo()) // 업로드 번호(DB에서 가져옴)
							.build();
					
					// DB에 AttachDTO 저장
					attachResult += uploadMapper.insertAttach(attach); // 누적(첨부된 개수와 attachResult와 같은지 비교하면 몇개의 첨부가 성공했는지 알 수 있다.)
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(uploadResult > 0 || attachResult == files.size()) { // files는 첨부된 모든 애들 (list는 size가 개수)
				out.println("<script>");
				out.println("alert('업로드가 성공적으로 수행되었습니다.');");
				out.println("location.href='" + multipartRequest.getContextPath() + "/upload/detail?uploadNo=" + upload.getUploadNo() + "';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('업로드가 실패했습니다. 다시 시도해 주세요.');");
				out.println("'history.back();'");
				out.println("</script>");
			}
			
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void getUploadByNo(int uploadNo, Model model) {
		model.addAttribute("upload", uploadMapper.selectUploadByNo(uploadNo));
		model.addAttribute("attachList", uploadMapper.selectAttachList(uploadNo));
	}
	
	@Override
	public int increaseUploadHit(int uploadNo) {
		return uploadMapper.updateHit(uploadNo);
	}
	
	@Override // ResponseEntity는 페이지변화 X, 값 반환 (보통 ajax에서 많이 사용함)
	public ResponseEntity<Resource> download(String userAgent, int attachNo) {
		
		// 다운로드 할 첨부 파일의 정보(경로, 이름)
		AttachDTO attach = uploadMapper.selectAttachByNo(attachNo);
		File file = new File(attach.getPath(), attach.getFilesystem()); // (경로, 파일명) 원래이름은 DB에만있음
		
		// 반환할 Resource
		Resource resource = new FileSystemResource(file);
		
		// Resource가 없으면 종료 (다운로드 할 파일이 없음)
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND); // '못찾겠다~' 만 간단히 반환한것
		}
		
		// 다운로드 횟수 증가
		uploadMapper.updateDownloadCnt(attachNo);
		
		// 다운로드 되는 파일명(브라우저 마다 다르게 세팅)
		String origin = attach.getOrigin();
		try {
			// UserAgent 값을 꺼내면 어떤 브라우저에서 접속했는 지 알 수 있다.
			// IE (userAgent에 "Trident"가 포함되어 있음)
			if(userAgent.contains("Trident")) { // replaceAll 뒤의 +는 정규식이기 때문에 인식시키기 위해 \\를 붙여주어야한다.
				origin = URLEncoder.encode(origin, "UTF-8").replaceAll("\\+", " ");
			}
			// Edge (userAgent에 "Edg"가 포함되어 있음)
			else if (userAgent.contains("Edg")) {
				origin = URLEncoder.encode(origin, "UTF-8");
			}
			// 나머지
			else {
				origin = new String(origin.getBytes("UTF-8"), "ISO-8859-1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 다운로드 헤더 만들기(spring framework)
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Disposition", "attachment; filename=" + origin); // attach만 하고 끝내도 됨(하지만 다운로드 이름 정해주어야 함)
		header.add("Content-Length", file.length() + "");
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}
	
	
	@Override
	public ResponseEntity<Resource> downloadAll(String userAgent, int uploadNo) {
		
		// storage/temp 디렉터리에 임시 zip 파일을 만든 뒤 이를 다운로드 받을 수 있음
		// com.gdu.app14.batch.DeleteTmpFiles에 의해서 storage/temp 디렉터리의 임시 zip 파일은 주기적으로 삭제됨
		
		// 다운로드 할 첨부 파일들의 정보(경로, 이름)
		List<AttachDTO> attachList = uploadMapper.selectAttachList(uploadNo);
		
		// zip 파일을 만들기 위한 스트림
		FileOutputStream fout = null;
		ZipOutputStream zout = null;   // zip 파일 생성 스트림
		FileInputStream fin = null;
		
		// storage/temp 디렉터리에 zip 파일 생성
		String tmpPath = "storage" + File.separator + "temp";
		
		File tmpDir = new File(tmpPath);
		if(tmpDir.exists() == false) {
			tmpDir.mkdirs();
		}
		
		// zip 파일명은 타임스탬프 값으로 생성
		String tmpName =  System.currentTimeMillis() + ".zip";
		
		try {
			
			fout = new FileOutputStream(new File(tmpPath, tmpName));
			zout = new ZipOutputStream(fout);
			
			// 첨부가 있는지 확인
			if(attachList != null && attachList.isEmpty() == false) {

				// 첨부 파일 하나씩 순회
				for(AttachDTO attach : attachList) {
					
					// zip 파일에 첨부 파일 추가
					ZipEntry zipEntry = new ZipEntry(attach.getOrigin());
					zout.putNextEntry(zipEntry);
					
					fin = new FileInputStream(new File(attach.getPath(), attach.getFilesystem()));
					byte[] buffer = new byte[1024];
					int length;
					while((length = fin.read(buffer)) != -1){
						zout.write(buffer, 0, length);
					}
					zout.closeEntry();
					fin.close();

					// 각 첨부 파일 모두 다운로드 횟수 증가
					uploadMapper.updateDownloadCnt(attach.getAttachNo());
				}
				
				zout.close();

			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		
		// 반환할 Resource
		File file = new File(tmpPath, tmpName);
		Resource resource = new FileSystemResource(file);
		
		// Resource가 없으면 종료 (다운로드할 파일이 없음)
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		// 다운로드 헤더 만들기
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Disposition", "attachment; filename=" + tmpName);  // 다운로드할 zip파일명은 타임스탬프로 만든 이름을 그대로 사용
		header.add("Content-Length", file.length() + "");
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
		
	}
	
	@Transactional
	@Override
	public void modifyUpload(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		
		/*  UPLOAD 테이블 수정하기 */
		
		// 파라미터
		int uploadNo = Integer.parseInt(multipartRequest.getParameter("uploadNo"));
		String title = multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content");
		
		// DB로 보낼 UploadDTO
		UploadDTO upload = UploadDTO.builder()
				.uploadNo(uploadNo)
				.uploadTitle(title)
				.uploadContent(content)
				.build();
		
		// DB 수정
		int uploadResult = uploadMapper.updateUpload(upload);
		
		/* ATTACH 테이블에 저장하기 */
		
		// 추가하려는 첨부 파일 목록
		List<MultipartFile> files = multipartRequest.getFiles("files");  // <input type="file" name="files">

		// 첨부 결과
		int attachResult;
		if(files.get(0).getSize() == 0) {  // 첨부가 없는 경우 (files 리스트에 [MultipartFile[field="files", filename=, contentType=application/octet-stream, size=0]] 이렇게 저장되어 있어서 files.size()가 1이다.
			attachResult = 1;
		} else {
			attachResult = 0;
		}
		
		// 첨부된 파일 목록 순회(하나씩 저장)
		for(MultipartFile multipartFile : files) {
			
			try {
				
				// 첨부가 있는지 점검
				if(multipartFile != null && multipartFile.isEmpty() == false) {  // 둘 다 필요함
					
					// 원래 이름
					String origin = multipartFile.getOriginalFilename();
					origin = origin.substring(origin.lastIndexOf("\\") + 1);  // IE는 origin에 전체 경로가 붙어서 파일명만 사용해야 함
					
					// 저장할 이름
					String filesystem = myFileUtil.getFilename(origin);
					
					// 저장할 경로
					String path = myFileUtil.getTodayPath();
					
					// 저장할 경로 만들기
					File dir = new File(path);
					if(dir.exists() == false) {
						dir.mkdirs();
					}
					
					// 첨부할 File 객체
					File file = new File(dir, filesystem);
					
					// 첨부파일 서버에 저장(업로드 진행)
					multipartFile.transferTo(file);
					
					// AttachDTO 생성
					AttachDTO attach = AttachDTO.builder()
							.path(path)
							.origin(origin)
							.filesystem(filesystem)
							.uploadNo(uploadNo)
							.build();
					
					// DB에 AttachDTO 저장
					attachResult += uploadMapper.insertAttach(attach);
					
				}
				
			} catch(Exception e) {
				
			}
			
		}  // for
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(uploadResult > 0 && attachResult == files.size()) {
				out.println("<script>");
				out.println("alert('수정 되었습니다.');");
				out.println("location.href='" + multipartRequest.getContextPath() + "/upload/detail?uploadNo=" + uploadNo + "'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('수정 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
	
	@Override
	public void removeAttachByAttachNo(int attachNo) {
		
		// 삭제할 Attach 정보 받아오기
		AttachDTO attach = uploadMapper.selectAttachByNo(attachNo); // 삭제 전에 정보를 가지고 와야함
		
		// DB에서 Attach 정보 삭제
		int result = uploadMapper.deleteAttach(attachNo);
		
		// 첨부파일 삭제
		if(result > 0) {
			// 첨부파일을 File 객체로 만듬
			File file = new File(attach.getPath(), attach.getFilesystem());
			
			// 삭제
			if(file.exists()) {
				file.delete(); // 파일 삭제
			}
		}
		
	}
	
	
	@Override
	public void removeUpload(HttpServletRequest request, HttpServletResponse response) {
		
		// 파라미터
		int uploadNo = Integer.parseInt(request.getParameter("uploadNo"));
		
		// 삭제할 Upload에 첨부된 첨부파일 목록 가져오기
		List<AttachDTO> attachList = uploadMapper.selectAttachList(uploadNo);
		
		// DB에서 Upload 정보 삭제
		int result = uploadMapper.deleteUpload(uploadNo);
		
		// 첨부 파일 삭제
		if(result > 0) {
			if(attachList != null && attachList.isEmpty() == false) {
				// 순회하면서 하나씩 삭제
				for(AttachDTO attach : attachList) {
					// 삭제할 첨부 파일의 File 객체 생성
					File file = new File(attach.getPath(), attach.getFilesystem());
					// 삭제
					if(file.exists()) {
						file.delete();
					}
				}
			}
		}
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				out.println("<script>");
				out.println("alert('삭제 되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "/upload/list'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('삭제 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		
	}
}
