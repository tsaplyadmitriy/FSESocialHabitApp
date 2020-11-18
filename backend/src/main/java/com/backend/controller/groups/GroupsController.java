package com.backend.controller.groups;

import com.backend.entity.*;
import com.backend.repository.SocialHabitAppData;
import org.springframework.hateoas.EntityModel;
import org.springframework.http.MediaType;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

import javax.swing.*;
import java.util.ArrayList;
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
            if(!group.getMembersLogins().contains(user)) {
                group.getMembersLogins().add(user);
            }
        }

        return repository.saveGroup(group);
    }

    /*
     * Add new empty group with some obligatory parameters and it's groupId to owner
     */

    @PostMapping(value = "/api/addEmptyGroup", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity addEmptyGroupEntity(@RequestParam String owner, @RequestParam String groupName, @RequestParam String groupTgLink,
                                           @RequestParam String groupCategory, @RequestParam int membersLimit) {
        GroupEntity group = new GroupEntity(owner, groupName, groupCategory, groupTgLink, membersLimit);
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
     * Return entity of group by it's ID
     */

    @GetMapping(value = "/api/findGroups/groupId", produces = {MediaType.APPLICATION_JSON_VALUE})
    public EntityModel<GroupEntity> getGroupById(@RequestParam("groupId") String groupId) {
        GroupEntity group = repository.findGroupById(groupId);
        if (group == null) {
            throw new GroupNotValidException();
        }
        return EntityModel.of(group);
    }

    /*
     * Update existing group
     */

    @PutMapping(value = "/api/updateGroup", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity updateGrooup(@RequestBody GroupEntity updatedGroup) {
        GroupEntity group = repository.findGroupById(updatedGroup.getId());
        if (group == null || !updatedGroup.isValid()) {
            throw new GroupNotValidException();
        }

        group = updatedGroup;

        return repository.saveGroup(group);
    }

    @GetMapping(value = "/api/findGroups/category", produces = {MediaType.APPLICATION_JSON_VALUE})
    public List<GroupEntity> getGroupsByCategory(@RequestParam String category) {
        List<GroupEntity> groups = repository.findGroupsByCategory(category);
        if (groups == null) {
            //TODO: Create exception
            throw new GroupNotValidException();
        }
        return groups;
    }

    @GetMapping(value = "/api/findGroups/login", produces = {MediaType.APPLICATION_JSON_VALUE})
    public List<GroupEntity> getGroupsByLogin(@RequestParam String login) {
        UserEntity user = repository.findUserById(login);
        if (user == null) throw new UsernameNotFoundException(login);
        List<String> groupsId = user.getUserGroups();
        List<GroupEntity> groups = new ArrayList<>();
        for (int i = 0; i < groupsId.size(); i++) {
            groups.add(repository.findGroupById(groupsId.get(i)));
        }
        return groups;
    }

    @GetMapping(value = "/api/categories", produces = {MediaType.APPLICATION_JSON_VALUE})
    public List<CategoryEntity> getCategories() {
        return repository.findAllCategories();
    }

    @PostMapping(value = "/api/addCategory", produces = {MediaType.APPLICATION_JSON_VALUE})
    public List<CategoryEntity> addCategory(@RequestParam String category) {
        CategoryEntity categoryEntity = new CategoryEntity(category);
        repository.saveCategory(categoryEntity);
        return repository.findAllCategories();
    }

    @PutMapping(value = "/api/addChallenge", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity addChallenge(@RequestParam String groupId, @RequestParam String challengeName, @RequestParam String challengeDescription) {
        GroupEntity group = repository.findGroupById(groupId);
        if (group != null) {
            group.addNewChallenge(challengeName, challengeDescription);
        }
        return repository.saveGroup(group);
    }

    @PutMapping(value = "/api/addMember", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity addMember(@RequestParam String groupId, @RequestParam String login) {
        GroupEntity group = repository.findGroupById(groupId);
        UserEntity user = repository.findUserById(login);
        if (group != null && user != null) {
            user.addGroup(groupId);
            group.addMember(user);
        }

        repository.saveUser(user);
        return repository.saveGroup(group);
    }

    @PutMapping(value = "/api/addPending", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity addPending(@RequestParam String groupId, @RequestParam String login) {
        GroupEntity group = repository.findGroupById(groupId);
        UserEntity user = repository.findUserById(login);
        if (group != null && user != null) {
            user.addGroup(groupId);
            group.addPendingUser(user);
        }

        return repository.saveGroup(group);
    }

    @PutMapping(value = "/api/declinePending", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity declinePending(@RequestParam String groupId, @RequestParam String login) {
        GroupEntity group = repository.findGroupById(groupId);
        UserEntity user = repository.findUserById(login);
        if (group != null && user != null) {
            user.removeGroup(groupId);
            group.removePendingUser(user);
        }
        repository.saveUser(user);
        return repository.saveGroup(group);
    }

    @DeleteMapping(value = "/api/removeUserFromGroup", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity removeUserFromGroup(@RequestParam String groupId, @RequestParam String login) {
        GroupEntity group = repository.findGroupById(groupId);
        UserEntity user = repository.findUserById(login);
        if (group == null) {
            throw new GroupNotValidException();
        }
        if (user != null) {
            user.removeGroup(groupId);
            group.removeUser(user);
            repository.saveUser(user);
        }
        return repository.saveGroup(group);
    }

    @GetMapping(value = "/api/findGroups/getUserGroups", produces = {MediaType.APPLICATION_JSON_VALUE})
    public List<GroupEntity> getUserGroups(@RequestParam String login) {
        UserEntity user = repository.findUserById(login);
        List<GroupEntity> groups = new ArrayList<>();
        if (user != null) {
            List<String> userGroups = user.getUserGroups();
            for (int i = 0; i < userGroups.size(); i++) {
                GroupEntity group = repository.findGroupById(userGroups.get(i));
                if (group != null) {
                    groups.add(group);
                }
            }

        }
        return groups;
    }
}
