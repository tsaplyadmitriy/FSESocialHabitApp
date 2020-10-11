package com.backend.controller;

import com.backend.entity.LoginResponse;
import com.backend.entity.UserEntity;
import com.backend.repository.UserEntityRepository;
import org.springframework.hateoas.EntityModel;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

@RestController
public class LoginUserEntityController {
    private final UserEntityRepository repository;

    LoginUserEntityController(UserEntityRepository repository) {
        this.repository = repository;
    }

    /*
    **Return LoginResponse with error=1, if invalid login or password and error=0 otherwise
     */
    @RequestMapping(value = "/login", produces = {MediaType.APPLICATION_JSON_VALUE})
    LoginResponse one(@RequestParam("login") String login, @RequestParam("password") String password) {
        UserEntity logOutUser = repository.findById(login)
                .orElseThrow(() -> new UserEntityUnauthorizedException(new LoginResponse(1, null, "Wrong login or/and password")));
        if (logOutUser.getPassword().compareTo(password) != 0) {
            throw new UserEntityUnauthorizedException(new LoginResponse(1, null, "Wrong login or/and password"));
        }
        return new LoginResponse(0, logOutUser.getToken(), "Accepted");
    }

    @GetMapping(value = "/getUserInfo")
    EntityModel<UserEntity> getOne(@RequestParam("token") String token) {
        UserEntity user = repository.findByToken(token);
        return EntityModel.of(user);
    }
}
