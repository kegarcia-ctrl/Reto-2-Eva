package com.kasa.repository;

import com.kasa.model.PropertyServiceEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PropertyServiceRepository extends JpaRepository<PropertyServiceEntity, Long> {
}
