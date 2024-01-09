package com.app.security.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.app.security.config.BoardUserDetailsService;

@Configuration
public class SecurityConfig {

	@Autowired
	private BoardUserDetailsService boardUserDetailsService;

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

		http.csrf(AbstractHttpConfigurer::disable)

				.headers((headers) -> headers.frameOptions(HeadersConfigurer.FrameOptionsConfig::disable))

				.authorizeHttpRequests(auth -> {
					try {
						auth.requestMatchers(new AntPathRequestMatcher("/mypage/***")).authenticated()
								.requestMatchers(new AntPathRequestMatcher("/admin")).hasRole("ADMIN").anyRequest()
								.permitAll()

								.and().formLogin().loginPage("/login").defaultSuccessUrl("/", true).and()
								.exceptionHandling().accessDeniedPage("/accessDenied").and().logout()
								.invalidateHttpSession(true).logoutSuccessUrl("/");
					} catch (Exception e) {
						e.printStackTrace();
					}

				}

				);
		http.userDetailsService(boardUserDetailsService);
		return http.build();
//		
//		security.authorizeHttpRequests()
//						.requestMatchers("/member/**").authenticated()
//						.requestMatchers("/admin/**").hasRole("ADMIN")
//						.anyRequest().permitAll();
//		security
//				.formLogin()
//				.loginPage("/login")
//		security.csrf().disable();
//		security.formLogin();
//		
//		return security.build();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}

	public void configure(WebSecurity web) throws Exception {
	    web.httpFirewall(defaultHttpFirewall());
	}
	 
	@Bean
	public HttpFirewall defaultHttpFirewall() {
	    return new DefaultHttpFirewall();
	}

}
