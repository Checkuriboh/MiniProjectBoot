package com.model2.mvc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.model2.mvc.common.aspect.LogAspectJ;
import com.model2.mvc.common.web.LogonCheckInterceptor;


@Configuration
public class WebConfig implements WebMvcConfigurer {

	public WebConfig() {
		System.out.println("\nCommon :: "+this.getClass()+"\n");
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) 
	{
		// URL Pattern �� Ȯ���ϰ�. interceptor �������� �����.
		registry.addInterceptor( new LogonCheckInterceptor() ).addPathPatterns("/user/*");
	}

    @Bean
    LogAspectJ loggingAspect() {
        return new LogAspectJ();
    }

	// exception view resolve
//	@Override
//	public void extendHandlerExceptionResolvers(List<HandlerExceptionResolver> resolvers) 
//	{
//		resolvers.add(new HandlerExceptionResolver() {
//			@Override
//			public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
//					Exception ex) {
//
//		        if (ex instanceof NullPointerException) {
//		            ModelAndView modelAndView = new ModelAndView("/common/nullError.jsp");
//		            modelAndView.addObject("message", "NullPointerException occurred");
//		            return modelAndView;
//		        } 
//		        else if (ex instanceof NumberFormatException) {
//		            ModelAndView modelAndView = new ModelAndView("/common/numberFormatError.jsp");
//		            modelAndView.addObject("message", "NumberFormatException occurred");
//		            return modelAndView;
//		        }
//		        ModelAndView modelAndView = new ModelAndView("/common/error.jsp");
//		        modelAndView.addObject("message", "An unexpected error occurred");
//		        return modelAndView;
//			}
//		});
//	}
//
//	@Override
//	public void configureHandlerExceptionResolvers(List<HandlerExceptionResolver> resolvers) {
//		// ���� ó���⸦ ���� ����, Spring �⺻ ���� ó����� ������ ����
//		//WebMvcConfigurer.super.configureHandlerExceptionResolvers(resolvers);
//	}
	
}
