package com.kasa.controller;

import com.kasa.model.User;
import com.kasa.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User Controller - REST API endpoints for user operations
 */
@RestController
@RequestMapping("/users")
@CrossOrigin(origins = "*")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping
    public List<User> getAllUsers() {
        return userService.getAllUsers();
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        return userService.getUserById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/register")
    public ResponseEntity<Map<String, Object>> register(@RequestBody User user) {
        Map<String, Object> response = new HashMap<>();

        if (userService.emailExists(user.getEmail())) {
            response.put("exito", false);
            response.put("mensaje", "El email ya está registrado");
            return ResponseEntity.badRequest().body(response);
        }

        User createdUser = userService.createUser(user);
        response.put("exito", true);
        response.put("mensaje", "Usuario registrado correctamente");
        response.put("usuario", createdUser);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody Map<String, String> credentials) {
        Map<String, Object> response = new HashMap<>();
        String email = credentials.get("email");
        String password = credentials.get("contrasena");

        User user = userService.login(email, password);
        if (user != null) {
            response.put("exito", true);
            response.put("mensaje", "Login exitoso");
            response.put("usuario", user);
            return ResponseEntity.ok(response);
        } else {
            response.put("exito", false);
            response.put("mensaje", "Email o contraseña incorrectos");
            return ResponseEntity.badRequest().body(response);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
        return ResponseEntity.ok().build();
    }
}
