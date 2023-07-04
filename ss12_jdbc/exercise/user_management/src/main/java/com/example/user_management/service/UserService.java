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

    @Override
    public void insertUser(User newUser) {
        userRepository.insertUser(newUser);
    }

    @Override
    public User selectUser(int id) {
        return userRepository.selectUser(id);
    }

    @Override
    public void updateUser(User updatedUser) {
        userRepository.updateUser(updatedUser);
    }

    @Override
    public void deleteUser(int id) {
        userRepository.deleteUser(id);
    }

    @Override
    public List<User> searchByCountry(String searchStr) {
        return userRepository.searchByCountry(searchStr);
    }

    @Override
    public List<User> sortByName() {
        return userRepository.sortByName();
    }
}
