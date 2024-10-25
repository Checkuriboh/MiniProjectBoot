package com.model2.mvc.common.web;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;


//@ControllerAdvice
public class WebExceptionHandler {
	
	/// constructor
	public WebExceptionHandler(){
		System.out.println("Common :: "+this.getClass());		
	}
	
	
	/// method
    @ExceptionHandler( NullPointerException.class )
    public String NullPointerExceptionHandler( Exception ex, Model model ) 
    {
		System.out.println("WebExceptionHandler : NullPointerException");
		
		model.addAttribute("exception", ex);
		
		return "forward:/common/nullError.jsp";
    }
    
    @ExceptionHandler( NumberFormatException.class )
    public ModelAndView NumberFormatExceptionHandler( Exception ex ) 
    {
		System.out.println("WebExceptionHandler : NumberFormatException");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/common/numberFormatError.jsp");
		mav.addObject("exception", ex);

		return mav;
    }
    
    @ExceptionHandler( Exception.class )
    public ModelAndView ExceptionHandler( Exception ex, Model model )  
    {
		System.out.println("WebExceptionHandler : Exception");

		return new ModelAndView("forward:/common/error.jsp", "exception", ex);
    }
    
}
