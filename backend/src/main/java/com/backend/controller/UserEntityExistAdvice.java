package com.backend.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class UserEntityExistAdvice {
    @ResponseBody
    @ExceptionHandler(UserEntityExistException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    String userEntityExist(UserEntityExistException exception) {
        return exception.getMessage();
    }
}
