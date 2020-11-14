package com.backend.controller.groups;

import com.backend.entity.CategoryEntity;
import com.backend.entity.GroupEntity;
import com.backend.entity.LoginResponse;
import com.backend.entity.UserEntity;
import com.backend.repository.SocialHabitAppData;
import org.springframework.http.MediaType;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

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
    public GroupEntity getGroupById(@RequestParam("groupId") String groupId) {
        GroupEntity group = repository.findGroupById(groupId);
        if (group == null) {
            throw new GroupNotValidException();
        }
        return group;
    }

    /*
     * Add new member to existing group and it's groupId to member.
     */
    @PutMapping(value = "/api/addMemberToGroup", produces = {MediaType.APPLICATION_JSON_VALUE})
    public GroupEntity addMember(@RequestParam("ownerLogin") String owner, @RequestParam("memberLogin") String newMember,
                                 @RequestParam("groupId") String groupId) throws Exception {
        GroupEntity group = repository.findGroupById(groupId);
        UserEntity user = repository.findUserById(newMember);
        if (group == null) {
            throw new GroupNotValidException();
        }
        if (user == null) {
            throw new UsernameNotFoundException(newMember);
        }
        group.ifOwner(owner).addMember(newMember);
        user.addGroup(groupId);
        repository.saveUser(user);
        return repository.saveGroup(group);
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
    public CategoryEntity addCategory(@RequestParam String category) {
        CategoryEntity categoryEntity = new CategoryEntity(category);
        return repository.saveCategory(categoryEntity);
    }
}
