package com.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.filter.HiddenHttpMethodFilter;

@SpringBootApplication
public class SabangpalbangApplication extends SpringBootServletInitializer {
	
	@Override 
	   protected SpringApplicationBuilder configure(SpringApplicationBuilder application) { 
	      return application.sources(SabangpalbangApplication.class);
	   }

	public static void main(String[] args) {
		SpringApplication.run(SabangpalbangApplication.class, args);
	}
	
	@Bean
	HiddenHttpMethodFilter hiddenHttpMethodFilter(){
		return new HiddenHttpMethodFilter();
	}
	//_method라는 이름으로 전달된 값을 요청방식으로 인식

}
