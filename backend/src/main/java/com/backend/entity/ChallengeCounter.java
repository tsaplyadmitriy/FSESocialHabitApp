package com.backend.entity;

public class ChallengeCounter{
    String user;
    Integer counter;

    public ChallengeCounter(String user, Integer counter) {
        this.user = user;
        this.counter = counter;
    }

    public void setUser(String user){this.user = user;}

    public String getUser(){return user;}

    public void setCounter(Integer counter) {this.counter = counter;}

    public Integer getCounter() {return counter;}
}
