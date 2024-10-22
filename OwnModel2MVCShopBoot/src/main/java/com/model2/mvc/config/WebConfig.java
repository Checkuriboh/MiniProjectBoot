package com.model2.mvc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.model2.mvc.common.aspect.LogAspectJ;
import com.model2.mvc.common.web.LogonCheckInterceptor;


@Configuration
public class WebConfig implements WebMvcConfigurer {

	public WebConfig() {
		System.out.println("Common :: "+this.getClass());
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) 
	{
		// URL Pattern 을 확인하고. interceptor 적용유무 등록
		registry.addInterceptor( new LogonCheckInterceptor() ).addPathPatterns("/user/*");
	}

    @Bean
    LogAspectJ loggingAspect() {
        return new LogAspectJ();
    }
	
}
