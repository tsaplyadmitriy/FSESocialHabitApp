package com.backend.controller.groups;

public class GroupIdExistException extends RuntimeException {

    GroupIdExistException() {
        super("Group with such ID exist. Try recreate group!");
    }
}
