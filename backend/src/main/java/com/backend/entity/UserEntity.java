package com.backend.entity;

import org.springframework.data.annotation.Id;

import java.util.Objects;


public class UserEntity {
    private @Id String login;
    private String password;
    private String token;
    private String firstName = "DefaultFirstName";
    private String lastName = "DefaultLastName";
    private int age = 18;


    public UserEntity(String login, String password, String firstName, String lastName, int age) {
        this.login = login;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.age = age;
        token = Objects.toString(31 * (Objects
                .hashCode(this.login + this.password + this.firstName + this.lastName) + age));
    }
    public void setLogin(String login) {
        this.login = login;
    }

    public String getLogin() {
        return login;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public String getToken() {
        return this.token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getFirstName(){return firstName;}

    public void setFirstName(String firstName){this.firstName = firstName;}

    public String getLastName(){return lastName;}

    public void setLastName(String lastName){this.lastName = lastName;}

    public int getAge(){return age;}

    public void setAge(int age){this.age = age;}
}
