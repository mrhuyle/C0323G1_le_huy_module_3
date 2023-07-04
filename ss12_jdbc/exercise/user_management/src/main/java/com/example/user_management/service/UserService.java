package com.example.user_management.service;

import com.example.user_management.model.User;
import com.example.user_management.repository.IUserRepository;
import com.example.user_management.repository.UserRepository;

import java.util.List;

public class UserService implements IUserService {
    private static IUserRepository userRepository = new UserRepository();

    @Override
    public List<User> selectAllUsers() {
       return userRepository.selectAllUsers();
    }
}
