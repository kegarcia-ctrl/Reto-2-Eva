package com.kasa.controller;

import com.kasa.model.City;
import com.kasa.model.PropertyType;
import com.kasa.repository.CityRepository;
import com.kasa.repository.PropertyTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("/lookup")
@CrossOrigin(origins = "*")
public class LookupController {

    @Autowired
    private CityRepository cityRepository;

    @Autowired
    private PropertyTypeRepository propertyTypeRepository;

    @Autowired
    private com.kasa.repository.PropertyServiceRepository propertyServiceRepository;

    @GetMapping("/cities")
    public List<City> getAllCities() {
        return cityRepository.findAll();
    }

    @GetMapping("/types")
    public List<PropertyType> getAllPropertyTypes() {
        return propertyTypeRepository.findAll();
    }

    @GetMapping("/services")
    public List<com.kasa.model.PropertyServiceEntity> getAllServices() {
        return propertyServiceRepository.findAll();
    }
}
