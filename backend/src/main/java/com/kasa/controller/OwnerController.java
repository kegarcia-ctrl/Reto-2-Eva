package com.kasa.controller;

import com.kasa.model.Owner;
import com.kasa.service.OwnerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/owners")
@CrossOrigin(origins = "*")
public class OwnerController {

    @Autowired
    private OwnerService ownerService;

    @GetMapping
    public List<Owner> getAllOwners() {
        return ownerService.getAllOwners();
    }

    @PostMapping("/register")
    public ResponseEntity<Map<String, Object>> register(@RequestBody Owner owner) {
        Map<String, Object> response = new HashMap<>();

        if (ownerService.emailExists(owner.getEmail())) {
            response.put("exito", false);
            response.put("mensaje", "El email ya está registrado");
            return ResponseEntity.badRequest().body(response);
        }

        Owner createdOwner = ownerService.createOwner(owner);
        response.put("exito", true);
        response.put("mensaje", "Propietario registrado correctamente");
        response.put("propietario", createdOwner);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody Map<String, String> credentials) {
        Map<String, Object> response = new HashMap<>();
        String email = credentials.get("email");
        String password = credentials.get("contrasena");

        Owner owner = ownerService.login(email, password);
        if (owner != null) {
            response.put("exito", true);
            response.put("mensaje", "Login exitoso");
            response.put("propietario", owner);
            return ResponseEntity.ok(response);
        } else {
            response.put("exito", false);
            response.put("mensaje", "Email o contraseña incorrectos");
            return ResponseEntity.badRequest().body(response);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOwner(@PathVariable Long id) {
        ownerService.deleteOwner(id);
        return ResponseEntity.ok().build();
    }
}
