package com.kasa.service;

import com.kasa.model.Property;
import com.kasa.repository.PropertyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

/**
 * Property Service - Business logic for property operations
 */
@Service
public class PropertyService {

    @Autowired
    private PropertyRepository propertyRepository;

    @Autowired
    private com.kasa.repository.PropertyServiceRepository propertyServiceRepository;

    public List<Property> getAllProperties() {
        return propertyRepository.findAll();
    }

    public List<Property> getPropertiesByOwner(Long ownerId) {
        return propertyRepository.findByOwnerId(ownerId);
    }

    public List<Property> getAvailableProperties() {
        return propertyRepository.findByStatus(Property.PropertyStatus.DISPONIBLE);
    }

    public Optional<Property> getPropertyById(Long id) {
        return propertyRepository.findById(id);
    }

    public List<Property> filterProperties(Long cityId, String zone, BigDecimal maxPrice, Long propertyTypeId) {
        return propertyRepository.findByFilters(cityId, zone, maxPrice, propertyTypeId);
    }

    public Property createProperty(Property property) {
        if (property.getServiceIds() != null && !property.getServiceIds().isEmpty()) {
            List<com.kasa.model.PropertyServiceEntity> services = propertyServiceRepository
                    .findAllById(property.getServiceIds());
            property.setServices(services);
        }
        return propertyRepository.save(property);
    }

    public Property updateProperty(Long id, Property propertyDetails) {
        Optional<Property> propertyOpt = propertyRepository.findById(id);
        if (propertyOpt.isPresent()) {
            Property property = propertyOpt.get();
            property.setTitle(propertyDetails.getTitle());
            property.setDescription(propertyDetails.getDescription());
            property.setPrice(propertyDetails.getPrice());
            property.setStatus(propertyDetails.getStatus());
            // Update other fields as needed
            return propertyRepository.save(property);
        }
        return null;
    }

    public void deleteProperty(Long id) {
        propertyRepository.deleteById(id);
    }

    public void incrementViews(Long id) {
        Optional<Property> propertyOpt = propertyRepository.findById(id);
        if (propertyOpt.isPresent()) {
            Property property = propertyOpt.get();
            property.setViewsCount(property.getViewsCount() + 1);
            propertyRepository.save(property);
        }
    }
}
