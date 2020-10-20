package com.backend.controller.groups;

import com.backend.entity.GroupEntity;
import com.backend.entity.LoginResponse;
import com.backend.entity.UserEntity;
import com.backend.repository.SocialHabitAppData;
import org.springframework.http.MediaType;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
public class GroupsController {
    private final SocialHabitAppData repository;

    GroupsController(SocialHabitAppData repository) {
        this.repository = repository;
    }

    /*
    * Add new group in database and it's groupId to owner
    * It's need in full group entity. See GroupEntity @PersistenceConstructor
    */
    @PostMapping(value = "/api/addGroup", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity addGroupEntity(@RequestBody GroupEntity group) {
        if (!group.isValid()) {
            throw new GroupNotValidException();
        }
        String currentId = group.getId();
        if (repository.findGroupById(currentId) != null) {
            throw new GroupIdExistException();
        }
        UserEntity user = repository.findUserById(group.getOwner());
        if (user != null) {
            user.addGroup(group.getId());
            repository.saveUser(user);
        }
        return repository.saveGroup(group);
    }

    /*
     * Add new empty group with some obligatory parameters and it's groupId to owner
     */

    @PostMapping(value = "/api/addEmptyGroup", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity addEmptyGroupEntity(@RequestParam String owner, @RequestParam String groupName,
                                           @RequestParam String groupCategory, @RequestParam int membersLimit) {
        GroupEntity group = new GroupEntity(owner, groupName, membersLimit, groupCategory);
        if (!group.isValid()) {
            throw new GroupNotValidException();
        }
        if (repository.findGroupById(group.getId()) != null) {
            throw new GroupIdExistException();
        }
        UserEntity user = repository.findUserById(owner);
        if (user != null) {
            user.addGroup(group.getId());
            repository.saveUser(user);
        }
        else throw new UsernameNotFoundException(owner);
        return repository.saveGroup(group);
    }

    /*
     * Return list of all groups.
     */

    @GetMapping(value = "/api/groups", produces = {MediaType.APPLICATION_JSON_VALUE})
    public List<GroupEntity> getAllGroups() {
        return repository.findAllGroups();
    }

    /*
     * Add new member to existing group and it's groupId to member.
     */
    @PutMapping(value = "/api/addMemberToGroup", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity addMember(@RequestParam("ownerLogin") String owner, @RequestParam("memberLogin") String newMember,
                                 @RequestParam("groupId") String groupId) throws Exception {
        if (repository.findGroupById(groupId) == null) {
            throw new GroupNotValidException();
        }

        UserEntity user = repository.findUserById(newMember);

        if (user == null) {
            throw new UsernameNotFoundException(newMember);
        }

        user.addGroup(groupId);
        repository.saveUser(user);
        return repository.saveGroup(repository.findGroupById(groupId).ifOwner(owner).addMember(newMember));
    }

}
