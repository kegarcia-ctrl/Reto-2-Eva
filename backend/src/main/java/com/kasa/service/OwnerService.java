package com.kasa.service;

import com.kasa.model.Owner;
import com.kasa.repository.OwnerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class OwnerService {

    @Autowired
    private OwnerRepository ownerRepository;

    public List<Owner> getAllOwners() {
        return ownerRepository.findAll();
    }

    public Optional<Owner> getOwnerById(Long id) {
        return ownerRepository.findById(id);
    }

    public Owner createOwner(Owner owner) {
        return ownerRepository.save(owner);
    }

    public Owner login(String email, String password) {
        Optional<Owner> ownerOpt = ownerRepository.findByEmail(email);
        if (ownerOpt.isPresent()) {
            Owner owner = ownerOpt.get();
            if (owner.getPassword().equals(password)) {
                return owner;
            }
        }
        return null;
    }

    public boolean emailExists(String email) {
        return ownerRepository.existsByEmail(email);
    }

    public void deleteOwner(Long id) {
        ownerRepository.deleteById(id);
    }
}
