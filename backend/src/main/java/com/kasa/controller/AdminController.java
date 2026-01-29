package com.kasa.controller;

import com.kasa.model.AdminUser;
import com.kasa.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

/**
 * Admin Controller - REST API for administrator authentication
 */
@RestController
@RequestMapping("/admins")
@CrossOrigin(origins = "*")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody Map<String, String> credentials) {
        String email = credentials.get("email");
        String password = credentials.get("contrasena");

        AdminUser admin = adminService.login(email, password);
        Map<String, Object> response = new HashMap<>();

        if (admin != null) {
            response.put("exito", true);
            response.put("mensaje", "Login administrativo exitoso");
            response.put("admin", admin);
            return ResponseEntity.ok(response);
        } else {
            response.put("exito", false);
            response.put("mensaje", "Email o contraseña de administrador incorrectos");
            return ResponseEntity.status(401).body(response);
        }
    }
}
