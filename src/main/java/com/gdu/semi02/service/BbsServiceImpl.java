package com.gdu.semi02.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.semi02.domain.BbsDTO;
import com.gdu.semi02.mapper.BbsMapper;
import com.gdu.semi02.util.BbsPageUtil;

//@AllArgsConstructor
@Service
public class BbsServiceImpl implements BbsService {
	
    @Autowired
	private BbsMapper bbsMapper;
    @Autowired
	private BbsPageUtil pageUtil;

	
	@Override
	public void findAllBbsList(Model model) {		
		Map<String, Object> modelMap = model.asMap();
		HttpServletRequest request = (HttpServletRequest)modelMap.get("request");
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int totalRecord = bbsMapper.selectAllBbsCount();
		
		pageUtil.setPageUtil(page, totalRecord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());

		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("bbsList", bbsMapper.selectAllBbsList(map));
		model.addAttribute("beginNo", totalRecord - (page -1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/bbs/list"));

	}
	
	@Override
	public void saveBbs(HttpServletRequest request, HttpServletResponse response) {
		String bbsTitle = request.getParameter("bbsTitle");
		String bbsContent = request.getParameter("bbsContent");
		Optional<String> opt = Optional.ofNullable(request.getHeader("X-Forwarded-For"));
		String bbsIp = opt.orElse(request.getRemoteAddr());
		
		BbsDTO bbs = BbsDTO.builder()
				.bbsTitle(bbsTitle)
				.bbsContent(bbsContent)
				.bbsIp(bbsIp)
				.build();
		int result = bbsMapper.insertBbs(bbs);
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if( result > 0) {
				out.println("<script>");
				out.println("alert('작성이 완료되었습니다!');");
				out.println("location.href='" + request.getContextPath() + "/bbs/list';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('작성이 실패했습니다!');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
				
	}
	
	@Override
	public int increaseBbsHit(int bbsNo) {
		return bbsMapper.updateHit(bbsNo);
	}
	
	@Override
	public BbsDTO getBbsByNo(int bbsNo) {
		return bbsMapper.selectBbsByNo(bbsNo);
	}
	
	
	@Override
	public void modifyBbs(HttpServletRequest request, HttpServletResponse response) {
		String bbsTitle = request.getParameter("bbsTitle");
		String bbsContent = request.getParameter("bbsContent");
		int bbsNo = Integer.parseInt(request.getParameter("bbsNo"));
		
		BbsDTO bbs = BbsDTO.builder()
				.bbsTitle(bbsTitle)
				.bbsContent(bbsContent)
				.bbsNo(bbsNo)
				.build();
		int result = bbsMapper.updateBbs(bbs);
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0 ) {
				out.println("alert('수정 성공!');");
				out.println("location.href='" + request.getContextPath() + "/bbs/detail?bbsNo=" + bbsNo + "';");
			} else {
				out.println("alert('수정 실패');");
				out.println("history.back();");
			}
			out.println("</script>");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	@Override
	public void removeBbs(HttpServletRequest request, HttpServletResponse response) {
		int bbsNo = Integer.parseInt(request.getParameter("bbsNo"));
		int result = bbsMapper.deleteBbs(bbsNo);
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result >0 ) {
				out.println("alert('삭제성공');");
				out.println("location.href='" + request.getContextPath() + "/bbs/list';");
			} else {
				out.println("alert('삭제실패');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	
	
}
