package com.backend.controller.groups;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class GroupIdExistAdvice {
    @ResponseBody
    @ExceptionHandler(GroupIdExistException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    String groupIdExist(GroupIdExistException ex) {
        return ex.getMessage();
    }
}
