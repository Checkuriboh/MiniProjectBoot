package com.model2.mvc.web.user;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	///Constructor
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	
	//==> 회원 정보를 받아 DB에 추가
	@PostMapping("json/addUser")
	public boolean addUser( @RequestBody User user ) throws Exception
	{
		System.out.println("/user/json/addUser : POST");

		userService.addUser(user);
		
		if ( userService.getUser(user.getUserId()) != null ) {
			return true;
		}
		else {
			return false;
		}
	}
	
	//==> 회원 ID를 받아 회원 정보 검색 및 반환
	@GetMapping("json/getUser/{userId}")
	public User getUser( @PathVariable String userId ) throws Exception
	{
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}
	
	//==> 회원 정보를 받아 DB에서 갱신
	@PostMapping("json/updateUser")
	public User updateUser( @RequestBody User user, 
							HttpSession session ) throws Exception
	{
		System.out.println("/user/json/updateUser : POST");

		userService.updateUser(user);
		
		String sessionId = ( (User)session.getAttribute("user") ).getUserId();
		if ( sessionId.equals(user.getUserId()) ) {
			session.setAttribute("user", user);
		}
		
		return user;
	}

	//==> 회원정보(ID,password)를 받아 로그인 
	@PostMapping("json/login")
	public User login( @RequestBody User user,
					   HttpSession session ) throws Exception
	{
		System.out.println("/user/json/login : POST");
		
		//Business Logic
		System.out.println(":: " + user);
		User dbUser = userService.getUser(user.getUserId());
		
		if ( dbUser.getPassword().equals(user.getPassword()) )
		{
			session.setAttribute("user", dbUser);
			return dbUser;
		}
		
		return null;
	}
	
	//==> 로그아웃
	@GetMapping("json/logout")
	public boolean logout( HttpSession session ) throws Exception
	{
		System.out.println("/user/json/logout : GET");
		
		session.removeAttribute("user");
		
		if (session.getAttribute("user") == null) {
			return true;
		}
		else {
			return false;
		}
	}
	
	//==> 회원 ID를 받아 중복 체크
	@PostMapping("json/checkDuplication")
	public boolean checkDuplication( @RequestParam String userId ) throws Exception 
	{
		System.out.println("/user/json/checkDuplication : POST");
		
		//Business Logic
		return userService.checkDuplication(userId);
	}
	
	//==> 검색정보를 받아 상품목록 검색 및 반환
	@PostMapping("json/listUser")
	public Map<String, Object> listUser( @RequestBody Search search ) throws Exception
	{
		System.out.println("/user/json/listUser : POST");

		//Business Logic
		return userService.getUserList(search);
	}
	
}