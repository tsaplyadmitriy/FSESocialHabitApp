package com.backend.repository;

import com.backend.entity.UserEntity;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserEntityRepository extends MongoRepository<UserEntity, String> {
    public UserEntity findByToken(String token);
}
