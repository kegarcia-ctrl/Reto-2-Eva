package com.kasa.controller;

import com.kasa.model.*;
import com.kasa.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * AdminDataController - Centralized access for Admin to see remaining system
 * tables
 */
@RestController
@RequestMapping("/admins/data")
@CrossOrigin(origins = "*")
public class AdminDataController {

    @Autowired
    private AdminUserRepository adminRepo;
    @Autowired
    private CityRepository cityRepo;
    @Autowired
    private PropertyTypeRepository typeRepo;
    @Autowired
    private PropertyImageRepository imageRepo;
    @Autowired
    private PropertyServiceRepository serviceRepo;
    @Autowired
    private PaymentRepository paymentRepo;

    @GetMapping("/admins")
    public List<AdminUser> getAllAdmins() {
        return adminRepo.findAll();
    }

    @GetMapping("/cities")
    public List<City> getAllCities() {
        return cityRepo.findAll();
    }

    @GetMapping("/types")
    public List<PropertyType> getAllTypes() {
        return typeRepo.findAll();
    }

    @GetMapping("/images")
    public List<PropertyImage> getAllImages() {
        return imageRepo.findAll();
    }

    @GetMapping("/services")
    public List<PropertyServiceEntity> getAllServices() {
        return serviceRepo.findAll();
    }

    @GetMapping("/payments")
    public List<Payment> getAllPayments() {
        return paymentRepo.findAll();
    }

    // Generic Delete endpoints
    @DeleteMapping("/cities/{id}")
    public void deleteCity(@PathVariable Long id) {
        cityRepo.deleteById(id);
    }

    @DeleteMapping("/types/{id}")
    public void deleteType(@PathVariable Long id) {
        typeRepo.deleteById(id);
    }

    @DeleteMapping("/images/{id}")
    public void deleteImage(@PathVariable Long id) {
        imageRepo.deleteById(id);
    }

    @DeleteMapping("/services/{id}")
    public void deleteService(@PathVariable Long id) {
        serviceRepo.deleteById(id);
    }

    @DeleteMapping("/payments/{id}")
    public void deletePayment(@PathVariable Long id) {
        paymentRepo.deleteById(id);
    }
}
