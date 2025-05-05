package com.misha.service;

import com.misha.model.Role;
import com.misha.model.SitterRegistration;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;


public class MyUserDetails implements UserDetails {
	
	private static final long serialVersionUID = 1L;
	private SitterRegistration user;
	
	public MyUserDetails(SitterRegistration user) {
		super();
		this.user = user;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Set<Role> roles = user.getRoles();
		
		List<SimpleGrantedAuthority> authorities = new ArrayList<>();
		for(Role role: roles) {
			authorities.add(new SimpleGrantedAuthority(role.getName()));
		}
		return authorities;
	}

	@Override
	public String getPassword() {
		return user.getPassword();
	}

	@Override
	public String getUsername() {
		return user.getEmail();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return user.isEnabled();
	}
	
	public String getContactname() {
		return user.getContactname();
	}
	
	public String getCompanyname() {
		return user.getCompanyname();
	}
	
	public String getOpentime() {
		return user.getOpentime();
	}
	public String getClosetime() {
		return user.getClosetime();
	}
	public float getChargesperhour() {
		return user.getChargesperhour();
	}
	
	public String getLogo() {
		return user.getLogo();
	}
	
}
