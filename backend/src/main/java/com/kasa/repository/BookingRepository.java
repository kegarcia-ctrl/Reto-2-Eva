package com.kasa.repository;

import com.kasa.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

/**
 * Booking Repository - Database operations for bookings
 */
@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    List<Booking> findByUserId(Long userId);

    List<Booking> findByPropertyId(Long propertyId);

    @Query("SELECT b FROM Booking b WHERE b.propertyId = :propertyId " +
            "AND b.status <> 'CANCELADA' " +
            "AND ((b.checkIn <= :checkOut) AND (b.checkOut >= :checkIn))")
    List<Booking> findOverlappingBookings(Long propertyId, LocalDate checkIn, LocalDate checkOut);

    List<Booking> findByStatus(Booking.BookingStatus status);
}
