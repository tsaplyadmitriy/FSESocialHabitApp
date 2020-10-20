package com.backend.controller.groups;

public class GroupNotValidException extends RuntimeException {
    public GroupNotValidException() {
        super("Group is not valid!");

    }
}
