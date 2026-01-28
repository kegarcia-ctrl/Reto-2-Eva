package com.kasa.repository;

import com.kasa.model.Property;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.math.BigDecimal;
import java.util.List;

/**
 * Property Repository - Database operations for properties
 */
@Repository
public interface PropertyRepository extends JpaRepository<Property, Long> {

        List<Property> findByStatus(Property.PropertyStatus status);

        List<Property> findByCityId(Long cityId);

        List<Property> findByPriceLessThanEqual(BigDecimal maxPrice);

        List<Property> findByOwnerId(Long ownerId);

        @Query("SELECT p FROM Property p WHERE " +
                        "(:cityId IS NULL OR p.cityId = :cityId) AND " +
                        "(:zone IS NULL OR p.zone = :zone) AND " +
                        "(:maxPrice IS NULL OR p.price <= :maxPrice) AND " +
                        "(:propertyTypeId IS NULL OR p.propertyTypeId = :propertyTypeId) AND " +
                        "p.status = 'DISPONIBLE'")
        List<Property> findByFilters(
                        @Param("cityId") Long cityId,
                        @Param("zone") String zone,
                        @Param("maxPrice") BigDecimal maxPrice,
                        @Param("propertyTypeId") Long propertyTypeId);
}
