package com.misha.service;

import com.misha.model.Role;
import com.misha.model.SitterRegistration;
import com.misha.repository.SitterRepository;
import com.misha.repository.roleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service
public class RegistrationService {


    @Autowired
    private  SitterRepository sitterrepository;


    @Autowired
    private roleRepository relerepository;
    PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    Set<Role> roles= new HashSet<>();


    public void updateSitterDetails(SitterRegistration sitterregistration)
    {
        String encryptedPassword = passwordEncoder.encode(sitterregistration.getPassword());
        sitterregistration.setPassword(encryptedPassword);
        sitterrepository.save(sitterregistration);
    }

    public void saveSitterDetails(SitterRegistration sitterregistration)
    {

         Optional<Role> role= relerepository.findById(1);
         Role role1= role.get();
         relerepository.save(role1);
         roles.add(role1);
         sitterregistration.setRoles(roles);
         String encryptedPassword = passwordEncoder.encode(sitterregistration.getPassword());
         sitterregistration.setPassword(encryptedPassword);
         sitterregistration.setEnabled(true);
         sitterrepository.save(sitterregistration);
    }

    public SitterRegistration fetchByEmailAndPassword(String email,String password)
    {

        return sitterrepository.findByEmailAndPassword(email,password);
    }

    public List<SitterRegistration> findAlllUserNearThisLoccation(String latitude, String longitude)
    {
        return  sitterrepository.findByAddressAndSort(latitude,longitude);
    }

    public Page<SitterRegistration> fetchAllDetails(int size,int page)
    {

        Pageable pageable = PageRequest.of(page, size, Sort.Direction.ASC, "id");

          return  sitterrepository.findAll(pageable);
    }

    public SitterRegistration getUserByEmail(String email)
    {

        return  sitterrepository.findByEmail(email);

    }



}
