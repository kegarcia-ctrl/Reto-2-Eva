package com.kasa.repository;

import com.kasa.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

/**
 * Booking Repository - Database operations for bookings
 */
@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    List<Booking> findByUserId(Long userId);

    List<Booking> findByPropertyId(Long propertyId);

    List<Booking> findByStatus(Booking.BookingStatus status);
}
