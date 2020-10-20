package com.backend.repository;

import com.backend.controller.UserEntityExistException;
import com.backend.entity.GroupEntity;
import com.backend.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class SocialHabitAppData {
    private final MongoTemplate mongoTemplate;

    @Autowired
    SocialHabitAppData(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }

    public UserEntity saveUser(UserEntity user) {
        mongoTemplate.save(user);
        return user;
    }

    public UserEntity findUserByIdAndPassword(String login, String password) {
        Query query = new Query();
        query.addCriteria(Criteria.where("_id").is(login).and("password").is(password));
        return mongoTemplate.findOne(query, UserEntity.class);
    }

    public UserEntity findUserById(String login) {
        Query query = new Query();
        query.addCriteria(Criteria.where("_id").is(login));
        return mongoTemplate.findOne(query, UserEntity.class);
    }

    public UserEntity updateOneUser(UserEntity user) {
        mongoTemplate.save(user);
        return user;
    }

    public UserEntity findUserByToken(String token) {
        Query query = new Query();
        query.addCriteria(Criteria.where("token").is(token));
        return mongoTemplate.findOne(query, UserEntity.class);
    }

    public GroupEntity findGroupById(String id) {
        Query query = new Query();
        query.addCriteria(Criteria.where("_id").is(id));
        return mongoTemplate.findOne(query, GroupEntity.class);
    }

    public GroupEntity saveGroup(GroupEntity groupEntity) {
        return mongoTemplate.save(groupEntity);
    }

    public List<GroupEntity> findAllGroups() {
        return mongoTemplate.findAll(GroupEntity.class);
    }
}
