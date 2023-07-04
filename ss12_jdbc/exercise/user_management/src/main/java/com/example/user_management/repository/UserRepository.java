package com.example.user_management.repository;

import com.example.user_management.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserRepository implements IUserRepository {
    private static BaseRepository baseRepository = new BaseRepository();
    //MySQL URL:
    private static final String SELECT_ALL_USERS = "SELECT * FROM users";

    @Override
    public List<User> selectAllUsers() {
        //Create list
        List<User> users = new ArrayList<>();
        //Step 1: Establish a Connection
        Connection connection = BaseRepository.getConnection();
        //Step 2: Create a statement using connection object
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS);
            //Step 3: Execute the query or update query
            ResultSet resultSet = preparedStatement.executeQuery();
            //Step 4: Process the ResultSet object and add to list
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                users.add(new User(id, name, email, country));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }


    //Method:


}
