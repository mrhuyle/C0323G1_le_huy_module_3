package com.example.user_management.service;

import com.example.user_management.model.User;

import java.util.List;

public interface IUserService {
    List<User> selectAllUsers();

    void insertUser(User newUser);

    User selectUser(int id);

    void updateUser(User updatedUser);

    void deleteUser(int id);

    List<User> searchByCountry(String searchStr);

    List<User> sortByName();

    User getUserById(int id);

    void insertUserStore(User user);

    List<User> selectAllStored();
    void updateUserStored(User updatedUser);
    void deleteUserStored(int id);
}
