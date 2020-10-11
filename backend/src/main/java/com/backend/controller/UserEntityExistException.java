package com.backend.controller;

public class UserEntityExistException extends RuntimeException {
    UserEntityExistException(String login) {
        super("User with login " + login + " exists");
    }
}
