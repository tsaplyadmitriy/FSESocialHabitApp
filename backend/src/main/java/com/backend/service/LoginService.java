package com.backend.service;

import com.backend.entity.UserEntity;
import com.backend.repository.SocialHabitAppData;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.Optional;
import java.util.UUID;

@Service("LoginService")
public class LoginService {
    @Autowired
    SocialHabitAppData repository;

    public String login(String login, String password) {
        UserEntity user = repository.findUserByIdAndPassword(login, password);
        if (repository.findUserByIdAndPassword(login, password) != null) {
            user.setToken(UUID.randomUUID().toString());
            repository.updateOneUser(user);
            return user.getToken();
        }
        return null;
    }

    public Optional<User> findByToken(String token) {
        UserEntity user = repository.findUserByToken(token);
        if (user != null) {
            User securityUser = new User(user.getLogin(), user.getPassword(), true, true, true, true,
                    AuthorityUtils.createAuthorityList("USER"));
            return Optional.of(securityUser);
        }
        return Optional.empty();
    }
}
