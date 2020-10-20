package com.backend.entity;

import org.springframework.data.annotation.Id;

import java.util.*;

public class UserEntity {
    @Id
    private String login;
    private String password;
    private String token;
    private String firstName = "DefaultFirstName";
    private String lastName = "DefaultLastName";
    private int age = 18;
    private List<String> userGroups;
    public UserEntity(String login, String password, String firstName, String lastName, int age) {
        this.login = login;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.age = age;
        token = UUID.randomUUID().toString();
        userGroups = new ArrayList<>();
    }

    public void addGroup(String groupId) {
        userGroups.add(groupId);
    }

    public boolean isMemberOfGroup(String groupId) {
        return userGroups.contains(groupId);
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

    public List<String> getUserGroups(){return userGroups;}

    public void setUserGroups(List<String> userGroups) {this.userGroups = userGroups;}
}
