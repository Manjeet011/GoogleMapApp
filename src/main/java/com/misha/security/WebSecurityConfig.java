package com.misha.security;

import com.misha.service.UserDetailsServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig {


    @Bean
    public UserDetailsService userDetailsService() {
        return new UserDetailsServiceImpl();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/","/home/**","/register/**" ,"/loginservlet/**","/saveDetails/**","/search/**", "/searchOperation/**","/login/","/images/**").permitAll()
                .and()
                .authorizeRequests()
                .antMatchers("/admin/showRecords/**").hasAnyAuthority("ADMIN","USER")
                .antMatchers("/profile/**").hasAnyAuthority("ADMIN","USER")
                .anyRequest()
                .authenticated()
                .and()
                .formLogin()
                .defaultSuccessUrl("/home", true)
                .failureUrl("/login?error=true") // Redirect on failure
                .permitAll()
              //  .formLogin().permitAll()
                .and()
                .logout().permitAll()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/home")
                .invalidateHttpSession(true)
                .and()
                .exceptionHandling().accessDeniedPage("/403");

        http.csrf().disable();

        return http.build();
    }


    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new  BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setPasswordEncoder(passwordEncoder());
        authProvider.setUserDetailsService(userDetailsService());
        return authProvider;
    }

}
