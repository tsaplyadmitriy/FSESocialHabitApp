package com.backend.controller;

import com.backend.entity.LoginResponse;

public class UserEntityUnauthorizedException extends RuntimeException {
    LoginResponse loginResponse;
    public UserEntityUnauthorizedException(LoginResponse loginResponse) {
        this.loginResponse = loginResponse;
    }

    public LoginResponse getLoginResponse(){return loginResponse;}

    public void setLoginResponse(LoginResponse loginResponse) {
        this.loginResponse = loginResponse;
    }
}
