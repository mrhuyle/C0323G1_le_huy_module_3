package com.example.user_management.repository;

import com.example.user_management.model.User;

import java.util.List;

public interface IUserRepository {
    List<User> selectAllUsers();

    void insertUser(User newUser);
}
