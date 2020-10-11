package com.backend.entity;


public class LoginResponse {
    private int error;
    private String token = null;
    private String message;

    public LoginResponse(int error, String token, String message) {
        this.error = error;
        this.token = token;
        this.message = message;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public int getError() {
        return error;
    }

    public void setError(int error) {
        this.error = error;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
