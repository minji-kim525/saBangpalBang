package com.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.filter.HiddenHttpMethodFilter;

@SpringBootApplication
public class SabangpalbangApplication {

	public static void main(String[] args) {
		SpringApplication.run(SabangpalbangApplication.class, args);
	}
	
	@Bean
	HiddenHttpMethodFilter hiddenHttpMethodFilter(){
		return new HiddenHttpMethodFilter();
	}
	//_method라는 이름으로 전달된 값을 요청방식으로 인식

}
