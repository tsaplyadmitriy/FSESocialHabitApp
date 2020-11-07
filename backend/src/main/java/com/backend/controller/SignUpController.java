package com.backend.controller;

import com.backend.entity.UserEntity;
import com.backend.repository.SocialHabitAppData;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SignUpController {
    private final SocialHabitAppData repository;

    SignUpController(SocialHabitAppData repository) {
        this.repository = repository;
    }

    @PostMapping("/signup")
    UserEntity newUserEntity(@RequestBody UserEntity newUser) {
        if (repository.findUserById(newUser.getLogin()) != null) {
            throw new UserEntityExistException(newUser.getLogin());
        }
        return repository.saveUser(newUser);
    }
}
