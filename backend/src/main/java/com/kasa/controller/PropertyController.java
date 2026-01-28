package com.kasa.controller;

import com.kasa.model.Property;
import com.kasa.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.math.BigDecimal;
import java.util.List;

/**
 * Property Controller - REST API endpoints for property operations
 */
@RestController
@RequestMapping("/properties")
@CrossOrigin(origins = "*")
public class PropertyController {

    @Autowired
    private PropertyService propertyService;

    @GetMapping
    public List<Property> getAllProperties() {
        return propertyService.getAvailableProperties();
    }

    @GetMapping("/owner/{ownerId}")
    public List<Property> getPropertiesByOwner(@PathVariable Long ownerId) {
        return propertyService.getPropertiesByOwner(ownerId);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Property> getPropertyById(@PathVariable Long id) {
        propertyService.incrementViews(id);
        return propertyService.getPropertyById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/filter")
    public List<Property> filterProperties(
            @RequestParam(required = false) Long ciudadId,
            @RequestParam(required = false) String zone,
            @RequestParam(required = false) BigDecimal precioMax,
            @RequestParam(required = false) Long tipoPropiedadId) {
        return propertyService.filterProperties(ciudadId, zone, precioMax, tipoPropiedadId);
    }

    @PostMapping
    public Property createProperty(@RequestBody Property property) {
        return propertyService.createProperty(property);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Property> updateProperty(@PathVariable Long id, @RequestBody Property property) {
        Property updated = propertyService.updateProperty(id, property);
        return updated != null ? ResponseEntity.ok(updated) : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProperty(@PathVariable Long id) {
        propertyService.deleteProperty(id);
        return ResponseEntity.ok().build();
    }
}
