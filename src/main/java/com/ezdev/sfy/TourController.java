package com.ezdev.sfy;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezdev.sfy.dto.TourDTO;
import com.ezdev.sfy.service.TourMapper;

@Controller
public class TourController {
	@Autowired
	private TourMapper tourMapper;
	//여행지
	@RequestMapping("/tourList.do")
	public String tourList(HttpServletRequest req,@RequestParam(required=false) String region) {
		HttpSession session = req.getSession();
		session.removeAttribute("tourList");
		
		//세션에 "tourList" 키의 여행지 목록이 없다면 새로 만들어 저장한다
		if(session.getAttribute("tourList") == null) {
			List<TourDTO> list = tourMapper.listTour();
			session.setAttribute("tourList", list);			
		}
		   if(region != null) {
		         List<TourDTO> list = tourMapper.listTourByRegion(region);
		         session.setAttribute("tourList", list);
		      }
		return "tour/tourList";
	}
	   
	

}