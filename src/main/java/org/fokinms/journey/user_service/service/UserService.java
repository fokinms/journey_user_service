package org.fokinms.journey.user_service.service;

import lombok.RequiredArgsConstructor;
import org.fokinms.journey.user_service.dto.UserDto;
import org.fokinms.journey.user_service.exception.UserNotFoundException;
import org.fokinms.journey.user_service.mapper.UserMapper;
import org.fokinms.journey.user_service.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final UserMapper userMapper;

    public UserDto findUserById(Long userId) {
        return userMapper.toDto(userRepository.findById(userId)
                .orElseThrow(() -> new UserNotFoundException(String.format("User not found with id: %d", userId))));
    }

    public List<UserDto> findAllUsers() {
        return userMapper.toDtos(userRepository.findAll());
    }
}