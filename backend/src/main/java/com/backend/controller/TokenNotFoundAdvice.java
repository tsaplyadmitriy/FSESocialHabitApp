package com.backend.controller;

import com.backend.entity.LoginResponse;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class TokenNotFoundAdvice {
    @ResponseBody
    @ExceptionHandler(TokenNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    LoginResponse tokenNotFound(TokenNotFoundException ex) {
        return ex.getLoginResponse();
    }
}
