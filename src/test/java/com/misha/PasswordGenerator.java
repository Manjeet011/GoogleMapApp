package com.misha;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordGenerator {
	
	public static void main(String[] args) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String rawPassword ="1234";
		String encoedPassword = encoder.encode(rawPassword);
		
		System.out.println(encoedPassword);
	}
}
