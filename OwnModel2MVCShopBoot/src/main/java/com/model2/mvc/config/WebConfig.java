package com.model2.mvc.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.model2.mvc.common.web.LogonCheckInterceptor;


//===================== �߰��� Class  ======================//
// Interceptor ����ϴ� WebMvcCongigurer ���� Bean
//=======================================================//
@Configuration
public class WebConfig implements WebMvcConfigurer {

	public WebConfig() {
		System.out.println("\nCommon :: "+this.getClass()+"\n");
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		// URL Pattern �� Ȯ���ϰ�. interceptor �������� �����.
		registry.addInterceptor( new LogonCheckInterceptor() ).addPathPatterns("/user/*");
		
	}

}