package com.backend.entity;

import java.util.Date;
import java.util.HashMap;

public class ChallengeEntity {
    private String challengeName;
    private String challengeDescription;
    private HashMap<String, Integer> challengeCounters;
    private Date challengeDateOfStarting;

    ChallengeEntity(String challengeName, String challengeDescription) {
        this.challengeName = challengeName;
        this.challengeDescription = challengeDescription;
        challengeCounters = new HashMap<>();
        challengeDateOfStarting = new Date();
    }

    public Integer getCounterOfMember(String login) {
        return challengeCounters.get(login);
    }

    public void addCounterForNewMember(String login) {
        if (!challengeCounters.containsKey(login)) {
            challengeCounters.put(login, 0);
        }
    }

    public boolean deleteCounterOfMember(String login) {
        if (challengeCounters.containsKey(login)) {
            challengeCounters.remove(login);
            return true;
        }
        return false;
    }

    public boolean increaseCounter(String login) {
        if (challengeCounters.containsKey(login)) {
            Integer tempCouner = challengeCounters.get(login);
            tempCouner++;
            challengeCounters.replace(login, tempCouner);
            return true;
        }
        return false;
    }

    public boolean decreaseCounter(String login) {
        if (challengeCounters.containsKey(login)) {
            Integer tempCounter = challengeCounters.get(login);
            tempCounter++;
            challengeCounters.replace(login, tempCounter);
            return true;
        }
        return false;
    }

    public void setChallengeName(String challengeName) { this.challengeName = challengeName; }

    public String getChallengeName() {return challengeName;}

    public void setChallengeDescription(String challengeDescription) {this.challengeDescription = challengeDescription;}

    public String getChallengeDescription(){return challengeDescription;}

    public void setChallengeCounters(HashMap<String, Integer> challengeCounters){this.challengeCounters = challengeCounters;}

    public HashMap<String, Integer> getChallengeCounters(){return challengeCounters;}

    public void setChallengeDateOfStarting(Date challengeDateOfStarting){this.challengeDateOfStarting = challengeDateOfStarting;}

    public Date getChallengeDateOfStarting(){return challengeDateOfStarting;}
}
