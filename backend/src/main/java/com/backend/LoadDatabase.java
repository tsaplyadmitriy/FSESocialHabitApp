package com.backend;

import com.backend.entity.UserEntity;
import com.backend.repository.SocialHabitAppData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;


/*
**Preload some entities on database for debugging
* Can be commented and excluded
 */
@Configuration
class LoadDatabase {

    private static final Logger log = LoggerFactory.getLogger(LoadDatabase.class);

    @Bean
    CommandLineRunner initDatabase(SocialHabitAppData repository) {
        List<String> sampleTags = new ArrayList<>();
        sampleTags.add("Tag1");
        sampleTags.add("Tag2");
        return args -> {
            log.info("Preloading " + repository.saveUser(new UserEntity("SomeLogin", "12345",
                    "Alex", "Rakov", "Some description", sampleTags, 20)));
            log.info("Preloading " + repository.saveUser(new UserEntity("JohnLogin", "123456789",
                    "John", "Smith", "Another description", sampleTags, 25)));
        };
    }
}