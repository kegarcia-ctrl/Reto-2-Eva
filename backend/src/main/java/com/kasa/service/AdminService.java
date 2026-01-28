package com.kasa.service;

import com.kasa.model.AdminUser;
import com.kasa.repository.AdminUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;

/**
 * Admin Service - Business logic for administrator operations
 */
@Service
public class AdminService {

    @Autowired
    private AdminUserRepository adminUserRepository;

    public AdminUser login(String email, String password) {
        Optional<AdminUser> adminOpt = adminUserRepository.findByEmail(email);
        if (adminOpt.isPresent()) {
            AdminUser admin = adminOpt.get();
            // Simple check (match database plain text or hash if implemented)
            if (admin.getPassword().equals(password)) {
                return admin;
            }
        }
        return null;
    }
}
