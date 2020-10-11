package com.backend.controller;

import com.backend.entity.UserEntity;
import com.backend.repository.UserEntityRepository;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SignUpController {
    private final UserEntityRepository repository;

    SignUpController(UserEntityRepository repository) {
        this.repository = repository;
    }

    @PostMapping("/signup")
    UserEntity newUserEntity(@RequestBody UserEntity newUser) {
        if (repository.findById(newUser.getLogin()).isPresent()) {
            throw new UserEntityExistException(newUser.getLogin());
        }
        return repository.save(newUser);
    }
}
