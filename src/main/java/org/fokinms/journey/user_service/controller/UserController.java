package org.fokinms.journey.user_service.controller;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.fokinms.journey.user_service.dto.UserDto;
import org.fokinms.journey.user_service.service.UserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/user/{userId}")
    public UserDto findUserById(@NonNull @PathVariable Long userId) {
        return userService.findUserById(userId);
    }

    @GetMapping("/all")
    public List<UserDto> findAllUsers() {
        return userService.findAllUsers();
    }
}
