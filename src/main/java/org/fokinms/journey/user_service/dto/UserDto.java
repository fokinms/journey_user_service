package org.fokinms.journey.user_service.dto;

import java.time.LocalDateTime;

public record UserDto(Long id,
                      String userName,
                      String name,
                      String surname,
                      String email,
                      LocalDateTime createdAt,
                      LocalDateTime updatedAt) {
}
