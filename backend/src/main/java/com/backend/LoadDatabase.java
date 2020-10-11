package com.backend;

import com.backend.entity.UserEntity;
import com.backend.repository.UserEntityRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


/*
**Preload some entities on database for debugging
* Can be commented and excluded
 */
@Configuration
class LoadDatabase {

    private static final Logger log = LoggerFactory.getLogger(LoadDatabase.class);

    @Bean
    CommandLineRunner initDatabase(UserEntityRepository repository) {

        return args -> {
            log.info("Preloading " + repository.save(new UserEntity("SomeLogin", "12345", "Alex", "Rakov", 20)));
            log.info("Preloading " + repository.save(new UserEntity("JohnLogin", "123456789", "John", "Smith", 30)));
        };
    }
}