package com.backend.controller.groups;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@ControllerAdvice
public class GroupNotValidAdvice {
    @ResponseBody
    @ExceptionHandler(GroupNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    String groupNotValid(GroupNotValidException ex) {
        return ex.getMessage();
    }
}
