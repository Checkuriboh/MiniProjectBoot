package com.model2.mvc.web.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/user/*")
public class UserController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public UserController(){
		System.out.println(this.getClass());
	}
	
	@Value("${pageUnit:3}")
	private int pageUnit;
	
	@Value("${pageSize:3}")
	private int pageSize;
	
	
	//@RequestMapping("/addUserView.do")
	//public String addUserView() throws Exception {
	@GetMapping("addUser")
	public String addUser() throws Exception {

		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	//@RequestMapping("/addUser.do")
	@PostMapping("addUser")
	public String addUser( @ModelAttribute User user ) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
		return "redirect:/user/loginView.jsp";
	}
	
	//@RequestMapping("/getUser.do")
	@GetMapping("getUser")
	public String getUser( @RequestParam String userId , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);
		
		return "forward:/user/getUser.jsp";
	}
	
	//@RequestMapping("/updateUserView.do")
	//public String updateUserView( @RequestParam("userId") String userId , Model model ) throws Exception{
	@GetMapping("updateUser")
	public String updateUser( @RequestParam String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);
		
		return "forward:/user/updateUser.jsp";
	}
	
	//@RequestMapping("/updateUser.do")
	@PostMapping("updateUser")
	public String updateUser( @ModelAttribute User user , HttpSession session) throws Exception {

		System.out.println("/user/updateUser : POST");
		
		//Business Logic
		userService.updateUser(user);
		user = userService.getUser(user.getUserId());

		User onUser = (User)session.getAttribute("user");
		
		if ( onUser.getUserId().equals(user.getUserId()) ) {
			session.setAttribute("user", user);
		}
		
		//return "redirect:/getUser.do?userId=" + user.getUserId();
		return "redirect:/user/getUser?userId=" + user.getUserId();
	}
	
	//@RequestMapping("/loginView.do")
	//public String loginView() throws Exception{
	@GetMapping("login")
	public String login() throws Exception {

		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	//@RequestMapping("/login.do")
	@PostMapping("login")
	public String login( @ModelAttribute User user , HttpSession session ) throws Exception{

		System.out.println("/user/logon : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return "redirect:/index.jsp";
	}
	
	//@RequestMapping("/logout.do")
	@GetMapping("logout")
	public String logout( HttpSession session ) throws Exception{

		System.out.println("/user/logout : GET");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	//@RequestMapping("/checkDuplication.do")
	@PostMapping("checkDuplication")
	public String checkDuplication( @RequestParam String userId , Model model ) throws Exception {
		
		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		// Model 과 View 연결
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}
	
	//@RequestMapping("/listUser.do")
	@RequestMapping(value="listUser", method={RequestMethod.GET, RequestMethod.POST})
	public String listUser( @ModelAttribute Search search , Model model , HttpServletRequest request ) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
	
}