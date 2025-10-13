package org.fokinms.journey.user_service.mapper;

import org.fokinms.journey.user_service.dto.UserDto;
import org.fokinms.journey.user_service.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserMapper {
    
    UserDto toDto(User user);
    User toEntity(UserDto userDto);

    List<UserDto> toDtos(List<User> users);
}
