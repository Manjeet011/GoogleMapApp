package com.misha.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Repository;
import com.misha.model.SitterRegistration;
@Repository
public interface SitterRepository  extends JpaRepository<SitterRegistration ,Integer> {

 // String countDistanceQuery = "(3959 * ACOS(COS(RADIANS(:latitude)) * COS(RADIANS(lat)) * COS(RADIANS(lng) - RADIANS(:longitude)) + SIN(RADIANS(:latitude)) * SIN(RADIANS(lat))))";

  public SitterRegistration findByEmailAndPassword(String email, String password);
  public SitterRegistration findByEmail(String email);

  @Query(value = "SELECT a.*, " +
          "(6371 * ACOS( " +
          "COS(RADIANS(CAST(:latitude AS DECIMAL(10,7)))) " +
          "* COS(RADIANS(a.lat)) " +
          "* COS(" +
          "RADIANS(a.lng) - RADIANS(CAST(:longitude AS DECIMAL(10,7)))) " +
          "+ SIN(RADIANS(CAST(:latitude AS DECIMAL(10,7)))) " +
          "* SIN(RADIANS(a.lat)) " +
          ")) AS distance " +
          "FROM sitterdetails a " +
          "WHERE (6371 * ACOS( " +
          "COS(RADIANS(CAST(:latitude AS DECIMAL(10,7)))) " +
          "* COS(RADIANS(a.lat)) " +
          "* COS(RADIANS(a.lng) - RADIANS(CAST(:longitude AS DECIMAL(10,7)))) " +
          "+ SIN(RADIANS(CAST(:latitude AS DECIMAL(10,7)))) " +
          "* SIN(RADIANS(a.lat)) " +
          ")) < 25 " +
          "ORDER BY distance " +
          "LIMIT 20",
          nativeQuery = true)
  List<SitterRegistration> findByAddressAndSort(@Param("latitude") String latitude,
                                                @Param("longitude") String longitude);

  public Page<SitterRegistration> findAll(Pageable pageable);


}

