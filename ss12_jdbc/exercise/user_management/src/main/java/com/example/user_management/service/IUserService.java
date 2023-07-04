package com.example.user_management.service;

import com.example.user_management.model.User;

import java.util.List;

public interface IUserService {
    List<User> selectAllUsers();

    void insertUser(User newUser);
}
