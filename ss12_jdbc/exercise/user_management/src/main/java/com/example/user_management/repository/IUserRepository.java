package com.example.user_management.repository;

import com.example.user_management.model.User;

import java.util.List;

public interface IUserRepository {
    List<User> selectAllUsers();

    void insertUser(User newUser);

    User selectUser(int id);

    boolean updateUser(User updatedUser);

    boolean deleteUser(int id);

    List<User> searchByCountry(String searchStr);

    List<User> sortByName();

    User getUserById(int id);

    void insertUserStore(User user);

    List<User> selectAllStored ();
    boolean updateUserStored(User updatedUser);
    boolean deleteUserStored(int id);
}
