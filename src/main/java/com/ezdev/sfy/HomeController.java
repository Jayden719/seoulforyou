package com.ezdev.sfy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	
	@RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
	public String home() {
		return "index";
	}
}
