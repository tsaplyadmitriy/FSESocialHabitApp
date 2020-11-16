package com.backend.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ChallengeEntity {
    private String challengeName;
    private String challengeDescription;
    private List<ChallengeCounter> challengeCounters;
    private Date challengeDateOfStarting;

    public ChallengeEntity() {
        challengeCounters = new ArrayList<>();
    }

    public ChallengeEntity(String challengeName, String challengeDescription) {
        this.challengeName = challengeName;
        this.challengeDescription = challengeDescription;
        challengeCounters = new ArrayList<>();
        challengeDateOfStarting = new Date();
    }

    public void addCounter(String user) {
        ChallengeCounter tempCounter = new ChallengeCounter(user, 0);
        if (this.containUser(user) < 0) {
            challengeCounters.add(tempCounter);
        }
    }

    public void deleteCounter(String user) {
        int userIndex = this.containUser(user);
        if (userIndex >= 0) {
            challengeCounters.remove(userIndex);
        }
    }

    public int containUser(String user) {
        for (int i = 0; i < challengeCounters.size(); i++) {
            if (challengeCounters.get(i).getUser().compareTo(user) == 0) {
                return i;
            }
        }
        return -1;
    }

    public void setChallengeName(String challengeName) { this.challengeName = challengeName; }

    public String getChallengeName() {return challengeName;}

    public void setChallengeDescription(String challengeDescription) {this.challengeDescription = challengeDescription;}

    public String getChallengeDescription(){return challengeDescription;}

    public void setChallengeCounters(List<ChallengeCounter> challengeCounters){this.challengeCounters = challengeCounters;}

    public List<ChallengeCounter> getChallengeCounters(){return challengeCounters;}

    public void setChallengeDateOfStarting(Date challengeDateOfStarting){this.challengeDateOfStarting = challengeDateOfStarting;}

    public Date getChallengeDateOfStarting(){return challengeDateOfStarting;}
}
