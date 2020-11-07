package com.backend.controller;

import com.backend.entity.LoginResponse;

public class TokenNotFoundException extends RuntimeException {
    LoginResponse loginResponse;
    TokenNotFoundException(LoginResponse loginResponse) {
        this.loginResponse = loginResponse;
    }

    LoginResponse getLoginResponse() {return this.loginResponse;}

    void setLoginResponse(LoginResponse loginResponse) {this.loginResponse = loginResponse;}
}
