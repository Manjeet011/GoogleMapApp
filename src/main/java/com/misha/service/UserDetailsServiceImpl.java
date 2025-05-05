package com.misha.service;

import com.misha.model.SitterRegistration;
import com.misha.repository.SitterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;


public class UserDetailsServiceImpl implements UserDetailsService {
	
	@Autowired
	private SitterRepository sitterRepository;
	
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {


		System.out.println("Email of this method is bro :"+email);

		SitterRegistration user = sitterRepository.findByEmail(email);

		if(user == null) {
			throw new UsernameNotFoundException("Could not find user");
		}
		return new MyUserDetails(user);
	}

}
