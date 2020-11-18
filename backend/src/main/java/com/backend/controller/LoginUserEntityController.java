package com.backend.controller;

import com.backend.entity.GroupEntity;
import com.backend.entity.LoginResponse;
import com.backend.entity.UserEntity;
import com.backend.repository.SocialHabitAppData;
import org.springframework.hateoas.EntityModel;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class LoginUserEntityController {
    private final SocialHabitAppData repository;

    LoginUserEntityController(SocialHabitAppData repository) {
        this.repository = repository;
    }

    /*
    **Return LoginResponse with error=1, if invalid login or password and error=0 otherwise
     */
    @RequestMapping(value = "/login", produces = {MediaType.APPLICATION_JSON_VALUE})
    LoginResponse one(@RequestParam("login") String login, @RequestParam("password") String password) {
        UserEntity logOutUser = repository.findUserById(login);
        if (logOutUser == null){
            throw new UserEntityUnauthorizedException(new LoginResponse(1, null, "Wrong login or/and password"));
        }
        if (logOutUser.getPassword().compareTo(password) != 0) {
            throw new UserEntityUnauthorizedException(new LoginResponse(1, null, "Wrong login or/and password"));
        }
        return new LoginResponse(0, logOutUser.getToken(), "Accepted");
    }

    @GetMapping(value = "/api/user")
    EntityModel<UserEntity> getOne(@RequestParam("token") String token) {
        UserEntity user = repository.findUserByToken(token);
        if (user == null) {
            throw new TokenNotFoundException(new LoginResponse(1, null,  "User not found!"));
        }
        return EntityModel.of(user);
    }

    @GetMapping(value = "/api/userByLogin")
    EntityModel<UserEntity> getByLogin(@RequestParam("login") String login) {
        UserEntity user = repository.findUserById(login);
        if (user == null) {
            throw new TokenNotFoundException(new LoginResponse(1, null,  "User not found!"));
        }
        return EntityModel.of(user);
    }

    @PutMapping(value = "/api/updateUser", produces = {MediaType.APPLICATION_JSON_VALUE})
    EntityModel<UserEntity> updateUser(@RequestBody UserEntity user) {
        UserEntity oldUser = repository.findUserById(user.getLogin());
        if (oldUser == null) {
            throw new TokenNotFoundException(new LoginResponse(1, null, "User not found!"));
        }
        oldUser = user;
        List<String> userGroups = oldUser.getUserGroups();
        for (int i = 0; i < userGroups.size(); i++) {
            GroupEntity group = repository.findGroupById(userGroups.get(i));
            group.updateUserInfo(oldUser);
            repository.saveGroup(group);
        }
        return EntityModel.of(repository.saveUser(oldUser));
    }
}
